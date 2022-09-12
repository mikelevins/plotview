
(in-package #:plotview)

(defun start-server (port)
  (setf *http-server* (make-instance 'hunchentoot:easy-acceptor :port port :document-root (http-document-root)))
  (setf *websocket-server*
        (trivial-ws:make-server
         :on-connect #'(lambda (server)(format t "Connected~%"))
         :on-disconnect #'(lambda (server)(format t "Disconnected~%"))
         :on-message #'(lambda (server message)(format t "Received (~S): ~A~%" server message))))
  (hunchentoot:start *http-server*)
  (setf *websocket-handler* (trivial-ws:start *websocket-server* *websocket-port*)))

(defun stop-server ()
  (trivial-ws:stop *websocket-handler*)
  (hunchentoot:stop *http-server*))
