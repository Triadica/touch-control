
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

使用者影响：候选 **0.0.37** 将 JS-FFI 依赖升级到正式 **0.2.10**，继续配对
**Calcit / @calcit/procs 0.34.2**。消费者需协调完整模块图；严格安装不应混用
JS-FFI 0.2.9 和 0.2.10。已经发布的 0.0.36 保留旧配对，不移动旧 tag。

本次不修改 Snapshot：ControlState、ControlDelta、PointerEventHost、公开回调、
按钮、Shift、坐标、计时、循环替换、清理及 HUD 均保持。状态与 delta 已有明确 Struct
合同，不为了使用 union 重复包装，也不将二维 List 的长度伪装成静态证明。

本地正式 Caps strict/toolchain、Yarn immutable、全部定义、完整 strict
（diagnostics=[]）、原 1 项 unit、deprecated-call=0、dynamic-method=0 及构建通过。
与已发布 0.0.36 的 Snapshot 字节一致；不新增检查脚本、测试框架或放宽类型门禁。

此前版本的四按钮、Shift、双手柄和循环生命周期验收仅作历史记录；本候选尚未重新
验收浏览器或移动设备，不能由静态与构建结果推断交互已通过。新精确 CI 和消费者
验收仍需跟进。0.0.37 在正式 Git tag 创建前仅为候选，不发布 npm。

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
