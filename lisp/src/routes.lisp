
(in-package :plotview)

(hunchentoot:define-easy-handler (landing :uri "/") ()
  (setf (hunchentoot:content-type*) "text/html")
  (landing-page))


;;;
;;; HTTP data & spec retrieval
;;;

;;; TODO error handling


