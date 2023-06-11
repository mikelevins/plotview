;;;; plotview.lisp

(in-package #:plotview)

(defclass plotview-server (hunchentoot:easy-acceptor)
  ()
  (:metaclass singleton-class))

(defmethod print-object ((server plotview-server) stream)
  (print-unreadable-object (server stream :type t :identity t)
    (format stream "\(host ~A, port ~A)"
            (or (hunchentoot:acceptor-address server) "*")
            (hunchentoot:acceptor-port server))))


(defun the-plotview-server ()
  (make-instance 'plotview-server))

(defun reset-the-plotview-server ()
  (reset-singleton-class (find-class 'plotview-server)))

#+nil (the-plotview-server)
#+nil (reset-the-plotview-server)
