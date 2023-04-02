(in-package :plotview)

(defun landing-page ()
  (cl-who:with-html-output-to-string (out nil :prologue t)
    (:html
     (:head
      ;; disable browser caching
      (:meta :http-equiv "cache-control" :content "max-age=0")
      (:meta :http-equiv "cache-control" :content "no-cache")
      (:meta :http-equiv "expires" :content "-1")
      (:meta :http-equiv "expires" :content "Tue, 01 Jan 1980 11:00:00 GMT")
      (:meta :http-equiv "pragma" :content "no-cache")
      ;; end browser caching
      (:link :rel "stylesheet" :href "css/normalize.css")
      (:link :rel "stylesheet" :href "css/plotview.css")
      (:link :rel "icon":type "image/png" :href "icons/plotview-icon.png")
      (:title "PlotView"))
     (:body
      ;; preloaded Javascript
      (:script :src "js/htmx.min.js")
      (:script :src "js/plotview.js")
      (:script :src "https://vega.github.io/vega/vega.min.js")

      ;; actual contents
      (:h1 "Plotview")
      (:div :class "content"
            (:div :id "renderdiv"))))
    (values)))

