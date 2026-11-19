# 评估报告：glass-framework v1.0-r2

- **日期**: 2026-11-19
- **评估者**: genesis-evaluator
- **被测文件**: `D:\SFI\genesis\variants\glass-framework.v1.md`
- **基线**: `eval-glass-framework-v1-20261119.md`

## 任务结果

| 任务 | 结果 (PASS/FAIL/N-A) | 证据摘要 |
|---|---|---|
| T1 契约完整性 | PASS | 修订稿仍具 21/21 个所需章节及因子/修正器子节；适用边界、三层、数据契约、新鲜度、矩阵、四因子、合成、修正器、技术/F2 接口、评价、防 gaming、进化和局限均完整。 |
| T2 数据源与实测一致性 | PASS | 数据矩阵未在 diff 中变更；生意社全国元/㎡仅趋势、沙河元/吨约周度同口径、99qh 全部合约/第三方镜像、库存与日熔量约周度、转载同源及 MCP 非 FG 主数据均与实测一致。 |
| T3 独立算术验证 | PASS | 更正 oracle 后五向量全部通过；案例④独立得到 `C=0.8, weighted=1.1, S=1.375, 偏多, 高置信`。缺失补 0 反例仍将案例②③错误翻多，正确实现则排除 null 的分子和分母。 |
| T4 方法一致性与可计算性 | PASS | 供给未知、需求全单期均为 null 并退出评分；已知稳定/相等仍为 0，部分连续需求趋势可降级评分并披露。指定基差组合、区间重叠 null、单位拒绝、置信度截断/锁低及 G5/G6 小样本闸门全部通过。 |
| T5 边界与无偷跑 | PASS | diff 未触及 ATR、结算、交易权限或 F2 协议边界；当前 agent 仍自述 v4，评估前后 SHA-256 均为 `C1F1C247...CBF6`。 |
| T6 诚实性与 gaming | PASS | 权重/阈值仍标为未验证启发式；小样本只作诊断；保留数据滞后、口径、相关性、静态评估限制及禁止结果性进化宣称条款。未发现 gaming。 |

> 路径缩写：V=当前修订稿；F=`glass-framework.v1.fail1.20261119.md`；A=`glass/research/data-source-audit.md`；M=`glass/research/methodology-survey.md`；G=`.opencode/agents/glass-researcher.md`。行号均为 1-based。

### Diff 范围审计

执行只读命令：

```text
git diff --no-index --unified=3 -- F V
git diff --no-index --numstat -- F V
```

`numstat` 输出：

```text
22	12	D:/SFI/genesis/variants/{glass-framework.v1.fail1.20261119.md => glass-framework.v1.md}
```

完整 unified diff 只有 **5 个 hunk**，逐项映射如下，未发现声明外实质变更：

| 声明变更 | diff 证据 | 审计结果 |
|---|---|---|
| 1. 供给未知改 null | F:L133 的“相等/无法判断净方向→0”改为 V:L133 仅“已取得连续日熔量且稳定”或“已取得可比产能且相等”为 0；新增 V:L136，两个方向均因缺失/stale/口径冲突/覆盖不足无法判断时=null。 | 与声明一致 |
| 2. 需求单期防线 | F:L147 的单期水平→0改为 V:L148 仅连续稳定或趋势抵消为 0；V:L151 全单期或连续数据缺失/stale=null；V:L153 允许部分指标有连续趋势时按可判断指标降级评分并披露。 | 与声明一致 |
| 3. 基差操作化 | F:L164-L176 的定性规则替换为 V:L166-L184：组件 +1/0/-1/null、相邻同口径点值、区间上下限及重叠规则、绝对基差同日 FG 结算价和同单位约束、可用组件数及 ±2/±1/0/null 合成。 | 与声明一致 |
| 4. 持仓置信度截断 | 仅在持仓修正器新增 V:L237：低/中/高截断，C<0.60 或重大口径冲突锁低，确认不能补高置信数据条件，背离可下调。 | 与声明一致 |
| 5. G5/G6 小样本披露 | F:L310-L311 扩展为 V:L320-L321，补齐规定计数；方向样本或有效区间样本<20只作诊断。 | 与声明一致 |

其他确认：

