(in-package :plotview)

(defun send-message (msg)
  (trivial-ws:send
   (first (trivial-ws:clients plotview::*websocket-server*))
   msg))

(defun clear-canvas ()
  (let ((msg (with-output-to-string (out)
               (yason::encode-plist '("message" "clear-canvas") out))))
    (send-message msg)))

(defun draw-stroke ()
  (let ((msg (with-output-to-string (out)
               (yason::encode-plist '("message" "draw-stroke") out))))
    (send-message msg)))


(defun plot (spec-json)
  (let ((msg (with-output-to-string (out)
               (yason::encode-plist `("message" "plot" "data" ,spec-json) out))))
    (send-message msg)))
