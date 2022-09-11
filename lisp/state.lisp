;;;; ***********************************************************************
;;;; 
;;;; Name:          state.lisp
;;;; Project:       clio
;;;; Purpose:       lisp application state
;;;; Author:        mikel evins
;;;; Copyright:     2022 by mikel evins
;;;;
;;;; ***********************************************************************

(in-package :clio)

;;; ---------------------------------------------------------------------
;;; Listener history
;;; ---------------------------------------------------------------------
;;; keep an ordered sequence of inputs and outputs from the repl window
;;; the sequence is a list of pairs, most recent first, where each pair is
;;; ( :input | :output . values-list)
;;; pairs of the form (:input . (expr)) are inputs from the repl; expr is
;;; a string to be read, evaluated, and printed, then returned to the repl window
;;; pairs of the form (:output . (v1 v2 ... vN)) are outputs from Lisp;
;;; the cdr contains one or more output values converted to strings by the printer
;;;
;;; when a repl window reloads, it requests the listener history and renders
;;; the sequence of inputs and outputs in reverse order, earliest first
;;; it renders only the values for each pair; not the pair itself or its car
;;; it renders inputs and outputs in distinct styles
;;;
;;; when the repl window sends an input to the Lisp, the Lisp prepends
;;; a new :input pair to the history, with the sent text as the expr;
;;; it then reads, evals, and prints the expr
;;;
;;; when the Lisp prints a return value, it prepends a new :output
;;; pair to the history containing all returned values in its cdr,
;;; then converts it to an html element and sends it back to the repl
;;; window for rendering

(defparameter *listener-history* nil)