- 失败快照 SHA-256 为 `4478911B085DF28DD9D7F41460415A7D16BFAD14201AAB5441446DE4631343BF`，与首轮报告记录的被测失败稿哈希一致，审计链一致。
- 修订稿评估前 SHA-256 为 `D9E5E81D9509D7E0B4CCF8DDBC25D34A23E69CC76081CDFF0FC5C23CC5231E12`。
- C/S 权重和公式所在区段不在 diff 中；V:L192-L199 仍为库存 0.30、供给 0.25、需求 0.25、基差 0.20，未为迎合首轮错误 oracle 改权重。
- 数据源矩阵、技术/执行参数、agent 定义、进化触发器和已知局限没有隐藏改动。

### T1：契约完整性复核

Node 按 UTF-8 只读文件并断言标题，输出：

```text
T1_CONTRACT_ASSERTIONS=PASS; 21/21 headings; lines=10,31,54,71,85,102,111,125,140,155,188,190,201,220,241,252,262,273,312,339,352
```

逐项定位：

| 契约项 | 修订稿证据 |
|---|---|
| 适用边界与三层结构 | V:L10-L27、L31-L48 |
| 统一数据契约、新鲜度、数据源矩阵 | V:L54-L69、L71-L83、L85-L99 |
| 四因子评分 | 库存 L111-L123、供给 L125-L138、需求 L140-L153、基差/月差 L155-L184 |
| 覆盖率、方向、置信度 | V:L188-L218 |
| 持仓、成本、事件修正器 | V:L220-L239、L241-L250、L252-L258 |
| 技术与执行接口 | V:L262-L269 |
| F2 输出契约与 Skill 边界 | V:L273-L308 |
| 结果评价与防 gaming | V:L312-L335 |
| 进化触发器 | V:L339-L348 |
| 已知局限 | V:L352-L360 |

### T2：数据源与实测一致性复核

| 关键限制 | 修订稿 | 实测/原料 | 结果 |
|---|---|---|---|
| 全国元/㎡只看趋势 | V:L24、L90、L184；无同单位沙河价时绝对基差组件=null，不输出绝对基差。 | A:L21、L45、L160：全国基准价元/㎡，非沙河 5mm 专项。 | PASS |
| 沙河元/吨约周度、同单位 | V:L91、L160、L164、L170；要求同区域、品规、税口径、单位及两期可比。 | A:L28-L29、L45：850-910 元/吨，约周度，与 FG 同单位。 | PASS |
| 99qh 全部合约及镜像 | V:L92、L229、L357。 | A:L66、L162：默认全部合约，第三方镜像，需抽样核对。 | PASS |
| 库存/日熔量低频 | V:L25、L77、L82、L93-L94。 | A:L95、L104、L122、L161：约周度，不作每日驱动。 | PASS |
| 公开转载可能同源 | V:L83、L358。 | A:L162：同源于隆众/卓创，多源不能消除单样本系统偏差。 | PASS |
| MCP 不作 FG 主数据 | V:L26、L98。 | M:L117、L227：现用 FG/SA 指标不覆盖，玻璃研究以公开 web 为主。 | PASS |

最终静态命令输出：`T2_SOURCE_MAPPING_AND_T5_AGENT_V4_ASSERTIONS=PASS`。

### T3：更正 oracle 后的独立算术证据

独立 Node 实现仅累加非 null 因子：

```text
C = Σ可用权重
weighted = Σ(可用权重 × 分数)
S = C > 0 ? weighted / C : null
C < 0.60 => 中性/低置信；否则按 ±0.30 判方向
```

命令输出：

```text
T3_CASE_1=PASS {"C":1,"weighted":0.45,"S":0.45,"direction":"BULLISH","confidence":"HIGH"}
T3_CASE_2=PASS {"C":0.45,"weighted":0.45,"S":1,"direction":"NEUTRAL","confidence":"LOW"}
T3_CASE_3=PASS {"C":0.55,"weighted":0.85,"S":1.5454545454545452,"direction":"NEUTRAL","confidence":"LOW"}
T3_CASE_4=PASS {"C":0.8,"weighted":1.1,"S":1.375,"direction":"BULLISH","confidence":"HIGH"}
T3_CASE_5=PASS {"C":0,"weighted":0,"S":null,"direction":"NEUTRAL","confidence":"LOW"}
MISSING_AS_ZERO_CASE_2={"C":1,"S":0.45,"direction":"BULLISH"}
MISSING_AS_ZERO_CASE_3={"C":1,"S":0.85,"direction":"BULLISH"}
T3_ALL_5_VECTORS_AND_NULL_COUNTEREXAMPLES=PASS
```

