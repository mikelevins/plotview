;;; -*- Mode: LISP; Syntax: Ansi-Common-Lisp; Base: 10; Package: PLOTVIEW -*-
;;; Copyright (c) 2022 Symbolics Pte. Ltd. All rights reserved.
(in-package #:plotview)

;;; Lisp interface to DataTables
;;; https://www.datatables.net/

;;; TODO put this in a separate package

(defun data-table (name)
  (cl-who:with-html-output-to-string (s nil :prologue t)
    (:html
     (:head

      ;; Does data table, working in plotview, need these?
      ;; (:link :rel "stylesheet" :href "css/normalize.css")
      ;; (:link :rel "stylesheet" :href "css/plotview.css")

      (:link :rel "stylesheet" :href "https://cdn.datatables.net/1.12.1/css/jquery.dataTables.css")
      (:link :rel "icon":type "image/png" :href "icons/plotview-icon.png")
      (:title (cl-who:str name)))
     ;; (:title (cl-who:str (df:name data))))
     (:body
      ;; preloaded Javascript
      (:script :src "https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js")
      (:script :src "https://cdn.datatables.net/1.12.1/js/jquery.dataTables.min.js")

      ;; (:table :id (df:name data) :class "display" :width "100%")
      (:table :id "mtcars-table" :class "display" :width "100%")

      ;; (ps:ps (ps:lisp (keys mtcars)))
      ;; ['model', 'mpg', 'cyl', 'disp', 'hp', 'drat', 'wt', 'qsec', 'vs', 'am', 'gear', 'carb']

      ;; The vega format doesn't *quite* match what data-table wants.
      ;; They want {"data": ... where ... is what is returned.
      ;; I.e. they wrap it in a 'data' object.

      ;; Perhaps (ps:ps (ps:create "data" (ps:lisp (keys mtcars)))) How to insert the results of the call to the server?
      ;; (ps:ps
      ;; 	(defvar dataset "http://localhost:20202/data?sym=mtcars&fmt=vega"))


      ;; See: https://github.com/et4te/jquery-parenscript/blob/master/jquery-api.lisp
      #+nil
      (ps:defpsmacro domready (&body body) ; doesn't seem to work
	`(@ ($ document) ready
	  (lambda () ,@body)))

      #+nil
      (:script :type "text/javascript" ; this does work
               (cl-who:str
		(ps:ps (ps:chain ($ document)
				 (ready (lambda ()
					  (foo)))))))

      (:script :type "text/javascript"
               (cl-who:str
		(ps:ps (ps:chain ($ document)
				 (ready (lambda ()

					  (ps:chain ($ document)
						    DataTable ()

					  )))))

      (:script :type "text/javascript"
	       (cl-who:str
		(ps:ps
		  (domready
		   (ps:chain ($ document)
			     DataTable
			     (ps:create
			      :ajax (ps:create :url '/data?sym=~a&fmt=dt' :dataSrc 'mtcars'
					       )))))

		  )))


      ;; This works
      #+nil
      (:script :type "text/javascript"
	       (cl-who:fmt "
$(document).ready(function ()
{$('#mtcars-table').DataTable({
ajax: { url: '/data?sym=~a&fmt=dt',
        dataSrc: '~a' },
columns: [
{data: 'model', title: 'Model'},
{data: 'mpg', title: 'MPG'},
{data: 'cyl', title: 'Cylinders'},
{data: 'disp', title: 'Displacement'},
{data: 'hp', title: 'Horsepower'},
{data: 'drat', title: 'Axle Ratio'},
{data: 'wt', title: 'Weight'},
{data: 'qsec', title: 'Quarter mile time'},
{data: 'vs', title: 'V or Straight'},
{data: 'am', title: 'Transmission'},
{data: 'gear', title: '# gears'},
{data: 'carb', title: '# carbs'},
],
});
});
"
			   name name

		)
	       )

      ;; This works
      #+nil
      (:script :type "text/javascript"
	       (cl-who:str
		"
$(document).ready(function ()
{$('#mtcars-table').DataTable({
ajax: { url: '/data?sym=mtcars&fmt=dt',
        dataSrc: 'mtcars' },
columns: [
{data: 'model', title: 'Model'},
{data: 'mpg', title: 'MPG'},
{data: 'cyl', title: 'Cylinders'},
{data: 'disp', title: 'Displacement'},
{data: 'hp', title: 'Horsepower'},
{data: 'drat', title: 'Axle Ratio'},
{data: 'wt', title: 'Weight'},
{data: 'qsec', title: 'Quarter mile time'},
{data: 'vs', title: 'V or Straight'},
{data: 'am', title: 'Transmission'},
{data: 'gear', title: '# gears'},
{data: 'carb', title: '# carbs'},
],
});
});
"))

      ))))

