(in-package :plotview)

(defun landing-page ()
  (cl-who:with-html-output-to-string (out nil :prologue t)
    (:html
     (:head
      (:meta :charset "utf-8")
      ;; disable browser caching
      (:meta :http-equiv "cache-control" :content "max-age=0")
      (:meta :http-equiv "cache-control" :content "no-cache")
      (:meta :http-equiv "expires" :content "-1")
      (:meta :http-equiv "expires" :content "Tue, 01 Jan 1980 11:00:00 GMT")
      (:meta :http-equiv "pragma" :content "no-cache")
      ;; end browser caching
      (:title "Vega-Lite Bar Chart")
      (:script :src "https://cdn.jsdelivr.net/npm/vega@5.22.1")
      (:script :src "https://cdn.jsdelivr.net/npm/vega-lite@5.6.1")
      (:script :src "https://cdn.jsdelivr.net/npm/vega-embed@6.21.2")
      (:style :media "screen" ".vega-actions a { margin-right: 5px; }"))
     (:body
      

      ;; actual contents
      (:h1 "vegatest page")
      (:div :id "render")
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

     // Embed the visualization in the container with id `render`
     vegaEmbed('#render', vlSpec);
")))
    (values)))
