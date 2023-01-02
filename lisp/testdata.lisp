(in-package :plotview)

(defmethod read-testdata ((in stream))
  (let ((contents (make-string (file-length in))))
    (read-sequence contents in)
    contents))

(defmethod read-testdata ((inpath pathname))
  (with-open-file (in inpath)
    (read-testdata in)))

(defmethod read-testdata ((instring string))
  (read-testdata (pathname instring)))

