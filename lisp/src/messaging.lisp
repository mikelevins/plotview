(in-package :plotview)

(defun send-message (msg)
  (trivial-ws:send
   (first (trivial-ws:clients plotview::*websocket-server*))
   msg))
