(in-package :plotview)

(defun landing-page ()
  (cl-who:with-html-output-to-string (out nil :prologue t)
    (:html
     (:head
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
      (:div :class "content"
            (:div :id "renderdiv")
            (:canvas :id "plotview-canvas" :width "400" :height "400")
            (:div
             (:button :id "draw-stroke-button"
                      :onclick "PlotviewSocket.send(JSON.stringify({\"message\": \"dodrawstroke\"}))"
                      "Draw Stroke")
             (:button :id "clear-button"
                      :onclick "PlotviewSocket.send(JSON.stringify({\"message\": \"doclearcanvas\"}))"
                      "Clear")))))
    (values)))
