
(in-package #:plotview)

(defun start-server (port)
  (format t "~%setting http server...")
  (setf *http-server*
        (make-instance 'hunchentoot:easy-acceptor :port port :document-root (http-document-root)))
#|
  (format t "~%starting websocket server...")
  (setf *websocket-server*
        (trivial-ws:make-server
         :on-connect #'(lambda (server)(format t "Connected~%"))
         :on-disconnect #'(lambda (server)(format t "Disconnected~%"))
         :on-message #'(lambda (server message)(format t "~%Websocket received message: ~S" message))))
|#
  (format t "~%starting plotview server...")
  (hunchentoot:start *http-server*)
  #|  
  (format t "~%starting websocket server...")
  (setf *websocket-handler* (trivial-ws:start *websocket-server* *websocket-port*))
  (format t "~%servers started...")
  |#)

(defun stop-server ()
  (hunchentoot:stop *http-server*))

#+nil (trivial-ws:clients plotview::*websocket-server*)