案例④与本轮更正 oracle 完全一致：`C=0.80、weighted=1.10、S=1.375、偏多`。补 0 反例仅用于证明错误实现的风险，不是框架输出；正确实现下案例②③因覆盖不足均为中性低置信。

### T4：修订规则独立注入与计算证据

#### 4.1 供给与需求 null 防线

```text
SUPPLY_UNKNOWN=null; SUPPLY_ONLY_COMPOSITION={"C":0,"weighted":0,"S":null}
SUPPLY_UNKNOWN_MIXED_COMPOSITION={"C":0.75,"weighted":0.75,"S":1}; expected_C=0.75_not_1.0
DEMAND_ALL_SINGLE={"score":null,"degraded":false,"disclosure":"no marginal trend; excluded"}; DEMAND_ONLY_COMPOSITION={"C":0,"weighted":0,"S":null}
DEMAND_PARTIAL_CONTINUOUS={"score":1,"degraded":true,"disclosure":"partial indicators lack trend; score downgraded using continuous evidence"}
KNOWN_NEUTRAL_CHECKS={"supply_stable":0,"supply_equal":0,"demand_stable":0}; STALE_DEMAND=null
T4_SUPPLY_DEMAND_NULL_INJECTIONS=PASS; unknown excluded, known neutral remains zero, partial trend disclosed
```

结论：供给未知与需求全单期均未按 0 进入覆盖率；混合案例中供给 null 使 C 为 0.75 而非 1.0。已知稳定/相等证据仍可为 0，部分需求指标具有连续改善趋势时仅按可判断指标给 +1，并输出降级披露。

#### 4.2 基差组件、区间和单位

指定组合及补充边界输出：

```text
BASIS_[1,1,1]=2 PASS
BASIS_[1,1,null]=1 PASS
BASIS_[1,0,null]=0 PASS
BASIS_[1,1,-1]=0 PASS
BASIS_[-1,-1,0]=-1 PASS
BASIS_[1,null,null]=null PASS
BASIS_[0,null,null]=null PASS
BASIS_[-1,-1,-1]=-2 PASS
BASIS_[-1,-1,null]=-1 PASS
BASIS_[1,-1,null]=0 PASS
BASIS_[1,1,0]=1 PASS
BASIS_[0,0,null]=0 PASS
INTERVAL_DISJOINT_UP=1 PASS
INTERVAL_DISJOINT_DOWN=-1 PASS
INTERVAL_EXACT_SAME=0 PASS
INTERVAL_OVERLAP_BOTH_BOUNDS_UP=null PASS
INTERVAL_CONTAINMENT=null PASS
INTERVAL_ONE_UP_ONE_DOWN=null PASS
INTERVAL_TOUCHING=null PASS
ABSOLUTE_BASIS_RANGE=[-50,10]; UNIT_MISMATCH=null; SPEC_MISMATCH=null
T4_BASIS_COMPONENT_INTERVAL_AND_UNIT_ASSERTIONS=PASS
```

点值大于/等于/小于相邻同口径前值分别得到 +1/0/-1；跨口径或非相邻观测为 null。区间即使上下限都上升，只要交叉重叠仍为 null，不取中点。`[850,910]元/吨 - FG 900元/吨` 保留为基差区间 `[-50,10]`；元/㎡与元/吨、品规不一致均拒绝输出绝对基差数值。

#### 4.3 持仓置信度截断与锁低

```text
COVERAGE_045_CONFIRM_LOCK: C=0.45, initial=LOW, overlay=CONFIRM, final=LOW PASS
MAJOR_CONFLICT_CONFIRM_LOCK: C=1, majorConflict=true, final=LOW PASS
C075_CONFIRM_CAP_MEDIUM: C=0.75, highEligible=false, final=MEDIUM PASS
STRONG_CONFLICT_CONFIRM_CAP_MEDIUM: C=0.8, S≈0.4375, strong conflict, final=MEDIUM PASS
HIGH_CONFIRM_NO_OVERFLOW: initial=HIGH, final=HIGH PASS
LOW_DIVERGE_NO_UNDERFLOW: initial=LOW, final=LOW PASS
HIGH_DIVERGE: initial=HIGH, final=MEDIUM PASS
POSITIONING_DIRECTION_INVARIANCE=PASS; C/S/direction unchanged and low lock preserved
T4_CONFIDENCE_CLAMP_AND_LOCK_ASSERTIONS=PASS
```

