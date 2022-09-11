;;;; ***********************************************************************
;;;;
;;;; Name:          plotview.asd
;;;; Project:       a plotting UI for sbcl
;;;; Purpose:       system definition
;;;; Author:        mikel evins
;;;; Copyright:     2022 by mikel evins
;;;;
;;;; ***********************************************************************

;;; ---------------------------------------------------------------------
;;; plotview
;;; ---------------------------------------------------------------------
;;; NOTE: use sbcl 2.2.3 on Windows 64; later versions are unable to
;;; load usocket or other quicklisp libraries due to package-lock and
;;; other issues

;;; make sure we load hunchentoot at the start with
;;; :hunchentoot-no-ssl on *features*, so that we don't run into
;;; problems loading cl+ssl
(eval-when (:compile-toplevel :load-toplevel :execute)
  (pushnew :HUNCHENTOOT-NO-SSL *features*))

(asdf:defsystem #:plotview
  :description "Clio: a Lisp development environment with HTML5 UI support"
  :author "mikel evins <mikel@evins.net>"
  :license  "MIT"
  :version "0.6.3"
  :depends-on (:hunchentoot :trivial-ws :parenscript :st-json :cl-who :lass :find-port)
  :serial t
  :components ((:module "lisp"
                :serial t
                :components ((:file "package")
                             (:file "parameters")
                             (:file "http-server")
                             (:file "state")
                             (:file "app")
                             (:file "ui")
                             (:file "routes")))))

#+nil (asdf:load-system :plotview)

#+nil (clio::start-server clio::*http-server-port*)
#+nil (clio::runapp :port clio::*neutralino-application-port* :mode "chrome")
#+nil (clio::runapp :port clio::*neutralino-application-port* :mode "window")
;;; now open the devtools window in the running app, then send a message to it:
#+nil (trivial-ws:send (first (trivial-ws:clients clio::*websocket-server*)) "{\"name\": \"Goodbye!\"}")

#+nil (clio::stop-server)
