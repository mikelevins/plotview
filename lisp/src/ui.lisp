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

(defun vegatest-page ()
  (cl-who:with-html-output-to-string (out nil :prologue t)
    (:html
     (:head
      (:meta :charset "utf-8")
      (:title "Vega-Lite Bar Chart")
      (:script :src "https://cdn.jsdelivr.net/npm/vega@5.22.1")
      (:script :src "https://cdn.jsdelivr.net/npm/vega-lite@5.6.1")
      (:script :src "https://cdn.jsdelivr.net/npm/vega-embed@6.21.2")
      (:style :media "screen" ".vega-actions a { margin-right: 5px; }"))
     (:body
      

      ;; actual contents
      (:h1 "vegatest page")
      (:div :id "vis")
      (:script
       "
     // Assign the specification to a local variable vlSpec.
     var vlSpec = {
         $schema: 'https://vega.github.io/schema/vega-lite/v5.json',
         data: {
             values: [
                 {a: 'C', b: 2},
                 {a: 'C', b: 7},
                 {a: 'C', b: 4},
                 {a: 'D', b: 1},
                 {a: 'D', b: 2},
                 {a: 'D', b: 6},
                 {a: 'E', b: 8},
                 {a: 'E', b: 4},
                 {a: 'E', b: 7}
             ]
         },
         mark: 'bar',
         encoding: {
             y: {field: 'a', type: 'nominal'},
             x: {
                 aggregate: 'average',
                 field: 'b',
                 type: 'quantitative',
                 axis: {
                     title: 'Average of b'
                 }
             }
         }
     };

     // Embed the visualization in the container with id `vis`
     vegaEmbed('#vis', vlSpec);
")))
    (values)))