覆盖不足与重大口径冲突不能被持仓确认解锁；不满足高置信条件时确认最多中；高/低不溢出，持仓不改变 C、S 或方向。强因子反向冲突仍按 V:L216 的权重≥0.25、反向且绝对分=2执行。

#### 4.4 G5/G6 公式、完整计数与小样本闸门

```text
G5_MIXED: valid=4, directional=3, correct=2, accuracy=0.666666..., direction_coverage=0.75, diagnostic_only=true
G5_ALL_NEUTRAL: valid=2, directional=0, accuracy=null, direction_coverage=0, diagnostic_only=true
G5_N19: accuracy=1, diagnostic_only=true, result_claim_allowed_by_sample_size=false
G5_N20_SAMPLE_GATE: directional=20, result_claim_allowed_by_sample_size=true
G6_FULL={"coverage":1,"fullyContained":true}; G6_PARTIAL={"coverage":0.5,"fullyContained":false}; G6_DISJOINT={"coverage":0,"fullyContained":false}; G6_FLAT.coverage="N-A"
G6_N19: valid_samples=19, diagnostic_only=true, result_claim_allowed_by_sample_size=false
G6_N20_SAMPLE_GATE: valid_samples=20, result_claim_allowed_by_sample_size=true
G5_G6_FORMULAS_REQUIRED_COUNTS_AND_SMALL_SAMPLE_GATES=PASS; sample gate is not evidence of improvement
```

即使 19 个方向样本准确率为 100%，仍只作诊断；达到 20 仅表示样本量闸门解除，不代表实际准确率已改善。全中性预测没有方向准确率可报，且 `direction_coverage=0`。

#### 4.5 既有安全规则回归

- 缺失/stale=null、禁止按 0 补齐：V:L81、L106-L107、L199。
- 成本不进入 S，亏损不得直接做多：V:L241-L250，尤其 L245。
- 持仓只调置信/风险，不翻方向：V:L239；事件不直接改 S：V:L252-L258。
- 同单位绝对基差与区间保留：V:L160-L170；全国元/㎡不输出绝对基差：V:L184。
- 新增规则未引入“未知=中性”、跨单位计算或首轮所指的“明显”等基差不可计算措辞。

### T5：边界、权限与冻结复核

- V:L27 仍禁止修改结算规则、执行交易及扛单/摊平；V:L267 仍不修改 ATR 参数、不承诺提高入场率或胜率。
- V:L269 仍规定 F2 正式修改 glass-researcher 规格必须另走变体协议，本框架部署本身不改变 v4 行为。
- 当前 G:L42 仍自述 v4；G:L114-L129 结算红线、G:L215-L223 ATR/触发/目标/止损参数、G:L227-L231 数据诚信/只建议不执行/产物边界均未改变。
- agent 评估前 SHA-256 为 `C1F1C247CA75518F4175A45A301CBA64B3026B8A0BA225E2B13819FD1C9FCBF6`，与首轮末哈希一致；报告写盘后复核仍完全一致。
- 首轮报告保留，未覆盖；本轮唯一写入产物为 `eval-glass-framework-v1-r2-20261119.md`。

### T6：诚实性与防 gaming 复核

- V:L6、L218、L354：权重和阈值仍为待验证启发式，尚无样本验证，禁止每日临时调阈。
- M:L229 区分较强库存/期现先验与成本底/冷修时滞弱规律；V:L22、L245-L250 不允许成本亏损直接反转做多。
- V:L355-L360 继续披露数据滞后、绝对基差频率、第三方镜像、同源样本、因子相关性和静态评估局限。
- V:L316 禁止宣称 G1-G4 已改善；V:L334 静态 PASS 不得标为结果性进化；V:L320-L321 新增小样本诊断限制。
- V:L326-L328 保持回测/前瞻分账，V:L332-L335 保持相关性披露与回滚要求。

## 汇总

