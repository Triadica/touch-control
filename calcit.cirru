
{} (:about "|Machine-generated snapshot. Do not edit directly — changes will be overwritten. Use `calcit query` to inspect and `calcit edit`/`calcit tree` to modify. Run `calcit docs agents --full` first. Manual edits must follow format and schema conventions, then run `calcit edit format`.") (:package |touch-control)
  :entries $ {}
    :default $ {} (:description |) (:init-fn 'touch-control.app.main/main!) (:mode :native) (:reload-fn 'touch-control.app.main/reload!)
      :feature-policy $ {}
      :modules $ []
      :type-slots $ {}
  :files $ {}
    'touch-control.app.config $ %{} 'FileEntry
      :defs $ {}
        'dev? $ %{} 'CodeEntry (:doc |)
          :code $ quote (def dev? true)
          :examples $ []
          :schema $ :: 'Dynamic
        'site $ %{} 'CodeEntry (:doc |)
          :code $ quote
            def site $ {} (:dev-ui |http://localhost:8100/main-fonts.css) (:release-ui |http://cdn.tiye.me/favored-fonts/main-fonts.css) (:cdn-url |http://cdn.tiye.me/calcit-workflow/) (:title |Calcit) (:icon |http://cdn.tiye.me/logo/mvc-works.png) (:storage-key |workflow)
          :examples $ []
          :schema $ :: 'Dynamic
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote (ns touch-control.app.config)
    'touch-control.app.main $ %{} 'FileEntry
      :defs $ {}
        'main! $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn main! () (load-console-formatter!)
              println "|Running mode:" $ if config/dev? |dev |release
              render-control!
              start-control-loop! 300 $ fn (elapsed states delta) (show-data! elapsed states delta)
          :examples $ []
          :schema $ :: 'Dynamic
        'mount-target $ %{} 'CodeEntry (:doc |)
          :code $ quote
            def mount-target $ .!querySelector js/document |.app
          :examples $ []
          :schema $ :: 'Dynamic
        'reload! $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn reload! () $ if (nil? build-errors)
              do
                replace-control-loop! 300 $ fn (elapsed states delta) (show-data! elapsed states delta)
                render-control!
                hud! |ok~ |Ok
              hud! |error build-errors
          :examples $ []
          :schema $ :: 'Dynamic
        'show-data! $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn show-data! (elapsed states delta)
              println |showing elapsed
                option:unwrap-or (get states :left-move) ([] 0 0)
                option:unwrap-or (get states :right-move) ([] 0 0)
                (get states :left-a?) .unwrap-or false
                (get states :right-a?) .unwrap-or false
              set!
                .-innerText $ unsafe-coerce (js/document.querySelector |pre) JsObject
                format-cirru-edn $ {} (:states states) (:delta delta)
          :examples $ []
          :schema $ :: 'Dynamic
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote
          ns touch-control.app.main $ :require (touch-control.app.config :as config)
            touch-control.core :refer $ render-control! start-control-loop! clear-control-loop! replace-control-loop!
            |./calcit.build-errors :default build-errors
            |bottom-tip :default hud!
    'touch-control.core $ %{} 'FileEntry
      :defs $ {}
        '%element $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defstruct %element (:props 'Dynamic) (:events 'Dynamic) (:children 'Dynamic)
          :examples $ []
          :schema $ :: 'Enum
        '&c- $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn &c- (a b)
              let-sugar
                    [] x1 y1
                    , a
                  ([] x2 y2) b
                [] (- x1 x2) (- y1 y2)
          :examples $ []
          :schema $ :: 'Dynamic
          :tests $ []
            %{} 'TestEntry (:name |subtracts-coordinates)
              :code $ quote
                assert= ([] 2 3)
                  &c- ([] 5 7) ([] 3 4)
              :tags $ #{} :unit
        '*container $ %{} 'CodeEntry (:doc |)
          :code $ quote (defatom *container nil)
          :examples $ []
          :schema $ :: 'Dynamic
        '*control-states $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defatom *control-states $ {} (:left-a? false) (:left-b? false) (:right-a? false) (:right-b? false)
              :left-move $ [] 0 0
              :left-prev $ [] 0 0
              :right-move $ [] 0 0
              :right-prev $ []
          :examples $ []
          :schema $ :: 'Dynamic
        '*last-tick $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defatom *last-tick $ unsafe-coerce (js/performance.now) Number
          :examples $ []
          :schema $ :: 'Dynamic
        '*left-origin $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defatom *left-origin $ [] 0 0
          :examples $ []
          :schema $ :: 'Dynamic
        '*prev-control-states $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defatom *prev-control-states $ {}
              :left-move $ [] 0 0
              :right-move $ [] 0 0
          :examples $ []
          :schema $ :: 'Dynamic
        '*raq-loop $ %{} 'CodeEntry (:doc |)
          :code $ quote (defatom *raq-loop nil)
          :examples $ []
          :schema $ :: 'Dynamic
        '*right-origin $ %{} 'CodeEntry (:doc |)
          :code $ quote (defatom *right-origin zero)
          :examples $ []
          :schema $ :: 'Dynamic
        '*shift-listener $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defatom *shift-listener $ do
              js/window.addEventListener |keydown $ fn (event)
                if
                  and (.-shiftKey event) (not @*shift-listener)
                  reset! *shift-listener true
              js/window.addEventListener |keyup $ fn (event)
                if
                  and
                    not $ .-shiftKey event
                    , @*shift-listener
                  reset! *shift-listener false
              , false
          :examples $ []
          :schema $ :: 'Dynamic
        '*timeout-loop $ %{} 'CodeEntry (:doc |)
          :code $ quote (defatom *timeout-loop nil)
          :examples $ []
          :schema $ :: 'Dynamic
        'clear-control-loop! $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn clear-control-loop! () (js/clearTimeout @*timeout-loop) (js/cancelAnimationFrame @*raq-loop)
          :examples $ []
          :schema $ :: 'Dynamic
        'connect-state $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn connect-state (field)
              {}
                :pointerdown $ fn (event) (; js/console.log |down event) (swap! *control-states assoc field true)
                :pointerup $ fn (event) (; js/console.log |up event) (swap! *control-states assoc field false)
          :examples $ []
          :schema $ :: 'Dynamic
        'div $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn div (props events & children)
              %{} %element (:props props) (:events events) (:children children)
          :examples $ []
          :schema $ :: 'Dynamic
        'left-events $ %{} 'CodeEntry (:doc |)
          :code $ quote
            def left-events $ let
                on-leave $ fn (event) (swap! *control-states assoc :left-move zero) (swap! *prev-control-states assoc :left-move zero)
                on-enter $ fn (event)
                  reset! *left-origin $ [] (.-layerX event) (.-layerY event)
                  swap! *control-states assoc :left-move zero
                  swap! *prev-control-states assoc :left-move zero
              {} (:pointerdown on-enter) (:pointerenter on-enter) (:mouseleave on-leave) (:pointerup on-leave)
                :pointermove $ fn (event)
                  let
                      move $ []
                        -
                          unsafe-coerce (.-layerX event) Number
                          (nth @*left-origin 0) .unwrap-or 0
                        -
                            nth @*left-origin 1
                            , .unwrap-or 0
                          unsafe-coerce (.-layerY event) Number
                    swap! *control-states assoc :left-move move
          :examples $ []
          :schema $ :: 'Dynamic
        'render-control! $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn render-control! ()
              if (some? @*container) (.!remove @*container)
              let
                  panel $ div
                    {} $ :className |touch-control
                    {}
                    div
                      {} $ :className |left-group
                      {}
                      div
                        {} $ :className "|left-hand hand-button"
                        , left-events $ div
                          {} $ :className |hand-center
                          {}
                      div
                        {} $ :className "|left-a circle-button"
                        connect-state :left-a?
                      div
                        {} $ :className "|left-b circle-button"
                        connect-state :left-b?
                    div
                      {} $ :className |right-group
                      {}
                      div
                        {} $ :className "|right-hand hand-button"
                        , right-events $ div
                          {} $ :className |hand-center
                          {}
                      div
                        {} $ :className "|right-a circle-button"
                        connect-state :right-a?
                      div
                        {} $ :className "|right-b circle-button"
                        connect-state :right-b?
                  dom $ render-dom! panel js/document.body
                reset! *container dom
          :examples $ []
          :schema $ :: 'Dynamic
        'render-dom! $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn render-dom! (el parent)
              let
                  div $ unsafe-coerce (js/document.createElement |div) JsObject
                  props $ :props el
                  events $ :events el
                  children $ :children el
                &doseq (pair props)
                  let[] (k v) pair $ aset div (turn-string k) v
                &doseq (pair events)
                  let[] (k v) pair $ .!addEventListener div (turn-string k) v false
                &doseq (child children) (render-dom! child div)
                .!appendChild parent div
                , div
          :examples $ []
          :schema $ :: 'Fn
            {} (:return 'JsObject)
              :args $ [] 'touch-control.core/%element 'Dynamic
        'replace-control-loop! $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn replace-control-loop! (duration f) (clear-control-loop!) (start-control-loop! duration f)
          :examples $ []
          :schema $ :: 'Dynamic
        'right-events $ %{} 'CodeEntry (:doc |)
          :code $ quote
            def right-events $ let
                on-enter $ fn (event)
                  reset! *right-origin $ [] (.-layerX event) (.-layerY event)
                  swap! *control-states assoc :right-move zero
                  swap! *prev-control-states assoc :right-move zero
                on-leave $ fn (event) (swap! *control-states assoc :right-move zero) (swap! *prev-control-states assoc :right-move zero)
              {} (:pointerdown on-enter) (:pointerup on-leave) (:mouseenter on-enter) (:mouseleave on-leave)
                :pointermove $ fn (event)
                  let
                      move $ []
                        -
                          unsafe-coerce (.-layerX event) Number
                          (nth @*right-origin 0) .unwrap-or 0
                        -
                            nth @*right-origin 1
                            , .unwrap-or 0
                          unsafe-coerce (.-layerY event) Number
                    ; js/console.log "|moving to" move
                    swap! *control-states assoc :right-move move
          :examples $ []
          :schema $ :: 'Dynamic
        'start-control-loop! $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn start-control-loop! (duration f)
              let
                  now $ unsafe-coerce (js/performance.now) Number
                  elapsed $ / (- now @*last-tick) 1000
                  shift? @*shift-listener
                  states $ deref *control-states
                f elapsed (assoc states :shift? shift?)
                  {}
                    :left-move $ &c-
                        get states :left-move
                        , .unwrap-or zero
                      (get @*prev-control-states :left-move) .unwrap-or zero
                    :right-move $ &c-
                        get states :right-move
                        , .unwrap-or zero
                      (get @*prev-control-states :right-move) .unwrap-or zero
                reset! *last-tick now
                reset! *prev-control-states $ {}
                  :left-move $
                    get states :left-move
                    , .unwrap-or zero
                  :right-move $
                    get states :right-move
                    , .unwrap-or zero
                if
                  and
                      get states :left-a?
                      , .unwrap-or false
                    (get states :right-a?) .unwrap-or false
                  try-fullscreen!
              reset! *timeout-loop $ js/setTimeout
                fn () $ reset! *raq-loop
                  js/requestAnimationFrame $ fn (p) (start-control-loop! duration f)
                , duration
          :examples $ []
          :schema $ :: 'Dynamic
        'try-fullscreen! $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn try-fullscreen! () $ if (not= js/window.innerHeight js/screen.height) (js/document.documentElement.requestFullscreen)
          :examples $ []
          :schema $ :: 'Dynamic
        'zero $ %{} 'CodeEntry (:doc |)
          :code $ quote
            def zero $ [] 0 0
          :examples $ []
          :schema $ :: 'Dynamic
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote (ns touch-control.core)
