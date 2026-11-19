# 评估报告：glass-framework v1.0 deploy

- **日期**: 2026-11-19
- **评估者**: genesis-evaluator
- **被测文件**: `D:\SFI\genesis\variants\glass-framework.v1.deploy.md`
- **基线**: `eval-glass-framework-v1-r2-20261119.md`

## 任务结果

| 任务 | 结果 (PASS/FAIL/N-A) | 证据摘要 |
|---|---|---|
| T001 状态行 diff | PASS | `git diff --no-index --unified=0` 仅有 `@@ -3 +3 @@` 一个 hunk：draft 待裁决状态替换为 probation 只读资产状态及 r2 报告路径。 |
| T002 其他字节与方法正文一致 | PASS | 两边行数一致，变化行号严格为 `[3]`；用该替换从已评估稿重建的 Buffer 与 deploy 原文件 `Buffer.compare=0`，移除状态文本后的正文也完全一致。 |
| T003 probation 与 r2 一致 | PASS | deploy 状态含 probation、2026-11-19、PASS、6/6 和既有 r2 路径；r2 文件实际结论为 PASS、计数为 6/0/0，被测文件为 `glass-framework.v1.md`。 |
| T004 glass-researcher 冻结 | PASS | agent 仍自述 v4；SHA-256 为 `C1F1C247CA75518F4175A45A301CBA64B3026B8A0BA225E2B13819FD1C9FCBF6`，与 r2 核验值一致。 |

### 命令级证据

#### 1. 唯一 diff hunk

执行：

```text
git diff --no-index --unified=0 -- glass-framework.v1.md glass-framework.v1.deploy.md
```

关键输出：

```diff
@@ -3 +3 @@
-> 状态：draft，待 genesis-evaluator 裁决；未经 PASS 不得作为 glass-researcher 的正式研判依据。
+> 状态：probation（只读框架资产）；2026-11-19 第二轮静态评估 PASS（6/6，报告：`genesis/reports/eval-glass-framework-v1-r2-20261119.md`）。供 F2 实装；不代表任何结果指标已改善，F2 修改研究员规格仍须另走协议。
```

没有第二个 hunk，没有方法正文、评分表、公式或其他段落的 diff。

#### 2. 字节级重建与正文一致性

独立 Node 命令执行以下检查：

1. 两稿按相同换行规则拆分，行数一致，逐行比较的差异索引必须严格等于 `[3]`。
2. 取已评估稿原状态文本，仅替换为 deploy 状态文本，再编码为 UTF-8 Buffer；与 deploy 原始字节执行 `Buffer.compare`，结果必须为 0。
3. 分别移除两稿的状态文本，余下字符串必须完全相同，并计算规范化正文 SHA-256。

实际输出：

```text
CHANGED_LINE_NUMBERS=[3]; SOURCE_LINES=361; DEPLOY_LINES=361
REBUILT_DEPLOY_BYTE_COMPARE=IDENTICAL; DEPLOY_BYTES=19611; SOURCE_BYTES=19463
ALL_OTHER_BYTES_AFTER_STATUS_REMOVAL=IDENTICAL; NORMALIZED_BODY_SHA256=B6969842C3E06815227ACF3560E2C689DDA72C9F8E1C940E4BD45E2B73C22CA1
DEPLOY_METADATA_BYTE_ASSERTIONS=PASS
```

两边拆分后的 361 项均包含末尾空项。deploy 比 source 多 148 字节，全部来自这一处状态文本替换；重建比较覆盖了换行及其他不可见字节，因此不只是文本目测一致。

评估前文件哈希：

```text
D9E5E81D9509D7E0B4CCF8DDBC25D34A23E69CC76081CDFF0FC5C23CC5231E12  glass-framework.v1.md
27940543A2D362502AEAE4C3D70DA4E817EA100973B483BC212BF70B5BCE14A5  glass-framework.v1.deploy.md
```

source 哈希与 r2 评估时记录的修订稿哈希一致。

