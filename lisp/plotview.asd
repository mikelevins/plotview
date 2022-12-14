;;;; plotview.asd

;;; make sure we load hunchentoot at the start with
;;; :hunchentoot-no-ssl on *features*, so that we don't run into
;;; problems loading cl+ssl
(eval-when (:compile-toplevel :load-toplevel :execute)
  (pushnew :HUNCHENTOOT-NO-SSL *features*))


(asdf:defsystem #:plotview
  :description "An HTML plotting UI for sbcl"
  :author "mikel evins <mikel@evins.net>"
  :license  "Apache 2.0"
  :version "0.0.1"
  :serial t
  :depends-on (:hunchentoot :trivial-ws :parenscript :yason :cl-who :alexandria :alexandria+)
  :components ((:file "package")
               (:file "parameters")
               (:file "http-server")
               (:file "routes")
               (:file "ui")
               (:file "drawing")
               (:file "testdata")))

#+nil (asdf:load-system :plotview)
#+nil (plotview::start-server plotview::*http-server-port*)
#+nil (plotview::stop-server)

#+nil (uiop:run-program
       (namestring (asdf:system-relative-pathname :plotview "../gui/win64/plotview.exe")))

#+nil (uiop:run-program
       (namestring (asdf:system-relative-pathname :plotview "../gui/macos-intel/plotview")))

#+nil (uiop:run-program
       (namestring (asdf:system-relative-pathname :plotview "../gui/macos-apple/plotview")))

#+nil (plotview::draw-stroke)
#+nil (plotview::clear-canvas)

#+nil (defparameter $testpath (namestring (asdf:system-relative-pathname :plotview "../data/simple-bar-chart.json")))
#+nil (defparameter $test-spec (plotview::read-testdata $testpath))

#+nil (plotview::clear-canvas)
#+nil (plotview::plot $test-spec)
