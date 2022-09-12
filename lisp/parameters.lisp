;;;; parameters.lisp

(in-package #:plotview)

(defparameter *http-server* nil)
(defparameter *http-server-port* 20202)

(defparameter *websocket-server* nil)
(defparameter *websocket-handler* nil)
(defparameter *websocket-port* 40404)

(defun http-document-root ()
  "find the document root for the HTTP server"
  (asdf:system-relative-pathname :plotview "resources/"))

