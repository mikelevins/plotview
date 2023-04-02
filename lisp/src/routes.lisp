
(in-package :plotview)

(hunchentoot:define-easy-handler (landing :uri "/") ()
  (setf (hunchentoot:content-type*) "text/html")
  (setf (hunchentoot:header-out "Clear-Site-Data") "\"cache\"")
  (landing-page))