- 样本数: 6 个裁决任务；另审计 5 个 diff hunk，执行 5 个 C/S 向量、2 个补 0 反例、供给/需求 null 与降级注入、12 个基差组合、7 个区间边界、7 个置信度场景及 G5/G6 公式和样本闸门测试。
- 通过 / 失败 / 无法判定: 6 / 0 / 0
- **结论**: PASS
- **部署含义**: 仅表示修订稿通过方法契约、数据映射和独立静态计算审查，可部署为**只读框架资产**供 F2 实装。不得据此宣称 G2 胜率、G3 入场率、G5 方向准确率或 G6 区间覆盖率已改善。
- **行为边界**: 本轮未修改 glass-researcher，研究员仍为 v4；F2 实装及任何规格修改仍须另走变体协议。

## 对比基线

| 指标 | 基线：`eval-glass-framework-v1-20261119.md` | 本次 r2 | Δ |
|---|---|---|---|
| 通过率 | 66.67%（4/6） | 100%（6/6） | +33.33 个百分点 |
| T3 | FAIL：派遣 oracle 案例④错误；独立值已为 0.80/1.375 | PASS：采用更正 oracle，独立值仍为 0.80/1.375 | FAIL→PASS；草案权重未变 |
| T4 | FAIL：供给未知可入 0；基差、截断、小样本规则待完善 | PASS：null、组件、区间、锁低及小样本注入均通过 | FAIL→PASS |
| T1/T2/T5/T6 | PASS | PASS | 无回归 |
| 耗时/成本（如适用） | 静态检查，未测运行时成本 | 静态复审，未测运行时成本 | N-A |

通过率的提升只表示本轮静态判据修复与验证通过，不是研究或交易结果指标提升。

## 异常与观察

1. **Git 返回码与换行警告已隔离**：`git diff --no-index` 在存在差异时返回 1，属于预期行为；同时输出 LF 未来可能转 CRLF 的提示。该命令只读，未触发换行转换，评估后哈希复核用于确认输入未变。
2. **区间端点边界建议固化为 F2 回归例（非核心缺陷）**：本轮将端点相接也保守视为重叠并记 null。建议 F2 固定该边界的预期，避免不同实现对“重叠”的解释漂移；本轮要求的交叉、重叠、一升一降=null均已通过。
3. **G6 跨日聚合属于 F3 实装细节（观察）**：N19/N20 冒烟使用算术均值仅为验证规定字段和样本闸门，不把其指定为唯一聚合口径。F3 应另行明确跨日区间覆盖率聚合方式及平坦实际区间的 N-A 计数规则。
4. **10 样本评审触发不等于结果宣称**：V:L343 的每 10 笔前瞻样本可触发评审，与 V:L320-L321 的不足 20 只作诊断并存；评审可用于发现问题，不可绕过小样本限制宣称结果性进化。
5. **只读完整性**：评估前已记录当前稿、失败快照、两份原料、agent、首轮报告和模板哈希。报告写盘后复核 7/7 全部一致，最终输出 `R2_READ_ONLY_INTEGRITY=PASS; 7/7 frozen inputs and baseline report unchanged`；本报告是唯一新写产物。

## Gaming 嫌疑

未发现。

修订直接回应首轮真实缺陷及观察项，没有修改权重迎合错误 oracle，没有引入放宽方向或置信度的旁路，反而增加 null 退出、组件覆盖要求、置信度锁低和小样本限制。所有通过结论均来自外部文件 diff、独立 Node 输出及哈希检查，未采用被测对象自评。

## 建议

1. **只读资产部署**：Genesis 可将本修订稿纳入只读框架资产供 F2 使用，但保留“静态 PASS≠结果改善”的说明；不得因本报告直接修改 glass-researcher 或交易行为。
2. **F2 固化本轮回归判例**：至少纳入五个 C/S 向量、供给未知、需求全单期、部分趋势降级、指定基差组合、区间重叠、单位拒绝、覆盖不足锁低和高/低截断，防止实装时漂移。
3. **F3 前瞻验收**：按 V:L320-L321 全量报告规定计数；不足 20 只作诊断，达到 20 后仍需以真实前瞻样本评价，不能用本静态报告代替结果验收。
4. **保持已修正算术基线**：后续回归继续使用案例④ `C=0.80、weighted=1.10、S=1.375、偏多`，不得恢复首轮错误 oracle，也不得为此调整 30/25/25/20 权重。
5. **实装变更重新审查**：若 F2/F3 需要改变评分、单位、区间比较、置信度或 G5/G6 聚合口径，应形成明确版本变更并重新评估，不做静默修改。
