;;;; ***********************************************************************
;;;; 
;;;; Name:          app.lisp
;;;; Project:       clio
;;;; Purpose:       code to launch the neutralino binary with appropriate arguments
;;;; Author:        mikel evins
;;;; Copyright:     2021 by mikel evins
;;;;
;;;; ***********************************************************************

(in-package :clio)

(defun clio-root ()(asdf:system-relative-pathname :cliocl ""))

(defun neutralino-path ()
  #+(or macos darwin)
  (asdf:system-relative-pathname :cliocl "bin/neutralino-mac_x64")
  #+(or win32 mswindows windows)
  (asdf:system-relative-pathname :cliocl "bin/neutralino-win_x64.exe")
  #+linux
  (asdf:system-relative-pathname :cliocl "bin/neutralino-linux_x64"))

;;; see https://neutralino.js.org/docs/cli/internal-cli-arguments/
;;; for documentation of the neutralinojs internal CLI arguments

(defun %build-runapp-args (&key
                             (mode "chrome") ; chrome | window | browser | cloud
                             (port *neutralino-application-port*))
  (list "--load-dir-res"
        "--window-title=clio"
        "--enable-extensions=true"
        (format nil "--path=~A" (namestring (clio-root)))
        (format nil "--port=~A" port)
        (format nil "--mode=~A" mode)))

(defparameter *app-process* nil)

(defun runapp (&key (port *neutralino-application-port*)(mode "chrome"))
  (let ((args (%build-runapp-args :port port :mode mode)))
    (setf *app-process* (sb-ext:run-program (neutralino-path) args))))

#+nil (%build-runapp-args :port 10101 :mode "window")
#+nil (runapp :port 10101 :mode :chrome)
