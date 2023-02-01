
(in-package :plotview)

(hunchentoot:define-easy-handler (landing :uri "/") ()
  (setf (hunchentoot:content-type*) "text/html")
  (landing-page))


;;;
;;; HTTP data & spec retrieval
;;;

;;; TODO error handling

#+nil
(hunchentoot:define-easy-handler (data :uri "/data") (pkg sym fmt)
  ;; set defaults
  (alexandria+:unlessf pkg "LS-USER")
  (alexandria+:unlessf fmt "csv")

  ;; We should probably just enforce the use of the LS-USER package
  ;; and DEFDF macros, but for now there are multiple ways to define a
  ;; data frame, so we look it up by symbol instead of searching the
  ;; DF:*DATA-FRAMES* list.
  (let* ((df-pkg (find-package (string-upcase pkg)))
	 (df     (find-symbol  (string-upcase sym) df-pkg))
	 (data   (symbol-value df)))
    (with-output-to-string (s)
		(alexandria:eswitch (fmt :test #'string=)
		  ("vega" (setf (hunchentoot:content-type*) "application/json")
			  (let ((yason:*symbol-encoder*     'vega::encode-symbol-as-metadata)
				(yason:*symbol-key-encoder* 'vega::encode-symbol-as-metadata))
			    (yason:encode data s)))
		  ("sexp" (setf (hunchentoot:content-type*) "text/s-expression") ;does a sexp content type exist?
			  (dfio:write-df df s))
		  ("csv"  (setf (hunchentoot:content-type*) "text/csv")
			  (dfio:write-csv data s :add-first-row t))
		  ("dt" (setf (hunchentoot:content-type*) "application/json")
			  (let ((yason:*symbol-encoder*     'vega::encode-symbol-as-metadata)
				(yason:*symbol-key-encoder* 'vega::encode-symbol-as-metadata))
			    (yason:with-output (s)
			      (yason:with-object ()
				;; (yason:encode-object-element "data" data))) ;if you want an object called 'data'
				(yason:encode-object-element sym data)))))))))

#+nil
(hunchentoot:define-easy-handler (table :uri "/table") (pkg sym)
  (alexandria+:unlessf pkg "LS-USER")
  (setf (hunchentoot:content-type*) "text/html")
  (let* ((df-pkg (find-package (string-upcase pkg)))
	 (df     (find-symbol  (string-upcase sym) df-pkg))
	 (data   (symbol-value df)))
      (data-table sym)))

