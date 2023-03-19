
(in-package :plotview)

(hunchentoot:define-easy-handler (landing :uri "/") ()
  (setf (hunchentoot:content-type*) "text/html")
  (landing-page))


(hunchentoot:define-easy-handler (vegatest :uri "/vegatest") ()
  (setf (hunchentoot:content-type*) "text/html")
  (vegatest-page))


