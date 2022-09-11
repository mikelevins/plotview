;;;; ***********************************************************************
;;;; 
;;;; Name:          parameters.lisp
;;;; Project:       clio
;;;; Purpose:       global parameters
;;;; Author:        mikel evins
;;;; Copyright:     2022 by mikel evins
;;;;
;;;; ***********************************************************************

(in-package #:clio)

(defparameter *http-server* nil)
(defparameter *http-server-port* 20202)

(defparameter *neutralino-application-port* 10101)

(defparameter *websocket-server* nil)
(defparameter *websocket-handler* nil)
(defparameter *websocket-port* 40404)

(defun http-document-root ()
  "find the document root for the HTTP server"
  (asdf:system-relative-pathname :cliocl "resources/"))
