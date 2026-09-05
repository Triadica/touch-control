
Touch Control
----

> for Quatrefoil [calcit-js](https://github.com/calcit-lang/calcit). This lib targets Chrome mobile.

Demo http://r.tiye.me/Quatrefoil-GL/touch-control/ .

### Usages

Import via calcit:

```cirru
; "renders to body"
touch-control.core/render-control!

; "where you can get states"
println touch-control.core/*control-states

; create looper
touch-control.core/start-control-loop! 300 $ fn (elapsed states delta)

; clear loop on reload
touch-control.core/clear-control-loop!

; alias of clearing and createing
touch-control.core/replace-control-loop! 300 $ fn (elapsed states delta)
```

States:

```cirru
:left-move $ [] 0 0
:right-move $ [] 0 0

:left-a? false
:left-b? false

:right-a? false
:right-b? false

:shift? false
```

Delta:

```cirru
:left-move $ [] 0 0
:right-move $ [] 0 0
```

To load styles:

```bash
npm i @quamolit/touch-control
```

```css
@import url("@quamolit/touch-control/style/touch-control.css");
```

### Workflow

https://github.com/calcit-lang/respo-calcit-workflow

### Compatibility and validation

Touch Control 0.0.18 targets Calcit and `@calcit/procs` 0.13.77. Validate the
exact toolchain, Snapshot, static-quality budget, unit behavior, and production
bundle with:

```bash
caps --strict --ci
yarn install --immutable
caps verify --toolchain
calcit calcit.cirru edit format
calcit calcit.cirru --check-only
calcit calcit.cirru analyze dynamic-methods --max 0
calcit calcit.cirru analyze quality --baseline config/calcit-quality.cirru
calcit calcit.cirru test --tag unit --require-match --summary-only --format json
calcit calcit.cirru js
yarn vite build --base=./
```

### License

MIT
