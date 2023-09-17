;;;; plotview.asd

;;; make sure we load hunchentoot at the start with
;;; :hunchentoot-no-ssl on *features*, so that we don't run into
;;; problems loading cl+ssl
(eval-when (:compile-toplevel :load-toplevel :execute)
  (pushnew :HUNCHENTOOT-NO-SSL *features*))


(asdf:defsystem #:plotview
  :description "An HTML plotting UI for sbcl"
  :author "mikel evins <mikel@evins.net>"
  :license  "Apache 2.0"
  :version "0.0.1"
  :serial t
  :depends-on (:hunchentoot :trivial-ws :parenscript
                            :yason :cl-who :alexandria :alexandria+)
  :components ((:module "src"
                        :serial t
                        :components ((:file "package")
                                     (:file "parameters")
                                     (:file "http-server")
                                     (:file "routes")
                                     (:file "ui")
                                     (:file "drawing")
                                     (:file "testdata")))))


#+nil (ql:quickload :plotview)
#+nil (plotview::start-server plotview::*http-server-port*)
#+nil (plotview::open-plotview)
#+nil (plotview::stop-server)
