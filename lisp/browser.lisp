;;;; ***********************************************************************
;;;; 
;;;; Name:          browser.lisp
;;;; Project:       clio
;;;; Purpose:       controlling the browser process
;;;; Author:        mikel evins
;;;; Copyright:     2021 by mikel evins
;;;;
;;;; ***********************************************************************

(in-package :clio)

(defun open-browser (&key (port 8000))
  (let ((args (list (format nil "--app=http://localhost:~A" port))))
    #+(or win32 mswindows windows)
    (sb-ext:run-program "start chrome" args)
    #+(or macos darwin)
    (sb-ext:run-program "/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome" args)
    #+linux
    (sb-ext:run-program "/usr/bin/google-chrome" args)))

#+nil (open-browser)
