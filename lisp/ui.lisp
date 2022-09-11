;;;; ***********************************************************************
;;;; 
;;;; Name:          ui.lisp
;;;; Project:       clio
;;;; Purpose:       clio main UI
;;;; Author:        mikel evins
;;;; Copyright:     2021 by mikel evins
;;;;
;;;; ***********************************************************************

(in-package :clio)

(defun landing-page ()
  (cl-who:with-html-output-to-string (out nil :prologue t)
    (:html
     (:head
      (:link :rel "stylesheet" :href "css/normalize.css")
      (:link :rel "stylesheet" :href "css/clio.css")
      (:link :rel "stylesheet" :href "css/fontawesome-all.min.css")
      (:link :rel "icon":type "image/png" :href "icons/clio-icon.png")
      (:title "clio"))
     (:body
      ;; preloaded Javascript
      (:script :src "js/htmx.min.js")
      (:script :src "js/clio.js")

      ;; actual contents
      (:div :class "content"
       (:div :id "banner" "clio")
       (:div :id "worksheet")
       (:div :id "listener"
        (:form :hx-post "/evaluate" :hx-target "#worksheet" :hx-swap "beforeend"
         (:span :id "prompt" :class "listener-input" "clio>&nbsp;")
         (:input :id "listener-input" :class "listener-input" :name "listener-input" :type "text"))))))
    (values)))
