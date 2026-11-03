
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

使用者影响：候选 **0.0.36** 配对正式 **Calcit / @calcit/procs 0.34.2**，使用正式
JS-FFI **0.2.9**。消费者应协调完整模块图，重新生成 JS 并刷新；旧预构建缓存可用
`yarn vite --force` 清除。0.0.35 保留在 0.32.1 线，不移动旧 tag。

官方 CLI 只规范化旧类型语法。与官方规范化后的原快照逐定义对照，公开状态、delta、
PointerEventHost、代码、schema 与原测试无语义变化。ControlState/ControlDelta 已是明确的
Struct，输出回调的三个参数及 Unit 返回型保持；schemaDynamic/unresolved 扫描为零，
不为了使用 union 重复包装这些已有合同，也不把二维 List 的长度伪装成静态证明。

DOM 入口保留受检 PointerEvent 转换，目标缺失时报错。按钮、Shift、坐标、计时、循环替换、
清理及 HUD 保持，不增加 nil 默认或 unsafe。Node 24、Yarn 4.18.0、原 npm 依赖与全部门禁
保持；本地正式 Caps strict/toolchain、immutable、全部 43 定义、完整 strict
（diagnostics=[]）、原 1 项 unit、deprecated-call=0、dynamic-method=0 及构建通过。
不新增检查脚本或测试框架；新精确 CI 和消费者验收仍需跟进。

此前 0.32.1 已验收四按钮/Shift/双手柄，以及 start/replace/重复 clear 与重启；本轮
尚未重新做浏览器或移动设备验收，不将历史结果当作新候选证据。此 PR 不合并、不部署、
不发布 tag/npm，0.0.36 在正式 tag 创建前仅为候选。

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
