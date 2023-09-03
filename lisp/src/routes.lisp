
(in-package :plotview)

(hunchentoot:define-easy-handler (landing :uri "/") ()
  (setf (hunchentoot:content-type*) "text/html")
  (setf (hunchentoot:header-out "Clear-Site-Data") "\"cache\"")
  (landing-page))


(hunchentoot:define-easy-handler (vegatest :uri "/vegatest") ()
  (setf (hunchentoot:content-type*) "text/html")
  (setf (hunchentoot:header-out "Clear-Site-Data") "\"cache\"")
  (vegatest-page))

(defparameter $last-request-object nil)

(hunchentoot:define-easy-handler (vegaplot :uri "/vegaplot") ()
  (setf (hunchentoot:content-type*) "text/html")
  (setf (hunchentoot:header-out "Clear-Site-Data") "\"cache\"")
  (let* ((data-string (hunchentoot:raw-post-data :force-text t)))
    (plot data-string)))


