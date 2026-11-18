# rsi_test

创世智能体（Genesis）自进化体系 —— 以玻璃期货研究员（glass-researcher）为首个闭环对象。

## 结构

```
.opencode/agents/     智能体定义（genesis 主脑 + architect/evaluator/glass-researcher）
genesis/              创世体系运行时资产
  goals.md            L0 宪法：目标/衡量标准/安全红线（修改需用户批准）
  registry.json       智能体注册表（版本链，只追加）
  eval/tasks/         评估集（held-out）
  variants/           变体草稿与部署前备份
  reports/            评估裁决报告与日度进化日志
  scripts/            日度 pipeline（计划任务 19:30 自动四段式）
glass/                玻璃研究员运行时资产
  daily/              每日研判日报
  journal.md          结算台账（唯一事实源，15 列含规格版本）
  performance.json    指标账本（胜率/入场率/违规，幂等重算）
agent-self-evolution.md  自进化架构理论
```

## 日度循环

```
19:30（每工作日，Windows 计划任务，无需 UI）
  ① 结算昨日信号 → ② 进化（差距→归因→五维度立项）→ ③ 新版本产出研判 → ④ 钉钉播报
```

进化铁律：**真正的进化 = 结果距衡量标准持续收窄**（胜率 >85%、入场率 ≥80%、零扛单违规）。

变更记录见 `genesis/registry.json` 版本链（v1→v4）与 `genesis/reports/` 裁决报告。
