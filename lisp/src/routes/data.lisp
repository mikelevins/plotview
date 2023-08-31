;;; -*- Mode: LISP; Base: 10; Syntax: ANSI-Common-Lisp; Package: PLOTVIEW -*-
;;; Copyright (c) 2023 by Symbolics Pte. Ltd. All rights reserved.
;;; Copyright (c) 2023 by Mikel Evins All rights reserved.
;;; SPDX-License-identifier: MS-PL
(in-package #:plotview)

;;; Data server - routes for a REST-like API

;;; The purpose of these routes is to provide HTTP access to data sets
;;; in the CL image.  There are two versions, a parameter driven API
;;; and a 'clean url' version.  See https://en.wikipedia.org/wiki/Clean_URL

;;; The parameter version is disabled.  What I like about the parameter
;;; version is you can specify only the parameters you want.  What I
;;; like about the clean version is that you don't have to expose
;;; implementation details to the users.  I suppose both could
;;; co-exist in the same image. (?)

;;; There are four schemas we'd like to support:
;;;   1. VEGA, for plotting
;;;   2. CSV, for generic data retrieval
;;;   3. SEXP, to send data frames as Common Lisp objects
;;;   4. DT, data-table, to support the JavaScript Data Table display

;;; Alternatives considered:
;;; easy-routes https://github.com/mmontone/easy-routes.  Rejected
;;; because it's based on RESTAS, which has a LGPL license.  A shame.
;;; Perhaps we can, if necessary, re-implement some of these ideas.

;;; Note: It is not appear possible to run both of these services,
;;; as-is, at the same time because they 'compete' for the /data URL.
;;; It should be possible to oversome this, either by narrowing the
;;; scope of the regex-dispatcher or, at worst, using a different url
;;; prefix.


;;;
;;; Clean URL data server
;;;

;;; The regex for this route matches /data/package/symbol/format
;;; 'clean' URLs.  The format part is optional.  See the notes.org
;;; file for hints on working with ppcre and regex expressions.
;;; Regex's for paths aren't straightforward and prone to error due to
;;; the special characters and escaping.

;;; Example: http://localhost/data/ls-user/mtcars will return the data
;;; for the MTCARS data frame in VEGA format (the default).
;;; http://localhost/data/ls-user/mtcars/csv will return the contents
;;; of the data frame as a CSV file.  What I don't like about this
;;; example is that we must include the package.  It's nice for it to
;;; be optional, as in nearly every case the user will be in the
;;; LS-USER package.  Perhaps there's a way to default this and omit
;;; it from the URL?

(defun df-json ()
  (let+ (((&values &ign #(pkg sym schema)) (ppcre:scan-to-strings "^/data/([\\w\\-]*)/([\\w\\-]*)/*([\\w\\-]*)"
								  (hunchentoot:script-name*)))
		  (df-pkg (find-package (string-upcase pkg)))
		  (df     (find-symbol  (string-upcase sym) df-pkg))
		  (data   (symbol-value df))
		  (yason:*symbol-encoder*     'vega::encode-symbol-as-metadata)
		  (yason:*symbol-key-encoder* 'vega::encode-symbol-as-metadata))

    ;; Should this produce an error page?  Right now if it's not one
    ;; of the allowed types we get an "internal server error".
    ;; However since it's meant to be part of a REST API, maybe an
    ;; error condition?
    #+nil
    (if schema
	(assert (member schema '(vega sexp csv dt))
		()
		"schema must be one of: vega sexp csv dt"))

    ;; These are neccessary to avoid a CORS error on the Vega
    ;; side.  My reading suggests that if the HTML page is served from
    ;; Hunchentoot, then this won't be neccessary
    (setf (hunchentoot:header-out "Access-Control-Allow-Origin") "*")
    (setf (hunchentoot:header-out "Access-Control-Allow-Methods") "POST,GET,OPTIONS,DELETE,PUT")
    (setf (hunchentoot:header-out "Access-Control-Max-Age") 1000)
    (setf (hunchentoot:header-out "Access-Control-Allow-Headers")
	  "x-requested-with, Content-Encoding, Content-Type, origin, authorization, accept, client-security-token")

    (with-output-to-string (s)
      (alexandria:switch (schema :test #'string=)
	("vega" (setf (hunchentoot:content-type*) "application/json")
		(yason:encode data s))
	("sexp" (setf (hunchentoot:content-type*) "text/s-expression") ;does a sexp content type exist?
		(dfio:write-df df s))
	("csv"  (setf (hunchentoot:content-type*) "text/csv")
		(dfio:write-csv data s :add-first-row t))
	("dt" (setf (hunchentoot:content-type*) "application/json")
	      (let ((yason:*symbol-encoder*     'vega::encode-symbol-as-metadata) ; these may no longer be needed
		    (yason:*symbol-key-encoder* 'vega::encode-symbol-as-metadata))
		(yason:with-output (s)
		  (yason:with-object ()
		    ;; (yason:encode-object-element "data" data))) ;if you want an object called 'data'
		    (yason:encode-object-element sym data)))))
	(t (setf (hunchentoot:header-out "Content-Type") "application/json")
	   (yason:encode data s))))))


;;; Managing the dispatch-table seems to be the raison d'être for many
;;; of the add-on systems for Hunchentoot routing, and this seems like
;;; a classic bike-shed problem.  The regex-dispatcher and ppcre
;;; matching are doing the parameter extraction from the URL that a
;;; route system would.  Let's beware of premature optimisation
;;; though.  With only 4 schemas and 3 routes, things are probably
;;; managable without a routing system.
;;; See:
;;;   https://www.darkchestnut.com/2019/http-routing-libraries-hunchentoot/
;;;   https://quickdocs.org/simple-routes
;;;   https://quickdocs.org/froute
;;;   https://github.com/lisp/de.setf.http
(setf hunchentoot:*dispatch-table* (nconc `(,(hunchentoot:create-regex-dispatcher
					      "^/data/([\\w\\-]*)/([\\w\\-]*)/*([\\w\\-]*)"
					      'df-json))))




;;;
;;; Parameterised data server
;;;

;;; To retrieve vgcars in a format for vega:
;;; http://localhost:20202/data?sym=vgcars&fmt=vega
#+nil
(hunchentoot:define-easy-handler (data :uri "/data") (pkg sym fmt)
  ;; set defaults
  (alexandria+:unlessf pkg "LS-USER")
  (alexandria+:unlessf fmt "vega")

  ;; We should probably just enforce the use of the LS-USER package
  ;; and DEFDF macros, but for now there are multiple ways to define a
  ;; data frame, so we look it up by symbol instead of searching the
  ;; DF:*DATA-FRAMES* list.
  (let* ((df-pkg (find-package (string-upcase pkg)))
	 (df     (find-symbol  (string-upcase sym) df-pkg))
	 (data   (symbol-value df)))

    ;; These appear neccessary to avoid an CORS error on the Vega
    ;; side.  My reading suggests that if the HTML page is served from
    ;; Hunchentoot, then this won't be neccessary
    (setf (hunchentoot:header-out "Access-Control-Allow-Origin") "*")
    (setf (hunchentoot:header-out "Access-Control-Allow-Methods") "POST,GET,OPTIONS,DELETE,PUT")
    (setf (hunchentoot:header-out "Access-Control-Max-Age") 1000)
    (setf (hunchentoot:header-out "Access-Control-Allow-Headers")
	  "x-requested-with, Content-Encoding, Content-Type, origin, authorization, accept, client-security-token")

    (with-output-to-string (s)
      (alexandria:eswitch (fmt :test #'string=)
	("vega" (setf (hunchentoot:content-type*) "application/json")
		(let ((yason:*symbol-encoder*     'vega::encode-symbol-as-metadata)
		      (yason:*symbol-key-encoder* 'vega::encode-symbol-as-metadata))
		  (yason:encode data s)))
	("sexp" (setf (hunchentoot:content-type*) "text/s-expression") ;does a sexp content type exist?
		(dfio:write-df df s))
	("csv"  (setf (hunchentoot:content-type*) "text/csv")
		(dfio:write-csv data s :add-first-row t))
	("dt" (setf (hunchentoot:content-type*) "application/json")
	      (let ((yason:*symbol-encoder*     'vega::encode-symbol-as-metadata)
		    (yason:*symbol-key-encoder* 'vega::encode-symbol-as-metadata))
		(yason:with-output (s)
		  (yason:with-object ()
		    ;; (yason:encode-object-element "data" data))) ;if you want an object called 'data'
		    (yason:encode-object-element sym data)))))))))


