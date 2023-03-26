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

(eval-when (:compile-toplevel :load-toplevel :execute)
  (cffi::defcfun (webview_set_title "webview_set_title" :library weblib)(:pointer :void)
    (w :pointer)
    (title :string)))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (cffi::defcfun (webview_set_size "webview_set_size" :library weblib)(:pointer :void)
    (w :pointer)
    (width :int)
    (height :int)
    (hints :int)))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (cffi::defcfun (webview_navigate "webview_navigate" :library weblib)(:pointer :void)
    (w :pointer)
    (url :string)))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (cffi::defcfun (webview_run "webview_run" :library weblib)(:pointer :void)
    (w :pointer)))

(defparameter +webview-hint-none+ 0) ;; Width and height are default size
(defparameter +webview_hint_min+ 1)  ;; Width and height are minimum bounds
(defparameter +webview_hint_max+ 2)  ;; Width and height are maximum bounds
(defparameter +webview_hint_fixed+ 3);; Window size can not be changed by a user

(save-lisp-and-die "webviewlisp.exe"
                   :toplevel (lambda (&rest ignore)
                               (let ((w (webview_create 0 (cffi:null-pointer))))
                                 (webview_set_title w "webview")
                                 (webview_set_size w 600 400 +webview_hint_min+)
                                 (webview_navigate w "https://en.m.wikipedia.org/wiki/Main_Page")
                                 (webview_run w)))
                   :executable t )
