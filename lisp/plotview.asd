;;; -*- Mode: LISP; Base: 10; Syntax: ANSI-Common-Lisp; Package: PLOTVIEW -*-
;;; Copyright (c) 2023 by Symbolics Pte. Ltd. All rights reserved.
;;; Copyright (c) 2023 by Mikel Evins All rights reserved.
;;; SPDX-License-identifier: MS-PL

;;; make sure we load hunchentoot at the start with
;;; :hunchentoot-no-ssl on *features*, so that we don't run into
;;; problems loading cl+ssl
(eval-when (:compile-toplevel :load-toplevel :execute)
  (pushnew :HUNCHENTOOT-NO-SSL *features*))

(asdf:defsystem #:plotview
  :description "An HTML plotting UI for sbcl"
  :author "mikel evins <mikel@evins.net>"
  :license  "Apache 2.0"
  :version "0.0.2"
  :serial t
  :depends-on (:hunchentoot :trivial-ws :parenscript :yason :cl-who :alexandria :alexandria+ #:let-plus #:plot/vega) ;remove plot/vega when merged into the plot system
  :components ((:module "src"
                :serial t
                :components ((:file "package")
                             (:file "parameters")
                             (:file "http-server")
                             ;; (:file "routes")
                             (:file "ui")
                             (:file "drawing")
                             (:file "testdata")))

	       (:module routes
		:pathname "src/routes/"
		:components ((:file "routes")
			     (:file "data")
			     ;; (:file "table")
			     ;; (:file "plot")
			     ))))



#+nil (asdf:load-system :plotview)
#+nil (plotview::start-server plotview::*http-server-port*)
#+nil (plotview::stop-server)
