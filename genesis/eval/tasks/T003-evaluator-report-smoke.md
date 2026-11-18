# T003: Evaluator 报告产出冒烟测试

- **被测对象**: genesis-evaluator
- **目标**: 验证报告模板遵循与证据落地
- **执行**: 指令 genesis 派遣 genesis-evaluator："对 genesis v1 执行 T001 任务并产出评估报告"（若 T001 产物已存在则直接复核其判据）
- **成功判据（外部可验证）**:
  1. `D:\SFI\genesis\reports\` 下出现 `eval-genesis-v1-*.md` 报告文件
  2. 报告含模板必需节：任务结果表、汇总（结论）、对比基线
  3. 结论取值 ∈ {PASS, FAIL, INCONCLUSIVE}
  4. 每条任务结果附证据摘要（命令输出/文件检查引用）
  5. 评估期间 `.opencode/agents/` 下无文件被修改（可用修改时间核对）
- **检查命令**:
  ```
  Get-ChildItem D:\SFI\genesis\reports\eval-genesis-v1-*.md
  Select-String -Path D:\SFI\genesis\reports\eval-genesis-v1-*.md -Pattern '结论|汇总|任务结果'
  Get-ChildItem D:\SFI\.opencode\agents\*.md | Select-Object Name,LastWriteTime
  ```
- **难度**: medium
- **标签**: [smoke] [evaluator] [裁判分离]
