;;; -*- Mode: LISP; Base: 10; Syntax: ANSI-Common-Lisp; Package: PLOTVIEW -*-
;;; Copyright (c) 2023 by Symbolics Pte. Ltd. All rights reserved.
;;; Copyright (c) 2023 by Mikel Evins All rights reserved.
;;; SPDX-License-identifier: MS-PL

;;; This route serves the HTML + JavaScript page for a plot.  Intended
;;; to replace the mechanism of writing HTML to disk and then calling
;;; a browser with a command line argument to display it.  This will
;;; need to be developed in conjunction with the plotview / webview
;;; framework.

;;; Here we look only in the vega:*all-plots* hash table.  Revisit
;;; this when we have more than one plotting back end.

(hunchentoot:define-easy-handler (plot :uri "/plot") (name slot)
  (alexandria+:unlessf slot "spec")
  (let (;(p (gethash (find-symbol (string-upcase name) (find-package "VEGA")) vega::*all-plots*))) ;TODO change to exported symbol once PLOT:src;vega;pkgdcl is updated
	(p (gethash (string-upcase name) vega::*all-plots*)))
    (with-output-to-string (s)
      (alexandria:eswitch (slot :test #'string=)
	("spec" (setf (hunchentoot:content-type*) "application/json")
		(let ((yason:*symbol-encoder*     'vega::encode-symbol-as-metadata)
		      (yason:*symbol-key-encoder* 'vega::encode-symbol-as-metadata))
		  (vega:write-spec p :spec-loc s)))
	("data" (setf (hunchentoot:content-type*) "application/json")
		(let ((yason:*symbol-encoder*     'vega::encode-symbol-as-metadata)
		      (yason:*symbol-key-encoder* 'vega::encode-symbol-as-metadata))
		  (vega:write-spec p :data-loc s)))))))
