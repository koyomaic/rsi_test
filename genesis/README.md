# Genesis 创世智能体体系

> 一个可自进化的智能体种群管理体系：由「创世智能体」负责架构、创建、迭代、评价、革新、监督其他智能体，实现本目录 `goals.md` 中定义的目标与衡量标准。

## 体系结构

```
                          用户（L0 最终裁决者）
                                │ 目标 / 衡量标准 / 审批
                                ▼
                    ┌───────────────────────┐
                    │   genesis（创世主脑）   │  mode: all
                    │   唯一部署+登记权      │
                    └──────┬────────┬───────┘
              起草草稿 │        │ 派遣裁决
                       ▼        ▼
          ┌──────────────┐  ┌──────────────────┐
          │ architect    │  │ evaluator        │  两个 subagent
          │ 只写 variants │  │ 只写 reports     │  裁判与运动员分离
          └──────────────┘  └──────────────────┘
```

## 目录说明

| 路径 | 层 | 说明 | 变更权限 |
|---|---|---|---|
| `goals.md` | L0 | 目标、衡量标准、安全红线（宪法） | **仅用户批准**（权限 ask） |
| `registry.json` | 记账 | 全部智能体的版本链与状态，**只追加** | genesis |
| `eval/tasks/` | 评估集 | held-out 任务样本 | **仅用户批准**（权限 ask） |
| `variants/` | 草稿区 | architect 产出的候选版本 + 部署前备份 | architect / genesis |
| `reports/` | 裁决区 | evaluator 产出的评估报告 | evaluator |
| `.opencode/agents/` | L1 | 生效中的智能体定义 | 仅 genesis（经评估 PASS） |

理论依据见 `../agent-self-evolution.md`（变异 + 选择 + 保留闭环）。

## 快速开始

在 OpenCode 中（于 D:\SFI 目录启动）：

```text
# 切换到创世智能体（或让主 agent 派遣它）
/agents 选 genesis

# 常用指令（自然语言即可）
"创建一个 code-reviewer 智能体，负责……"
"评估 genesis-architect 当前版本"
"迭代 code-reviewer，上次报告说……"
"回滚 code-reviewer 到上一版"
"看下整个种群的状态"
```

## 自进化闭环

```
 备份当前版 → 变异(草稿) → 评估(held-out) → PASS? → 部署+登记 → 下一轮
                                      └ FAIL → 丢弃并记录原因
 现实信号连续下滑 / 用户指令 → 回滚到 parent 版本
```

## 注册说明

- **唯一真源**：`.opencode/agents/genesis*.md`（项目级，随本目录版本管理）
- 若当前 OpenCode server 从其他目录启动，`C:\Users\kmagic\.config\opencode\agents\` 下放有同名全局副本供即时可见；以项目级文件为准，修改后需同步

## 当前成员

| ID | 角色 | 状态 |
|---|---|---|
| `genesis` | 创世主脑：六大职能 + 部署登记权 | active |
| `genesis-architect` | 设计者：产出草稿，无部署权 | active |
| `genesis-evaluator` | 裁判：产出报告，对定义/评估集只读 | active |
