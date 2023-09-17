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
      (:title "Plotview")
      (:link :rel "stylesheet" :href "css/normalize.css")
      (:link :rel "stylesheet" :href "css/plotview.css")
      (:link :rel "icon":type "image/png" :href "icons/plotview-icon.png")
      (:title "PlotView")
      ;; preloaded Javascript
      (:script :src "https://cdn.jsdelivr.net/npm/vega@5.22.1")
      (:script :src "https://cdn.jsdelivr.net/npm/vega-lite@5.6.1")
      (:script :src "https://cdn.jsdelivr.net/npm/vega-embed@6.21.2")
      (:script :src "js/htmx.min.js")
      (:script :src "js/plotview.js"))
     (:body
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
                      "Clear")
             (:button :id "vegatest-button"
                      :onclick "PlotviewSocket.send(JSON.stringify({\"message\": \"dovegatest\"}))"
                      "Vega Test")))))
    (values)))

(defun vegatest-page ()
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
      (:script :type "text/javascript"
               (str (ps
                      (defvar vl-spec
                        (create $schema "https://vega.github.io/schema/vega-lite/v5.json"
                                data (create values
                                             (array (create a "C" b 2)
                                                    (create a "C" b 7)
                                                    (create a "C" b 4)
                                                    (create a "D" b 1)
                                                    (create a "D" b 2)
                                                    (create a "D" b 6)
                                                    (create a "E" b 8)
                                                    (create a "E" b 4)
                                                    (create a "E" b 7)))
                                mark "bar"
                                encoding (create y (create field "a" type "nominal")
                                                 x (create aggregate "average"
                                                           field "b"
                                                           type "quantitative"
                                                           axis (create "title" "average of b")))))
                      (vega-embed "#render" vl-spec))))))
    (values)))

(defun open-plotview ()
  #+win32 (uiop:run-program "explorer http://localhost:20202/" :force-shell nil :ignore-error-status t)
  #+darwin (uiop:run-program "open http://localhost:20202/" :force-shell nil :ignore-error-status t))
