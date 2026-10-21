
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

使用者影响：候选 0.0.32 对齐正式 Calcit / `@calcit/procs` 0.30.1 和 js-ffi 0.2.5。应用源码、ControlState/ControlDelta、PointerEventHost 回调、计时与清理行为不变。使用 strict Caps 的消费者应配套对齐工具链和直接/间接 js-ffi，不能与旧模块图混装。已发布 0.0.31 的 tag 保留原内容；0.0.32 正式发布前，下游不要引用候选 main/hash。

上一轮已将六处 Option 读取改为接收者 `.unwrap`；DOM 目标缺失时仍报错，本轮不添加 nil 默认或不安全转换。
升级 `@calcit/procs` 后需重启已有 Vite 开发服务；若仍加载旧依赖缓存，用 `yarn vite --force` 重新预构建。
DOM 入口完成一次受检 PointerEvent 转换，内部事件回调和坐标读取使用精确的 PointerEventHost 契约。
旧版 0.0.31 与 Pointed Prompt 0.0.19 仍属于 0.30.0 依赖图，不代表它们已同步本版。
公开回调签名使用完整的 `touch-control.core/ControlState` 和
`touch-control.core/ControlDelta` 类型名，保证跨模块回调的类型身份一致。
受检宿主转换现已由稳定工具链支持；下游使用模块发布 tag，不引用 main/hash。
使用 Node.js 24、Yarn 4.18.0、Vite 8.3.0；本轮保留 Vite 与其他 npm 依赖版本及安装安全策略。
正式 CLI 由 Linux CI 验收；macOS 本地旧版 0.30.0 基线不代替正式 0.30.1 检查，使用前检查目标平台 release 资产。
Validate the
exact toolchain, Snapshot, public types, unit behavior, and production
bundle with:

```bash
caps --strict --ci
yarn install --immutable
caps verify --toolchain
calcit calcit.cirru edit format
calcit calcit.cirru fix --workflow strict --verify --format json > /tmp/touch-control-strict.json
jq -e '.data.workflow.status == "passed" and (.diagnostics | length == 0)' /tmp/touch-control-strict.json
calcit calcit.cirru --check-only --all-defs
calcit calcit.cirru test --tag unit --require-match --summary-only --format json
yarn build
```

`yarn dev` 启动演示，另一个终端运行 `yarn watch` 监听 Calcit；`yarn release`
仅为构建别名，不发布模块。只维护 `calcit.cirru` / `deps.cirru`，不提交 `js-out/`。

生产前端通过 `VITE_BASE_URL=https://cos-sh.tiye.me/Triadica/touch-control/` 构建，
COS action 的 `public-base-url` 提供内置内容校验，不增加额外上传验证脚本。
配置 `COS_BUCKET`、`COS_SECRET_ID`、`COS_SECRET_KEY` 和原 `rsync_private_key`。
原服务器目录和固定 SSH 主机密钥校验保持不变；PR 不上传 COS 或部署服务器，只保留 7 天的 `dist` / `js-out` 构建 artifact，用于 Demo 和公开 API 交互验收，不包含凭据，也不将生成文件提交到 Git。
生产任务开始上传前检查 main revision，随后串行完成该 revision 的 COS 和服务器部署；
期间新提交排队，不中途取消，也不承诺与 main 原子同步。

### License

MIT
