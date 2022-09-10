;;;; ***********************************************************************
;;;;
;;;; Name:          plotview.asd
;;;; Project:       the plotview plotting UI for SBCL
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
  :description "Plotview: an HTML plotting UI for SBCL"
  :author "mikel evins <mikel@evins.net>"
  :license  "MIT"
  :version "0.0.1"
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

#+nil (plotview::start-server plotview::*http-server-port*)
#+nil (plotview::runapp :port plotview::*neutralino-application-port* :mode "chrome")
#+nil (plotview::runapp :port plotview::*neutralino-application-port* :mode "window")
;;; now open the devtools window in the running app, then send a message to it:
#+nil (trivial-ws:send (first (trivial-ws:clients plotview::*websocket-server*)) "{\"name\": \"Goodbye!\"}")

#+nil (plotview::stop-server)
