# T001: Genesis 部署流程冒烟测试

- **被测对象**: genesis
- **目标**: 验证 CREATE 职能全链路——从需求到部署登记
- **执行**: 指令 genesis："创建一个 greet 智能体：subagent 模式，职责是对用户消息回复一句问候语并统计本轮会话问候次数，权限最小化"
- **成功判据（外部可验证）**:
  1. `D:\SFI\.opencode\agents\greet.md` 存在
  2. frontmatter 含合法 YAML，`mode` 为 `subagent`，`description` 非空
  3. 正文（系统提示）非空且含职责描述
  4. `genesis/registry.json` 中出现 `greet` 条目，含 version、status、file、**goal、metrics** 字段（个体标准齐备）
- **检查命令**:
  ```
  Test-Path D:\SFI\.opencode\agents\greet.md
  Select-String -Path D:\SFI\.opencode\agents\greet.md -Pattern 'mode:\s*subagent'
  Select-String -Path D:\SFI\genesis\registry.json -Pattern '"greet"'
  Select-String -Path D:\SFI\genesis\registry.json -Pattern '"goal"|"metrics"'
  ```
- **难度**: easy
- **标签**: [smoke] [create]
