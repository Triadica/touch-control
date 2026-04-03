
{} (:about "|file is generated - never edit directly; learn cr edit/tree workflows before changing") (:package |touch-control)
  :configs $ {} (:init-fn |touch-control.app.main/main!) (:reload-fn |touch-control.app.main/reload!) (:version ||0.0.17)
    :modules $ []
  :entries $ {}
  :files $ {}
    |touch-control.app.config $ %{} :FileEntry
      :defs $ {}
        |dev? $ %{} :CodeEntry (:doc |) (:schema nil)
          :code $ quote (def dev? true)
          :examples $ []
        |site $ %{} :CodeEntry (:doc |) (:schema nil)
          :code $ quote
            def site $ {} (:dev-ui |http://localhost:8100/main-fonts.css) (:release-ui |http://cdn.tiye.me/favored-fonts/main-fonts.css) (:cdn-url |http://cdn.tiye.me/calcit-workflow/) (:title |Calcit) (:icon |http://cdn.tiye.me/logo/mvc-works.png) (:storage-key |workflow)
          :examples $ []
      :ns $ %{} :NsEntry (:doc |)
        :code $ quote (ns touch-control.app.config)
    |touch-control.app.main $ %{} :FileEntry
      :defs $ {}
        |main! $ %{} :CodeEntry (:doc |) (:schema nil)
          :code $ quote
            defn main! () (load-console-formatter!)
              println "|Running mode:" $ if config/dev? |dev |release
              render-control!
              start-control-loop! 300 $ fn (elapsed states delta) (show-data! elapsed states delta)
          :examples $ []
        |mount-target $ %{} :CodeEntry (:doc |) (:schema nil)
          :code $ quote
            def mount-target $ .!querySelector js/document |.app
          :examples $ []
        |reload! $ %{} :CodeEntry (:doc |) (:schema nil)
          :code $ quote
            defn reload! () $ if (nil? build-errors)
              do
                replace-control-loop! 300 $ fn (elapsed states delta) (show-data! elapsed states delta)
                render-control!
                hud! |ok~ |Ok
              hud! |error build-errors
          :examples $ []
        |show-data! $ %{} :CodeEntry (:doc |) (:schema nil)
          :code $ quote
            defn show-data! (elapsed states delta)
              println |showing elapsed (:left-move states) (:right-move states) (:left-a? states) (:right-a? states)
              set!
                .-innerText $ js/document.querySelector |pre
                format-cirru-edn $ {} (:states states) (:delta delta)
          :examples $ []
      :ns $ %{} :NsEntry (:doc |)
        :code $ quote
          ns touch-control.app.main $ :require (touch-control.app.config :as config)
            touch-control.core :refer $ render-control! start-control-loop! clear-control-loop! replace-control-loop!
            |./calcit.build-errors :default build-errors
            |bottom-tip :default hud!
    |touch-control.core $ %{} :FileEntry
      :defs $ {}
        |%element $ %{} :CodeEntry (:doc |) (:schema nil)
          :code $ quote
            defstruct %element (:props :any) (:events :any) (:children :any)
          :examples $ []
        |&c- $ %{} :CodeEntry (:doc |) (:schema nil)
          :code $ quote
            defn &c- (a b)
              let-sugar
                    [] x1 y1
                    , a
                  ([] x2 y2) b
                [] (- x1 x2) (- y1 y2)
          :examples $ []
        |*container $ %{} :CodeEntry (:doc |) (:schema nil)
          :code $ quote (defatom *container nil)
          :examples $ []
        |*control-states $ %{} :CodeEntry (:doc |) (:schema nil)
          :code $ quote
            defatom *control-states $ {} (:left-a? false) (:left-b? false) (:right-a? false) (:right-b? false)
              :left-move $ [] 0 0
              :left-prev $ [] 0 0
              :right-move $ [] 0 0
              :right-prev $ []
          :examples $ []
        |*last-tick $ %{} :CodeEntry (:doc |) (:schema nil)
          :code $ quote
            defatom *last-tick $ js/performance.now
          :examples $ []
        |*left-origin $ %{} :CodeEntry (:doc |) (:schema nil)
          :code $ quote
            defatom *left-origin $ [] 0 0
          :examples $ []
        |*prev-control-states $ %{} :CodeEntry (:doc |) (:schema nil)
          :code $ quote
            defatom *prev-control-states $ {}
              :left-move $ [] 0 0
              :right-move $ [] 0 0
          :examples $ []
        |*raq-loop $ %{} :CodeEntry (:doc |) (:schema nil)
          :code $ quote (defatom *raq-loop nil)
          :examples $ []
        |*right-origin $ %{} :CodeEntry (:doc |) (:schema nil)
          :code $ quote (defatom *right-origin zero)
          :examples $ []
        |*shift-listener $ %{} :CodeEntry (:doc |) (:schema nil)
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
        |*timeout-loop $ %{} :CodeEntry (:doc |) (:schema nil)
          :code $ quote (defatom *timeout-loop nil)
          :examples $ []
        |clear-control-loop! $ %{} :CodeEntry (:doc |) (:schema nil)
          :code $ quote
            defn clear-control-loop! () (js/clearTimeout @*timeout-loop) (js/cancelAnimationFrame @*raq-loop)
          :examples $ []
        |connect-state $ %{} :CodeEntry (:doc |) (:schema nil)
          :code $ quote
            defn connect-state (field)
              {}
                :pointerdown $ fn (event) (; js/console.log |down event) (swap! *control-states assoc field true)
                :pointerup $ fn (event) (; js/console.log |up event) (swap! *control-states assoc field false)
          :examples $ []
        |div $ %{} :CodeEntry (:doc |) (:schema nil)
          :code $ quote
            defn div (props events & children)
              %{} %element (:props props) (:events events) (:children children)
          :examples $ []
        |left-events $ %{} :CodeEntry (:doc |) (:schema nil)
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
                        - (.-layerX event) (nth @*left-origin 0)
                        - (nth @*left-origin 1) (.-layerY event)
                    swap! *control-states assoc :left-move move
          :examples $ []
        |render-control! $ %{} :CodeEntry (:doc |) (:schema nil)
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
        |render-dom! $ %{} :CodeEntry (:doc |) (:schema nil)
          :code $ quote
            defn render-dom! (el parent)
              let
                  div $ js/document.createElement |div
                  props $ :props el
                  events $ or (:events el) ({})
                  children $ :children el
                &doseq (pair props)
                  let[] (k v) pair $ aset div (turn-string k) v
                &doseq (pair events)
                  let[] (k v) pair $ .!addEventListener div (turn-string k) v false
                &doseq (child children) (render-dom! child div)
                .!appendChild parent div
          :examples $ []
        |replace-control-loop! $ %{} :CodeEntry (:doc |) (:schema nil)
          :code $ quote
            defn replace-control-loop! (duration f) (clear-control-loop!) (start-control-loop! duration f)
          :examples $ []
        |right-events $ %{} :CodeEntry (:doc |) (:schema nil)
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
                        - (.-layerX event) (nth @*right-origin 0)
                        - (nth @*right-origin 1) (.-layerY event)
                    ; js/console.log "|moving to" move
                    swap! *control-states assoc :right-move move
          :examples $ []
        |start-control-loop! $ %{} :CodeEntry (:doc |) (:schema nil)
          :code $ quote
            defn start-control-loop! (duration f)
              let
                  now $ js/performance.now
                  elapsed $ / (- now @*last-tick) 1000
                  shift? @*shift-listener
                  states $ deref *control-states
                f elapsed (assoc states :shift? shift?)
                  {}
                    :left-move $ &c- (:left-move states) (:left-move @*prev-control-states)
                    :right-move $ &c- (:right-move states) (:right-move @*prev-control-states)
                reset! *last-tick now
                reset! *prev-control-states $ {}
                  :left-move $ :left-move states
                  :right-move $ :right-move states
                if
                  and (:left-a? states) (:right-a? states)
                  try-fullscreen!
              reset! *timeout-loop $ js/setTimeout
                fn () $ reset! *raq-loop
                  js/requestAnimationFrame $ fn (p) (start-control-loop! duration f)
                , duration
          :examples $ []
        |try-fullscreen! $ %{} :CodeEntry (:doc |) (:schema nil)
          :code $ quote
            defn try-fullscreen! () $ if (not= js/window.innerHeight js/screen.height) (js/document.documentElement.requestFullscreen)
          :examples $ []
        |zero $ %{} :CodeEntry (:doc |) (:schema nil)
          :code $ quote
            def zero $ [] 0 0
          :examples $ []
      :ns $ %{} :NsEntry (:doc |)
        :code $ quote (ns touch-control.core)