#### 3. 状态与 r2 报告交叉核验

```text
R2_STATUS_CROSSCHECK=PASS; probation references existing r2 report with conclusion PASS and 6/0/0
```

deploy 引用路径 `genesis/reports/eval-glass-framework-v1-r2-20261119.md` 实际存在。该报告包含：

- 被测文件：`D:\SFI\genesis\variants\glass-framework.v1.md`；
- 六项任务全部 PASS；
- 汇总：`6 / 0 / 0`；
- 结论：`PASS`。

deploy 状态同时明示“只读框架资产”“不代表任何结果指标已改善”及“F2 修改研究员规格仍须另走协议”，与 r2 的部署边界一致。

#### 4. agent 未改

```text
AGENT_SHA256=C1F1C247CA75518F4175A45A301CBA64B3026B8A0BA225E2B13819FD1C9FCBF6
GLASS_RESEARCHER_V4_UNCHANGED=PASS
```

`.opencode/agents/glass-researcher.md` 第 42 行仍明确“本提示词自述规格版本为 v4”。本轮未修改 agent、registry、评估集或任何框架输入。

## 汇总

- 样本数: 4 项部署前元数据核验。
- 通过 / 失败 / 无法判定: 4 / 0 / 0
- **结论**: PASS
- **部署裁决**: deploy 稿与 r2 已评估稿之间只存在声明的 probation 状态行变化，可作为只读 probation 框架资产进入既定部署流程。
- **能力边界**: 本结论仅是部署元数据与字节一致性核验，不是新一轮方法或运行评估，不新增任何结果性能力声明，不代表胜率、方向率、入场率或区间覆盖率改善，也不改变 glass-researcher v4 行为。

## 对比基线

| 指标 | 基线：r2 报告 | 本次部署核验 | Δ |
|---|---|---|---|
| 结论 | 静态复审 PASS（6/6） | 部署元数据 PASS（4/4） | 无方法或能力变化 |
| 已评估 source 哈希 | `D9E5E81D...231E12` | `D9E5E81D...231E12` | 0 |
| agent | v4，哈希 `C1F1C247...CBF6` | v4，哈希 `C1F1C247...CBF6` | 0 |
| 方法正文/评分/公式 | r2 已评估内容 | 除状态行外逐字节一致 | 0 |
| 运行时结果 | 未测量 | 未测量 | N-A |

## 异常与观察

1. `git diff --no-index` 在文件有差异时返回退出码 1，这是预期行为，不是核验失败。
2. Git 输出 LF 未来可能转换为 CRLF 的提示；本轮只执行只读 diff，没有触发转换。Node Buffer 重建另行验证了当前文件字节，评估后哈希复核用于排除输入变化。
3. 本任务未重新运行 r2 的算术与方法测试，因为 deploy 方法字节已被证明与 r2 被测 source 完全一致；本报告不扩大 r2 的结论范围。
4. 首轮、r2 报告均保留；本轮唯一写入产物为 `eval-glass-framework-v1-deploy-20261119.md`。报告写盘后复核 source、deploy、r2、agent 和模板 5/5 哈希一致，输出 `DEPLOY_READ_ONLY_INTEGRITY=PASS; 5/5 checked inputs unchanged`。

## Gaming 嫌疑

未发现。

deploy 未借状态变更修改评分、公式、数据口径或边界，且明确保留“静态 PASS 不代表结果改善”和 F2 协议限制。结论仅基于 git diff、Node Buffer 比较、既有 r2 文件内容和 agent 哈希。

## 建议

1. 按只读 probation 资产使用该 deploy 文件；不得将其直接解释为 glass-researcher 新规格或交易权限变更。
2. F2 实装仍另走变体协议，并沿用 r2 的 null、基差、置信度和小样本回归判例。
3. 后续若 deploy 状态之外的任何字节变化，应重新执行方法评估，不能复用本元数据 PASS。
4. 结果性能力只能由后续真实前瞻样本和相应运行评估证明，本报告不得作为结果改善证据。
