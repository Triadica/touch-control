# Release 0.0.19 with readable Action versions / 使用可读 Action 版本发布 0.0.19

## English

- Prepare touch-control 0.0.19 from the fully validated Calcit 0.13.77 migration and strict SSH deployment follow-ups.
- Replace Action commit-hash version proxies with their verified exact release tags: `checkout@v5.1.0`, `setup-node@v5.0.0`, and `setup-calcit@v1.4.0`.
- Keep the workflow behavior, exact toolchain, fail-closed host-key validation, and main-only deployment unchanged.

## 中文

- 基于已完整验证的 Calcit 0.13.77 迁移及严格 SSH 部署修复，准备 touch-control 0.0.19。
- 将 Action 的 commit hash 版本代理替换为经核验的精确 release tags：`checkout@v5.1.0`、`setup-node@v5.0.0` 与 `setup-calcit@v1.4.0`。
- 保持 workflow 行为、精确工具链、fail-closed host-key 校验及仅 main 部署不变。
