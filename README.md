
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

使用者影响：候选 **0.0.34** 配对正式 **Calcit / @calcit/procs 0.31.0**，使用真实声明0.31的已发布JS-FFI **0.2.7**。消费者应协调完整模块图，重新生成JS并重启开发服务；如仍加载旧预构建缓存，可用 `yarn vite --force`。

Snapshot与已发布0.0.33及当前main相同；ControlState/ControlDelta、PointerEventHost回调、坐标、计时和清理行为均不改。0.0.33仍保留在0.30.1维护线，不移动旧tag或改该分支；本候选面向main的正式0.31使用方，发布前不引用main/hash替代tag。

DOM入口保留受检PointerEvent转换；目标缺失时报错，不增加nil默认或不安全转换。公开回调继续使用完整的touch-control.core/ControlState与ControlDelta类型身份。默认值、随机/计时与调用次数均保持。

Node.js24、Yarn4.18.0、Vite8.3.0及其他npm依赖保持，正常更新procs lock后执行不可变安装。原完整strict、全部定义、unit、构建及部署门禁保留；不新建测试框架或编译器规则。源码不变不代表所有平台或消费者已验收，正式结果以精确PR/main CI和实际Demo交互为准。

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
