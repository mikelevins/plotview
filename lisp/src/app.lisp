(in-package :cl-user)

(defun http-document-root ()
  "find the document root for the HTTP server"
  (merge-pathnames "resources/"
                   (make-pathname
                    :device (pathname-device (first sb-ext:*posix-argv*))
                    :directory (pathname-directory (first sb-ext:*posix-argv*)))))

#+nil (http-document-root)

(defun main ()
  (plotview::start-server 20202)
  (progn
        #+win32 (setf trivial-open-browser::+format-string+ "start msedge ~S")
        (trivial-open-browser:open-browser "http://127.0.0.1:20202"))
  (sb-impl::toplevel-init))

#+nil (cl-user::main)
