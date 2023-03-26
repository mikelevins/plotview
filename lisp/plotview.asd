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
    :components ((:module "src"
                          :serial t
                          :components ((:file "package")
                                       (:file "parameters")
                                       (:file "http-server")
                                       (:file "routes")
                                       (:file "ui")
                                       (:file "drawing")
                                       (:file "testdata")))))



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
#+nil (first (trivial-ws:clients plotview::*websocket-server*))

#+nil (plotview::clear-canvas)
#+nil (plotview::plot $test-spec)

#|
how to display the vegatest.html test page:

1. start plotview
2. right-click the content to open the inspector (and therefore the devtools window)
3. execute the following Javascript at the console:
   window.location.replace('http://localhost:20202/vegatest.html')
|#
