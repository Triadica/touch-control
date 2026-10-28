
{}
  :about "|Machine-generated snapshot. Do not edit directly — changes will be overwritten. Use `calcit query` to inspect and `calcit edit`/`calcit tree` to modify. Run `calcit docs agents --contract` before mutations; use `--full` for first orientation or changed contract digest. Manual edits must follow format and schema conventions, then run `calcit edit format`."
  :package |touch-control
  :entries $ {} $ :default
    {} (:description |) (:init-fn 'touch-control.app.main/main!) (:mode :js) (:reload-fn 'touch-control.app.main/reload!) (:target :browser)
      :feature-policy $ {}
      :modules $ [] |js-ffi/
      :type-slots $ {}
  :files $ {}
    'touch-control.app.config $ %{} 'FileEntry
      :defs $ {}
        'dev? $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def dev? true
          :examples $ []
          :schema $ quote Bool
        'site $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def site
            {} (:dev-ui |http://localhost:8100/main-fonts.css) (:release-ui |http://cdn.tiye.me/favored-fonts/main-fonts.css) (:cdn-url |http://cdn.tiye.me/calcit-workflow/) (:title |Calcit) (:icon |http://cdn.tiye.me/logo/mvc-works.png) (:storage-key |workflow)
          :examples $ []
          :schema $ quote $ Map Tag String
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns touch-control.app.config
    'touch-control.app.main $ %{} 'FileEntry
      :defs $ {}
        'main! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn main! () (load-console-formatter!)
            println "|Running mode:" $ if config/dev? |dev |release
            render-control!
            start-control-loop! 300 $ fn (elapsed states delta) (show-data! elapsed states delta)
          :examples $ []
          :schema $ quote $ Fn (-> Unit) (:features :js-ffi)
        'mount-target $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def mount-target
            (browser/query-selector |.app) .unwrap
          :examples $ []
          :schema $ quote js-ffi.browser/DomElementHost
        'reload! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn reload! ()
            if (nil? build-errors)
              do
                replace-control-loop! 300 $ fn (elapsed states delta) (show-data! elapsed states delta)
                render-control!
                hud! |ok~ |Ok
              hud! |error build-errors
            , &unit
          :examples $ []
          :schema $ quote $ Fn (-> Unit) (:features :js-ffi)
        'show-data! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn show-data! (elapsed states delta)
            println |showing elapsed (:left-move states) (:right-move states) (:left-a? states) (:right-a? states)
            browser/element-set-text-content!
                browser/query-selector |pre
                , .unwrap
              format-cirru-edn $ {} (:states states) (:delta delta)
          :examples $ []
          :schema $ quote $ Fn Number touch-control.core/ControlState touch-control.core/ControlDelta (-> Unit) (:features :js-ffi)
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns touch-control.app.main
          :require (touch-control.app.config :as config)
            touch-control.core :refer $ render-control! start-control-loop! clear-control-loop! replace-control-loop!
            |./calcit.build-errors :default build-errors
            |bottom-tip :default hud!
            js-ffi.browser :as browser
            js-ffi.shared :as shared
    'touch-control.core $ %{} 'FileEntry
      :defs $ {}
        '%element $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defstruct %element
            :props $ quote $ Map Tag String
            :events $ quote $ Map Tag
              Fn js-ffi.browser/PointerEventHost (-> Unit) (:features :js-ffi)
            :children $ quote $ List touch-control.core/%element
          :examples $ []
          :schema $ quote StructDef
        '&c- $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn &c- (a b)
            let[] (x1 y1) a $ let[] (x2 y2) b $ [] (- x1 x2) (- y1 y2)
          :examples $ []
          :schema $ quote $ Fn (List Number) (List Number)
            -> $ List Number
          :tests $ [] $ %{} 'TestEntry (:name |subtracts-coordinates)
            :code $ quote $ assert |subtracts-coordinates
              = ([] 2 3)
                &c- ([] 5 7) ([] 3 4)
            :tags $ #{} :unit
        '*container $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defref *container (create-container-placeholder)
          :examples $ []
          :schema $ quote $ Ref js-ffi.browser/DomElementHost
        '*control-states $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defref *control-states
            ControlState :left-a? false :left-b? false :right-a? false :right-b? false :shift? false :left-move zero :left-prev zero :right-move zero :right-prev zero
          :examples $ []
          :schema $ quote $ Ref ControlState
        '*last-tick $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defref *last-tick (performance-now)
          :examples $ []
          :schema $ quote $ Ref Number
        '*left-origin $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defref *left-origin ([] 0 0)
          :examples $ []
          :schema $ quote $ Ref (List Number)
        '*prev-control-states $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defref *prev-control-states (ControlDelta :left-move zero :right-move zero)
          :examples $ []
          :schema $ quote $ Ref ControlDelta
        '*raq-loop $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defref *raq-loop 0
          :examples $ []
          :schema $ quote $ Ref Number
        '*right-origin $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defref *right-origin zero
          :examples $ []
          :schema $ quote $ Ref (List Number)
        '*shift-listener $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defref *shift-listener (install-shift-listeners!)
          :examples $ []
          :schema $ quote $ Ref Bool
        '*timeout-loop $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defref *timeout-loop 0
          :examples $ []
          :schema $ quote $ Ref Number
        'ControlDelta $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defstruct ControlDelta
            :left-move $ quote $ List Number
            :right-move $ quote $ List Number
          :examples $ []
          :schema $ quote StructDef
        'ControlState $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defstruct ControlState (:left-a? 'Bool) (:left-b? 'Bool) (:right-a? 'Bool) (:right-b? 'Bool) (:shift? 'Bool)
            :left-move $ quote $ List Number
            :left-prev $ quote $ List Number
            :right-move $ quote $ List Number
            :right-prev $ quote $ List Number
          :examples $ []
          :schema $ quote StructDef
        'clear-control-loop! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn clear-control-loop! () (browser/clear-timeout! @*timeout-loop) (browser/cancel-animation-frame! @*raq-loop) &unit
          :examples $ []
          :schema $ quote $ Fn (-> Unit) (:features :js-ffi)
        'connect-state $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn connect-state (field)
            {}
              :pointerdown $ fn (event)
                hint-fn $ Fn js-ffi.browser/PointerEventHost $ -> Unit
                ; js/console.log |down event
                set-button-state! field true
              :pointerup $ fn (event)
                hint-fn $ Fn js-ffi.browser/PointerEventHost $ -> Unit
                ; js/console.log |up event
                set-button-state! field false
          :examples $ []
          :schema $ quote $ Fn Tag
            -> $ Map Tag $ Fn js-ffi.browser/PointerEventHost (-> Unit)
        'create-container-placeholder $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn create-container-placeholder () (browser/create-element |div)
          :examples $ []
          :schema $ quote $ Fn (-> js-ffi.browser/DomElementHost) (:features :js-ffi)
        'div $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn div (props events & children) (%element :props props :events events :children children)
          :examples $ []
          :schema $ quote $ Fn (Map Tag String)
            Map Tag $ Fn js-ffi.browser/PointerEventHost $ -> Unit
            , & touch-control.core/%element (-> touch-control.core/%element)
        'document-body $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn document-body ()
            (browser/document-body) .unwrap
          :examples $ []
          :schema $ quote $ Fn (-> js-ffi.browser/DomElementHost) (:features :js-ffi)
        'install-shift-listeners! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn install-shift-listeners! ()
            browser/add-event-listener! |keydown $ fn (event)
              if
                and (keyboard-shift? event) (not @*shift-listener)
                reset! *shift-listener true
              , &unit
            browser/add-event-listener! |keyup $ fn (event)
              if
                and
                  not $ keyboard-shift? event
                  , @*shift-listener
                reset! *shift-listener false
              , &unit
            , false
          :examples $ []
          :schema $ quote $ Fn (-> Bool) (:features :js-ffi)
        'keyboard-shift? $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn keyboard-shift? (event)
            let
                host $ browser/keyboard-event-host event
              host :shift-key?
          :examples $ []
          :schema $ quote $ Fn js-ffi.browser/EventHost (-> Bool) (:features :js-ffi)
        'left-events $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def left-events
            let
                on-leave $ fn (event)
                  hint-fn $ Fn js-ffi.browser/PointerEventHost $ -> Unit
                  swap! *control-states assoc :left-move zero
                  swap! *prev-control-states assoc :left-move zero
                  , &unit
                on-enter $ fn (event)
                  hint-fn $ Fn js-ffi.browser/PointerEventHost $ -> Unit
                  reset! *left-origin $ [] (pointer-x event) (pointer-y event)
                  swap! *control-states assoc :left-move zero
                  swap! *prev-control-states assoc :left-move zero
                  , &unit
              {} (:pointerdown on-enter) (:pointerenter on-enter) (:pointerleave on-leave) (:pointerup on-leave)
                :pointermove $ fn (event)
                  hint-fn $ Fn js-ffi.browser/PointerEventHost $ -> Unit
                  let
                      move $ []
                        - (pointer-x event) (&list:nth @*left-origin 0)
                        - (&list:nth @*left-origin 1) (pointer-y event)
                    swap! *control-states assoc :left-move move
                  , &unit
          :examples $ []
          :schema $ quote $ Map Tag
            Fn js-ffi.browser/PointerEventHost $ -> Unit
        'performance-now $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn performance-now () (shared/performance-now)
          :examples $ []
          :schema $ quote $ Fn (-> Number) (:features :js-ffi)
        'pointer-x $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn pointer-x (event) (event :layer-x)
          :examples $ []
          :schema $ quote $ Fn js-ffi.browser/PointerEventHost (-> Number) (:features :js-ffi)
        'pointer-y $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn pointer-y (event) (event :layer-y)
          :examples $ []
          :schema $ quote $ Fn js-ffi.browser/PointerEventHost (-> Number) (:features :js-ffi)
        'remove-container! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn remove-container! (value) (browser/element-remove! value)
          :examples $ []
          :schema $ quote $ Fn js-ffi.browser/DomElementHost (-> Unit) (:features :js-ffi)
        'render-control! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn render-control! () (remove-container! @*container)
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
                dom $ render-dom! panel $ document-body
              reset! *container dom
              , &unit
          :examples $ []
          :schema $ quote $ Fn (-> Unit) (:features :js-ffi)
        'render-dom! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn render-dom! (el parent)
            let
                div $ browser/create-element |div
                props $ :props el
                events $ :events el
                children $ :children el
              &doseq
                k $ keys props
                browser/element-set-attribute! div
                  if (= k :className) |class $ to-string k
                  (get props k) .unwrap
              &doseq
                k $ keys events
                let
                    handler $
                      get events k
                      , .unwrap
                  browser/element-add-event-listener! div (to-string k)
                    fn (event)
                      hint-fn $ Fn js-ffi.browser/EventHost $ -> Unit
                      handler $ browser/pointer-event-host event
              &doseq (child children) (render-dom! child div)
              browser/append-child! parent div
              , div
          :examples $ []
          :schema $ quote $ Fn touch-control.core/%element js-ffi.browser/DomElementHost (-> js-ffi.browser/DomElementHost) (:features :js-ffi)
        'replace-control-loop! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn replace-control-loop! (duration f) (clear-control-loop!) (start-control-loop! duration f)
          :examples $ []
          :schema $ quote $ Fn Number
            Fn Number touch-control.core/ControlState touch-control.core/ControlDelta $ -> Unit
            -> Unit
            :features :js-ffi
        'right-events $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def right-events
            let
                on-enter $ fn (event)
                  hint-fn $ Fn js-ffi.browser/PointerEventHost $ -> Unit
                  reset! *right-origin $ [] (pointer-x event) (pointer-y event)
                  swap! *control-states assoc :right-move zero
                  swap! *prev-control-states assoc :right-move zero
                  , &unit
                on-leave $ fn (event)
                  hint-fn $ Fn js-ffi.browser/PointerEventHost $ -> Unit
                  swap! *control-states assoc :right-move zero
                  swap! *prev-control-states assoc :right-move zero
                  , &unit
              {} (:pointerdown on-enter) (:pointerup on-leave) (:pointerenter on-enter) (:pointerleave on-leave)
                :pointermove $ fn (event)
                  hint-fn $ Fn js-ffi.browser/PointerEventHost $ -> Unit
                  let
                      move $ []
                        - (pointer-x event) (&list:nth @*right-origin 0)
                        - (&list:nth @*right-origin 1) (pointer-y event)
                    ; js/console.log "|moving to" move
                    swap! *control-states assoc :right-move move
                  , &unit
          :examples $ []
          :schema $ quote $ Map Tag
            Fn js-ffi.browser/PointerEventHost $ -> Unit
        'set-button-state! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn set-button-state! (field value)
            cond
                = field :left-a?
                swap! *control-states assoc :left-a? value
              (= field :left-b?) (swap! *control-states assoc :left-b? value)
              (= field :right-a?) (swap! *control-states assoc :right-a? value)
              (= field :right-b?) (swap! *control-states assoc :right-b? value)
              true $ raise $ str-spaced |unknown-control-field field
            , &unit
          :examples $ []
          :schema $ quote $ Fn Tag Bool (-> Unit)
        'start-control-loop! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn start-control-loop! (duration f)
            let
                now $ performance-now
                elapsed $ / (- now @*last-tick) 1000
                shift? @*shift-listener
                states @*control-states
                delta $ ControlDelta :left-move
                  &c- (:left-move states) (:left-move @*prev-control-states)
                  , :right-move $ &c- (:right-move states) (:right-move @*prev-control-states)
              f elapsed (assoc states :shift? shift?) delta
              reset! *last-tick now
              reset! *prev-control-states $ ControlDelta :left-move (:left-move states) :right-move $ :right-move states
              if
                and (:left-a? states) (:right-a? states)
                try-fullscreen!
              reset! *timeout-loop $ browser/set-timeout!
                fn ()
                  reset! *raq-loop $ browser/request-animation-frame! $ fn (p) (start-control-loop! duration f)
                  , &unit
                , duration
              , &unit
          :examples $ []
          :schema $ quote $ Fn Number
            Fn Number touch-control.core/ControlState touch-control.core/ControlDelta $ -> Unit
            -> Unit
            :features :js-ffi
        'try-fullscreen! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn try-fullscreen! ()
            if
              not= (browser/viewport-height) (browser/screen-height)
              browser/element-request-fullscreen! $
                browser/document-element
                , .unwrap
            , &unit
          :examples $ []
          :schema $ quote $ Fn (-> Unit) (:features :js-ffi)
        'zero $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def zero ([] 0 0)
          :examples $ []
          :schema $ quote $ List Number
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns touch-control.core
          :require (js-ffi.browser :as browser) (js-ffi.shared :as shared)
