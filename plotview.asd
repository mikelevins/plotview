;;;; plotview.asd

(eval-when (:compile-toplevel :load-toplevel :execute)
  (pushnew :HUNCHENTOOT-NO-SSL *features*))

(asdf:defsystem #:plotview
  :description "Describe plotview here"
  :author "Your Name <your.name@example.com>"
  :license  "Specify license here"
  :version "0.0.1"
  :serial t
  :depends-on (;; general infrastructure
               :singleton-classes :cl-json :sxql
               ;; webapp tools
               :hunchentoot :trivial-ws :cl-who :parenscript :cl-css)
  :components ((:module "src"
                :serial t
                :components ((:file "package")
                             (:file "plotview")))))

#+nil (ql:quickload :plotview)
