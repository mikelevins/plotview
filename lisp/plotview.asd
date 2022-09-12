;;;; plotview.asd

(asdf:defsystem #:plotview
  :description "Describe plotview here"
  :author "Your Name <your.name@example.com>"
  :license  "Specify license here"
  :version "0.0.1"
  :serial t
  :depends-on (:hunchentoot :trivial-ws :parenscript :st-json :cl-who :lass :find-port)
  :components ((:file "package")
               (:file "parameters")
               (:file "http-server")))

#+nil (asdf:load-system :plotview)
#+nil (plotview::start-server plotview::*http-server-port*)
#+nil (plotview::stop-server)
