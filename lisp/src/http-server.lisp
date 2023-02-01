
(in-package #:plotview)

(defun parse-message (msg)
  (handler-case
      (let* ((msg-object (yason:parse msg :object-as :alist)))
        msg-object)
    (error (err)
      (warn "JSON parse error ~S: found value ~S" err msg)
      nil)))

(defun get-key (alist key &optional (default nil))
  (let ((entry (assoc key alist :test 'equal)))
    (if entry
        (cdr entry)
        default)))

#+nil (get-key (parse-message "{\"message\":\"doDrawStroke\"}") "message" nil)

(defun handle-message (msg)
  (let ((val (parse-message msg)))
    (if val
        (let ((message-name (get-key val "message" nil)))
          (cond ((equal message-name "dodrawstroke")
                 (draw-stroke))
                ((equal message-name "doclearcanvas")
                 (clear-canvas))
                (t (format t "~%Unrecognized message: ~S" msg))))
        (format t "~%Unparseable message: ~S" msg))))

(defun start-server (port)
  (setf *http-server* (make-instance 'hunchentoot:easy-acceptor :port port :document-root (http-document-root)))
  (setf *websocket-server*
        (trivial-ws:make-server
         :on-connect #'(lambda (server)(format t "Connected~%"))
         :on-disconnect #'(lambda (server)(format t "Disconnected~%"))
         :on-message #'(lambda (server message)(handle-message message))))
  (hunchentoot:start *http-server*)
  (setf *websocket-handler* (trivial-ws:start *websocket-server* *websocket-port*)))

(defun stop-server ()
  (trivial-ws:stop *websocket-handler*)
  (hunchentoot:stop *http-server*))

#+nil (trivial-ws:clients plotview::*websocket-server*)
