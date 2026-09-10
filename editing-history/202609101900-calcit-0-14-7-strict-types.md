# Calcit 0.14.7 and strict browser boundaries / Calcit 0.14.7 与严格浏览器边界

## English

- Upgrade Calcit and `@calcit/procs` to 0.14.7 and prepare release 0.0.20.
- Replace heterogeneous control maps with typed `ControlState` and `ControlDelta` structs.
- Model DOM, pointer, keyboard, screen, and fullscreen APIs with external-object traits.
- Keep only three intentional `Dynamic` inputs inside narrow browser-event adapters; unresolved Dynamic and dynamic method dispatch are both zero.
- Refresh the quality baseline and keep the unit, compile, and production-build gates passing.

## 中文

- 将 Calcit 与 `@calcit/procs` 升级到 0.14.7，并准备发布 0.0.20。
- 用强类型 `ControlState` 与 `ControlDelta` struct 替换异构控制状态 map。
- 使用 external-object trait 描述 DOM、指针、键盘、屏幕与全屏 API。
- 仅在窄化的浏览器事件适配器中保留 3 个有意的 `Dynamic` 输入；未解决 Dynamic 与动态方法分派均为零。
- 刷新质量基线，并保持单元测试、编译和生产构建检查通过。
