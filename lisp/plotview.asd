;;;; plotview.asd

;;; make sure we load hunchentoot at the start with
;;; :hunchentoot-no-ssl on *features*, so that we don't run into
;;; problems loading cl+ssl
(eval-when (:compile-toplevel :load-toplevel :execute)
  (pushnew :HUNCHENTOOT-NO-SSL *features*))


(asdf:defsystem #:plotview
  :description "Describe plotview here"
  :author "Your Name <your.name@example.com>"
  :license  "Specify license here"
  :version "0.0.1"
  :serial t
  :depends-on (:hunchentoot :trivial-ws :parenscript :yason :cl-who :lass :find-port)
  :components ((:file "package")
               (:file "parameters")
               (:file "http-server")
               (:file "routes")
               (:file "ui")))

#+nil (asdf:load-system :plotview)
#+nil (plotview::start-server plotview::*http-server-port*)
#+nil (plotview::stop-server)
#+nil (uiop:run-program (namestring (asdf:system-relative-pathname :plotview "../webview/plotview.exe")))
#+nil (uiop:run-program (namestring (asdf:system-relative-pathname :plotview "../webview/plotview")))
