
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

States are returned as the typed `ControlState` struct:

```cirru
:left-move $ [] 0 0
:right-move $ [] 0 0

:left-a? false
:left-b? false

:right-a? false
:right-b? false

:shift? false
```

Delta is returned as the typed `ControlDelta` struct:

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

模块 0.0.27 使用稳定版 Calcit / `@calcit/procs` 0.29.1 和正式版 js-ffi 0.2.1。
公开回调签名使用完整的 `touch-control.core/ControlState` 和
`touch-control.core/ControlDelta` 类型名，保证跨模块回调的类型身份一致。
受检宿主转换现已由稳定工具链支持；下游使用模块发布 tag，不引用 main/hash。
使用 Node.js 24、Yarn 4.18.0、Vite 8.3.0；8.3.2 仍受 Yarn 隔离策略限制，未绕过安全门禁。
Validate the
exact toolchain, Snapshot, public types, unit behavior, and production
bundle with:

```bash
caps --strict --ci
yarn install --immutable
caps verify --toolchain
calcit calcit.cirru edit format
calcit calcit.cirru --check-only
calcit --check-only --ns touch-control.core --ns touch-control.app.main --ns touch-control.app.config --summary-only --format edn
calcit calcit.cirru test --tag unit --require-match --summary-only --format json
yarn build
```

`yarn dev` 启动演示，另一个终端运行 `yarn watch` 监听 Calcit；`yarn release`
仅为构建别名，不发布模块。只维护 `calcit.cirru` / `deps.cirru`，不提交 `js-out/`。

生产前端通过 `VITE_BASE_URL=https://cos-sh.tiye.me/Triadica/touch-control/` 构建，
COS action 的 `public-base-url` 提供内置内容校验，不增加额外上传验证脚本。
配置 `COS_BUCKET`、`COS_SECRET_ID`、`COS_SECRET_KEY` 和原 `rsync_private_key`。
原服务器目录和固定 SSH 主机密钥校验保持不变；PR 只检查构建。
生产任务开始上传前检查 main revision，随后串行完成该 revision 的 COS 和服务器部署；
期间新提交排队，不中途取消，也不承诺与 main 原子同步。

### License

MIT
