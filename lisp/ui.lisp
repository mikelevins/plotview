;;;; ***********************************************************************
;;;; 
;;;; Name:          ui.lisp
;;;; Project:       plotview
;;;; Purpose:       plotview main UI
;;;; Author:        mikel evins
;;;; Copyright:     2021 by mikel evins
;;;;
;;;; ***********************************************************************

(in-package :plotview)

(defun landing-page ()
  (cl-who:with-html-output-to-string (out nil :prologue t)
    (:html
     (:head
      (:link :rel "stylesheet" :href "css/normalize.css")
      (:link :rel "stylesheet" :href "css/plotview.css")
      (:link :rel "icon":type "image/png" :href "icons/plotview-icon.png")
      (:title "plotview"))
     (:body
      ;; preloaded Javascript
      (:script :src "js/htmx.min.js")
      (:script :src "js/plotview.js")

      ;; actual contents
      (:div :class "content"
            (:canvas :id "plotview-canvas"))))
    (values)))
