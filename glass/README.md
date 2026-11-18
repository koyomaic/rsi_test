# 玻璃研究员 (glass-researcher) 运行时资产

> 个体智能体 `glass-researcher` 的产出与结算账本。所有文件是该智能体衡量标准的**外部可验证证据**，供 genesis-evaluator 评估使用。

## 目录结构

| 路径 | 说明 | 更新者 |
|---|---|---|
| `daily/YYYYMMDD.md` | 每日研判报告（区间/方向/策略/结算） | glass-researcher |
| `journal.md` | 交易信号日志：逐笔记录入场信号、触发、结算盈亏 | glass-researcher |
| `performance.json` | 累计统计账本：胜率、入场率、违规计数 | glass-researcher |

## 衡量标准（registry 登记版）

| # | 标准 | 目标值 | 验证方式 |
|---|---|---|---|
| G1 | 按日结算 | 每个交易日产出 daily 报告并结算 | daily/ 文件存在性 + journal 结算行 |
| G2 | 策略胜率 | > 85% | performance.json 的 win_rate = wins/entered，且与 journal 逐笔一致 |
| G3 | 入场覆盖 | ≥ 80% 交易日已入场 | performance.json 的 entry_rate = entered/trading_days（**严格口径**：触发价实际被触及，非仅发出信号） |
| G4 | 零扛单 | violation_count = 0 | journal 无「止损被触及却未离场」条目 |

## 结算规则（与智能体规格 L0 冻结条款一致，防止口径漂移）

1. **入场判定**：按触发价成交——开盘价已过触发价按开盘价，否则盘中触及按触发价；忽略滑点
2. **离场判定**：止损价触及 → 止损离场（跳空穿越按开盘价成交）；目标价触及 → 目标离场；两者皆未触及 → 收盘平仓。**保守原则：当日高低点同时覆盖止损与目标 → 一律按止损记亏**
3. **盈亏（点）**：多头=离场价−入场价；空头=入场价−离场价；盈亏>0 计盈利笔
4. **扛单违规**：止损条件被触及却未按止损离场（改按目标/收盘了结或继续持有）→ 违规=是
5. **数据缺失日**：计入 trading_days 与 data_missing_days，**不计入**胜率与入场率分母
6. **记账细则**（滑点忽略、跳空按开盘）属 L1 可迭代项，但迭代**只允许更保守，不允许更宽松**（单向棘轮）

## 状态

- 智能体状态：**probation（试用期）**，部署于 `.opencode/agents/glass-researcher.md`
- 评估轮达标（G1–G4）后由 genesis 升级为 active
