(in-package :cl-user)
(ql:quickload :cffi)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (cffi::register-foreign-library
   'weblib '((:win32 "c:/Users/mikel/Workshop/plotview/gui/win64/webview.dll"))))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (cffi-sys::%load-foreign-library 'weblib "c:/Users/mikel/Workshop/plotview/gui/win64/webview.dll"))

#+nil
(eval-when (:compile-toplevel :load-toplevel :execute)
  (sb-int:set-floating-point-modes :traps nil))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (cffi::defcfun (webview_create "webview_create" :library weblib)(:pointer :void)
    (w :int)
    (p :pointer)))

(save-lisp-and-die "webviewlisp.exe"
                   :toplevel (lambda (&rest ignore)
                               (format t "~%hello~%")
                               (webview_create 0 (cffi:null-pointer))
                               (format t "~%goodbye~%"))
                   :executable t )
