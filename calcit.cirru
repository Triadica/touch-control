
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
          :schema $ :: 'Bool
        'site $ %{} 'CodeEntry (:doc |)
          :code $ quote
            def site $ {} (:dev-ui |http://localhost:8100/main-fonts.css) (:release-ui |http://cdn.tiye.me/favored-fonts/main-fonts.css) (:cdn-url |http://cdn.tiye.me/calcit-workflow/) (:title |Calcit) (:icon |http://cdn.tiye.me/logo/mvc-works.png) (:storage-key |workflow)
          :examples $ []
          :schema $ :: 'Map 'Tag 'String
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
          :schema $ :: 'Fn
            {} (:return 'Unit)
              :args $ []
              :features $ #{} :js-ffi
        'mount-target $ %{} 'CodeEntry (:doc |)
          :code $ quote
            def mount-target $ .!querySelector js/document |.app
          :examples $ []
          :schema $ :: 'touch-control.core/DomElementHost
        'reload! $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn reload! () $ if (nil? build-errors)
              do
                replace-control-loop! 300 $ fn (elapsed states delta) (show-data! elapsed states delta)
                render-control!
                hud! |ok~ |Ok
              hud! |error build-errors
          :examples $ []
          :schema $ :: 'Fn
            {} (:return 'Unit)
              :args $ []
              :features $ #{} :js-ffi
        'show-data! $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn show-data! (elapsed states delta)
              println |showing elapsed (:left-move states) (:right-move states) (:left-a? states) (:right-a? states)
              set!
                .-innerText $ unsafe-coerce (js/document.querySelector |pre) touch-control.core/TextElementHost
                format-cirru-edn $ {} (:states states) (:delta delta)
          :examples $ []
          :schema $ :: 'Fn
            {} (:return 'Unit)
              :args $ [] 'Number 'touch-control.core/ControlState 'touch-control.core/ControlDelta
              :features $ #{} :js-ffi
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
            defstruct %element
              :props $ :: 'Map 'Tag 'String
              :events $ :: 'Map 'Tag
                :: 'Fn $ {}
                  :args $ [] 'PointerEventHost
                  :return 'Unit
                  :features $ #{} :js-ffi
              :children $ :: 'List 'touch-control.core/%element
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
          :schema $ :: 'Fn
            {}
              :args $ [] (:: 'List 'Number) (:: 'List 'Number)
              :return $ :: 'List 'Number
          :tests $ []
            %{} 'TestEntry (:name |subtracts-coordinates)
              :code $ quote
                assert |subtracts-coordinates $ = ([] 2 3)
                  &c- ([] 5 7) ([] 3 4)
              :tags $ #{} :unit
        '*container $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defatom *container $ create-container-placeholder
          :examples $ []
          :schema $ :: 'Ref 'JsObject
        '*control-states $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defatom *control-states $ %{} ControlState (:left-a? false) (:left-b? false) (:right-a? false) (:right-b? false) (:shift? false) (:left-move zero) (:left-prev zero) (:right-move zero) (:right-prev zero)
          :examples $ []
          :schema $ :: 'Ref 'ControlState
        '*last-tick $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defatom *last-tick $ performance-now
          :examples $ []
          :schema $ :: 'Ref 'Number
        '*left-origin $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defatom *left-origin $ [] 0 0
          :examples $ []
          :schema $ :: 'Ref (:: 'List 'Number)
        '*prev-control-states $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defatom *prev-control-states $ %{} ControlDelta (:left-move zero) (:right-move zero)
          :examples $ []
          :schema $ :: 'Ref 'ControlDelta
        '*raq-loop $ %{} 'CodeEntry (:doc |)
          :code $ quote (defatom *raq-loop 0)
          :examples $ []
          :schema $ :: 'Ref 'Number
        '*right-origin $ %{} 'CodeEntry (:doc |)
          :code $ quote (defatom *right-origin zero)
          :examples $ []
          :schema $ :: 'Ref (:: 'List 'Number)
        '*shift-listener $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defatom *shift-listener $ install-shift-listeners!
          :examples $ []
          :schema $ :: 'Ref 'Bool
        '*timeout-loop $ %{} 'CodeEntry (:doc |)
          :code $ quote (defatom *timeout-loop 0)
          :examples $ []
          :schema $ :: 'Ref 'Number
        'ControlDelta $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defstruct ControlDelta
              :left-move $ :: 'List 'Number
              :right-move $ :: 'List 'Number
          :examples $ []
          :schema $ :: 'StructDef
        'ControlState $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defstruct ControlState (:left-a? 'Bool) (:left-b? 'Bool) (:right-a? 'Bool) (:right-b? 'Bool) (:shift? 'Bool)
              :left-move $ :: 'List 'Number
              :left-prev $ :: 'List 'Number
              :right-move $ :: 'List 'Number
              :right-prev $ :: 'List 'Number
          :examples $ []
          :schema $ :: 'StructDef
        'DocumentHost $ %{} 'CodeEntry (:doc |)
          :code $ quote
            deftrait DocumentHost (:body 'DomElementHost) (:document-element 'FullscreenElementHost)
              .query-selector! $ :: 'Fn
                {}
                  :args $ [] 'DocumentHost 'String
                  :return 'JsObject
              .create-element! $ :: 'Fn
                {}
                  :args $ [] 'DocumentHost 'String
                  :return 'DomElementHost
          :examples $ []
          :ffi $ {} (:backend :js) (:kind :external-object) (:target :browser)
            :names $ {} (:body |body) (:create-element! |createElement) (:document-element |documentElement) (:query-selector! |querySelector)
          :schema $ :: 'Trait
        'DomElementHost $ %{} 'CodeEntry (:doc |)
          :code $ quote
            deftrait DomElementHost
              .add-event-listener! $ :: 'Fn
                {}
                  :args $ [] 'DomElementHost 'String
                    :: 'Fn $ {}
                      :args $ [] 'PointerEventHost
                      :return 'Unit
                    , 'Bool
                  :return 'Unit
              .append-child! $ :: 'Fn
                {}
                  :args $ [] 'DomElementHost 'DomElementHost
                  :return 'Unit
              .remove! $ :: 'Fn
                {}
                  :args $ [] 'DomElementHost
                  :return 'Unit
          :examples $ []
          :ffi $ {} (:backend :js) (:kind :external-object) (:target :browser)
            :names $ {} (:add-event-listener! |addEventListener) (:append-child! |appendChild) (:remove! |remove)
          :schema $ :: 'Trait
        'FullscreenElementHost $ %{} 'CodeEntry (:doc |)
          :code $ quote
            deftrait FullscreenElementHost $ .request-fullscreen!
              :: 'Fn $ {}
                :args $ [] 'FullscreenElementHost
                :return 'Unit
          :examples $ []
          :ffi $ {} (:backend :js) (:kind :external-object) (:target :browser)
            :names $ {} (:request-fullscreen! |requestFullscreen)
          :schema $ :: 'Trait
        'KeyboardEventHost $ %{} 'CodeEntry (:doc |)
          :code $ quote
            deftrait KeyboardEventHost $ :shift-key 'Bool
          :examples $ []
          :ffi $ {} (:backend :js) (:kind :external-object) (:target :browser)
            :names $ {} (:shift-key |shiftKey)
          :schema $ :: 'Trait
        'PointerEventHost $ %{} 'CodeEntry (:doc |)
          :code $ quote
            deftrait PointerEventHost (:layer-x 'Number) (:layer-y 'Number)
          :examples $ []
          :ffi $ {} (:backend :js) (:kind :external-object) (:target :browser)
            :names $ {} (:layer-x |layerX) (:layer-y |layerY)
          :schema $ :: 'Trait
        'ScreenHost $ %{} 'CodeEntry (:doc |)
          :code $ quote
            deftrait ScreenHost $ :height 'Number
          :examples $ []
          :ffi $ {} (:backend :js) (:kind :external-object) (:target :browser)
            :names $ {} (:height |height)
          :schema $ :: 'Trait
        'TextElementHost $ %{} 'CodeEntry (:doc |)
          :code $ quote
            deftrait TextElementHost $ :inner-text 'String
          :examples $ []
          :ffi $ {} (:backend :js) (:kind :external-object) (:target :browser)
            :names $ {} (:inner-text |innerText)
          :schema $ :: 'Trait
        'WindowHost $ %{} 'CodeEntry (:doc |)
          :code $ quote
            deftrait WindowHost (:inner-height 'Number)
              .add-keyboard-listener! $ :: 'Fn
                {}
                  :args $ [] 'WindowHost 'String
                    :: 'Fn $ {}
                      :args $ [] 'KeyboardEventHost
                      :return 'Unit
                  :return 'Unit
          :examples $ []
          :ffi $ {} (:backend :js) (:kind :external-object) (:target :browser)
            :names $ {} (:add-keyboard-listener! |addEventListener) (:inner-height |innerHeight)
          :schema $ :: 'Trait
        'clear-control-loop! $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn clear-control-loop! () (js/clearTimeout @*timeout-loop) (js/cancelAnimationFrame @*raq-loop) &unit
          :examples $ []
          :schema $ :: 'Fn
            {} (:return 'Unit)
              :args $ []
              :features $ #{} :js-ffi
        'connect-state $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn connect-state (field)
              {}
                :pointerdown $ fn (event) (; js/console.log |down event) (set-button-state! field true)
                :pointerup $ fn (event) (; js/console.log |up event) (set-button-state! field false)
          :examples $ []
          :schema $ :: 'Fn
            {}
              :args $ [] 'Tag
              :return $ :: 'Map 'Tag
                :: 'Fn $ {} (:return 'Unit)
                  :args $ [] 'PointerEventHost
        'create-container-placeholder $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn create-container-placeholder () $ let
                document-host $ unsafe-coerce js/document DocumentHost
              unsafe-coerce (.create-element! document-host |div) JsObject
          :examples $ []
          :schema $ :: 'Fn
            {} (:return 'JsObject)
              :args $ []
              :features $ #{} :js-ffi
        'div $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn div (props events & children)
              %{} %element (:props props) (:events events) (:children children)
          :examples $ []
          :schema $ :: 'Fn
            {} (:rest 'touch-control.core/%element) (:return 'touch-control.core/%element)
              :args $ [] (:: 'Map 'Tag 'String)
                :: 'Map 'Tag $ :: 'Fn
                  {} (:return 'Unit)
                    :args $ [] 'PointerEventHost
        'document-body $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn document-body () $ let
                host $ unsafe-coerce js/document DocumentHost
              unsafe-coerce (host :body) DomElementHost
          :examples $ []
          :schema $ :: 'Fn
            {} (:return 'DomElementHost)
              :args $ []
              :features $ #{} :js-ffi
        'install-shift-listeners! $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn install-shift-listeners! ()
              .add-keyboard-listener! (unsafe-coerce js/window WindowHost) |keydown $ fn (event)
                if
                  and (keyboard-shift? event) (not @*shift-listener)
                  reset! *shift-listener true
              .add-keyboard-listener! (unsafe-coerce js/window WindowHost) |keyup $ fn (event)
                if
                  and
                    not $ keyboard-shift? event
                    , @*shift-listener
                  reset! *shift-listener false
              , false
          :examples $ []
          :schema $ :: 'Fn
            {} (:return 'Bool)
              :args $ []
              :features $ #{} :js-ffi
        'keyboard-shift? $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn keyboard-shift? (event)
              let
                  host $ unsafe-coerce event KeyboardEventHost
                host :shift-key
          :examples $ []
          :schema $ :: 'Fn
            {} (:return 'Bool)
              :args $ [] 'Dynamic
              :features $ #{} :js-ffi
        'left-events $ %{} 'CodeEntry (:doc |)
          :code $ quote
            def left-events $ let
                on-leave $ fn (event) (swap! *control-states assoc :left-move zero) (swap! *prev-control-states assoc :left-move zero)
                on-enter $ fn (event)
                  reset! *left-origin $ [] (pointer-x event) (pointer-y event)
                  swap! *control-states assoc :left-move zero
                  swap! *prev-control-states assoc :left-move zero
              {} (:pointerdown on-enter) (:pointerenter on-enter) (:mouseleave on-leave) (:pointerup on-leave)
                :pointermove $ fn (event)
                  let
                      move $ []
                        - (pointer-x event) (&list:nth @*left-origin 0)
                        - (&list:nth @*left-origin 1) (pointer-y event)
                    swap! *control-states assoc :left-move move
          :examples $ []
          :schema $ :: 'Map 'Tag
            :: 'Fn $ {} (:return 'Unit)
              :args $ [] 'PointerEventHost
        'performance-now $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn performance-now () $ unsafe-coerce (js/performance.now) Number
          :examples $ []
          :schema $ :: 'Fn
            {} (:return 'Number)
              :args $ []
              :features $ #{} :js-ffi
        'pointer-x $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn pointer-x (event)
              let
                  host $ unsafe-coerce event PointerEventHost
                host :layer-x
          :examples $ []
          :schema $ :: 'Fn
            {} (:return 'Number)
              :args $ [] 'Dynamic
              :features $ #{} :js-ffi
        'pointer-y $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn pointer-y (event)
              let
                  host $ unsafe-coerce event PointerEventHost
                host :layer-y
          :examples $ []
          :schema $ :: 'Fn
            {} (:return 'Number)
              :args $ [] 'Dynamic
              :features $ #{} :js-ffi
        'remove-container! $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn remove-container! (value)
              .remove! $ unsafe-coerce value DomElementHost
          :examples $ []
          :schema $ :: 'Fn
            {} (:return 'Unit)
              :args $ [] 'JsObject
              :features $ #{} :js-ffi
        'render-control! $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn render-control! () (remove-container! @*container)
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
                  dom $ render-dom! panel (document-body)
                reset! *container $ unsafe-coerce dom JsObject
          :examples $ []
          :schema $ :: 'Fn
            {} (:return 'Unit)
              :args $ []
              :features $ #{} :js-ffi
        'render-dom! $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn render-dom! (el parent)
              let
                  div $ unsafe-coerce
                    .create-element! (unsafe-coerce js/document DocumentHost) |div
                    , DomElementHost
                  props $ :props el
                  events $ :events el
                  children $ :children el
                &doseq (pair props)
                  let[] (k v) pair $ aset div (turn-string k) v
                &doseq (pair events)
                  let[] (k v) pair $ .add-event-listener! div (turn-string k) v false
                &doseq (child children) (render-dom! child div)
                .append-child! parent div
                , div
          :examples $ []
          :schema $ :: 'Fn
            {} (:return 'DomElementHost)
              :args $ [] 'touch-control.core/%element 'DomElementHost
              :features $ #{} :js-ffi
        'replace-control-loop! $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn replace-control-loop! (duration f) (clear-control-loop!) (start-control-loop! duration f)
          :examples $ []
          :schema $ :: 'Fn
            {} (:return 'Unit)
              :args $ [] 'Number
                :: 'Fn $ {} (:return 'Unit)
                  :args $ [] 'Number 'ControlState 'ControlDelta
              :features $ #{} :js-ffi
        'right-events $ %{} 'CodeEntry (:doc |)
          :code $ quote
            def right-events $ let
                on-enter $ fn (event)
                  reset! *right-origin $ [] (pointer-x event) (pointer-y event)
                  swap! *control-states assoc :right-move zero
                  swap! *prev-control-states assoc :right-move zero
                on-leave $ fn (event) (swap! *control-states assoc :right-move zero) (swap! *prev-control-states assoc :right-move zero)
              {} (:pointerdown on-enter) (:pointerup on-leave) (:mouseenter on-enter) (:mouseleave on-leave)
                :pointermove $ fn (event)
                  let
                      move $ []
                        - (pointer-x event) (&list:nth @*right-origin 0)
                        - (&list:nth @*right-origin 1) (pointer-y event)
                    ; js/console.log "|moving to" move
                    swap! *control-states assoc :right-move move
          :examples $ []
          :schema $ :: 'Map 'Tag
            :: 'Fn $ {} (:return 'Unit)
              :args $ [] 'PointerEventHost
        'set-button-state! $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn set-button-state! (field value)
              cond
                  = field :left-a?
                  swap! *control-states assoc :left-a? value
                (= field :left-b?) (swap! *control-states assoc :left-b? value)
                (= field :right-a?) (swap! *control-states assoc :right-a? value)
                (= field :right-b?) (swap! *control-states assoc :right-b? value)
                true $ raise (str-spaced |unknown-control-field field)
          :examples $ []
          :schema $ :: 'Fn
            {} (:return 'Unit)
              :args $ [] 'Tag 'Bool
        'start-control-loop! $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn start-control-loop! (duration f)
              let
                  now $ performance-now
                  elapsed $ / (- now @*last-tick) 1000
                  shift? @*shift-listener
                  states @*control-states
                  delta $ %{} ControlDelta
                    :left-move $ &c- (:left-move states) (:left-move @*prev-control-states)
                    :right-move $ &c- (:right-move states) (:right-move @*prev-control-states)
                f elapsed (assoc states :shift? shift?) delta
                reset! *last-tick now
                reset! *prev-control-states $ %{} ControlDelta
                  :left-move $ :left-move states
                  :right-move $ :right-move states
                if
                  and (:left-a? states) (:right-a? states)
                  try-fullscreen!
              reset! *timeout-loop $ unsafe-coerce
                js/setTimeout
                  fn () $ reset! *raq-loop
                    unsafe-coerce
                      js/requestAnimationFrame $ fn (p) (start-control-loop! duration f)
                      , Number
                  , duration
                , Number
          :examples $ []
          :schema $ :: 'Fn
            {} (:return 'Unit)
              :args $ [] 'Number
                :: 'Fn $ {} (:return 'Unit)
                  :args $ [] 'Number 'ControlState 'ControlDelta
              :features $ #{} :js-ffi
        'try-fullscreen! $ %{} 'CodeEntry (:doc |)
          :code $ quote
            defn try-fullscreen! () $ let
                window-host $ unsafe-coerce js/window WindowHost
                screen-host $ unsafe-coerce js/screen ScreenHost
                document-host $ unsafe-coerce js/document DocumentHost
              if
                not= (window-host :inner-height) (screen-host :height)
                .request-fullscreen! $ unsafe-coerce (document-host :document-element) FullscreenElementHost
              , &unit
          :examples $ []
          :schema $ :: 'Fn
            {} (:return 'Unit)
              :args $ []
              :features $ #{} :js-ffi
        'zero $ %{} 'CodeEntry (:doc |)
          :code $ quote
            def zero $ [] 0 0
          :examples $ []
          :schema $ :: 'List 'Number
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote (ns touch-control.core)
