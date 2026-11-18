# 评估报告：glass-researcher v4

- **日期**: 2026-11-18
- **评估者**: genesis-evaluator
- **被测文件**: `D:\SFI\genesis\variants\glass-researcher.v4.md`（O5 MCP resource 读取权限修复变体草稿，静态规格审计，259 行）
- **基线**: `eval-glass-researcher-v3-20261117.md`（v3 静态审计 3/3 PASS；对照文本 `genesis/variants/glass-researcher.v3.md` 当前文件，252 行）
- **判据来源**: 派遣方声明的 6 处变更清单 + E1–E4 判据；结论只依据 node 命令输出与文件检查

## 任务结果

| 任务 | 结果 (PASS/FAIL/N-A) | 证据摘要 |
|---|---|---|
| E1 变更范围精确性 | PASS | node LCS 逐行 diff（`e1_diff.js` → `e1_out.txt`）：`v3 行数=252, v4 行数=259, Δ=+7`；两文件均无 BOM、全 LF、以换行结尾。`hunk 数: 8`；v3 删除行集合 = {4,5,6,8,9,10,11,12,46,74}（design/expected/risk 改写 + T1–T4 及「另：」行 + 导语 + 2.1 自述），v4 新增行集合 = {4,5,6,8,9,41–50,53,81}；**`声明外差异行: v3=0, v4=0`、`E1 判定(差异行全部落在声明位置): true`**。多重集口径：仅 v3 行值 10 种（Σ=10 行）、仅 v4 行值 16 种（Σ=17 行）；唯一同值行 `effect: allow` 净增 2 处，LCS 定位其新增出现恰在 v4 L47/L50（新增规则内），其余 6 处与 v3 逐字匹配（初版脚本曾将同值行全部出现位置误分类为 UNDECLARED，已修正为按 LCS 增删行分类，见异常 6）。定点核对：`risk: v3 L6 是 v4 L6 的精确前缀: true`、`risk 后缀以「；⑪」开头: true`、`risk ⑪ 计数: v3=0, v4=1`、`①–⑩ 各计数 v3==v4: true`；`导语: v3 L46 replace('v3','v4') == v4 L53: true`（'v3' 出现恰 1 次）、`2.1: v3 L74 replace('v3','v4') == v4 L81: true`；`eval-tasks: v4 含 T5 行: true; v3 T1–T4 行均不在 v4: true; v4 含「回归沿用」行: true`；`permissions 新增区 v4 L41–L50: 共 10 行 = 4 注释 + 6 规则行`，新增 2 规则文本与声明逐字一致：`opencode_list_mcp_resources / resource: "crude-data" / effect: allow`、`opencode_read_mcp_resource / resource: "crude-data:*" / effect: allow`（两条均 true）。v4 全文 'v4' 字样仅出现在声明变更行 {L4, L6, L8, L41, L53, L81}。 |
| E2 L0/参数/流程逐字保留 | PASS（12/12） | node 归一化子串检查（`e2_substring.js` → `e2_out.txt`，忽略行尾空白）：`① 三、结算规则 全节（16 行）YES`；`② 五、策略参数基线 全节（13 行）YES`；`③ 六、硬边界 全节（8 行）YES`；`④ v3 permissions 块（25 行, L19–L43）YES` 且 `④b v3 块 == v4 块前 25 行（前缀、顺序不变）: true; v4 块追加行数: 10`、`④c 规则数: v3=7, v4=9; v4 前 7 条规则与 v3 逐条全等且顺序不变: true`；`⑤ 2.2+2.3+2.4 流程全节（A0–A4/B0–B9）（33 行）YES`（分项 ⑤a 2.2 9 行 / ⑤b 2.3 14 行 / ⑤c 2.4 8 行均 YES）；`⑥ 日报六节模板节（32 行）YES`；`⑦ 15 列台账表头: v4 中精确出现 1 次（v3 1 次）；列数=15; 子串=true`；`⑧ performance.json schema 与字段口径节（28 行）YES`。参数数字计数：`0.25×ATR5: 3=3`、`0.4–0.6×ATR5: 1=1`、`1.0–1.5×ATR5: 1=1`、`【L0 冻结】: 4=4`、`L0: 10=10`、六节模板节标题 1=1，全部相等。 |
| E3 无夹带、无移除 | PASS（附任务书算术误差披露） | node 规则枚举与正文比对（`e3_smuggle.js` → `e3_out.txt`）：v3 规则 7 条（`* @ * deny` → edit/read/glob @ `glass/**` → websearch/webfetch @ `*` → `crude-data_* @ * allow`），v4 规则 9 条，`净增 = v4 - v3 = 2`；`v4 前 7 条规则与 v3 逐条全等（action/resource/effect/顺序）: true`；`v3 中被移除/被改的规则数: 0`；`新增规则中 deny 数: 0`；`新增规则 == 声明的 2 条（opencode_list_mcp_resources @ "crude-data" / opencode_read_mcp_resource @ "crude-data:*", 均 allow）: true`；`第 1 条宽 deny（* @ *）仍为 v4 第 1 条且未变: true`。系统提示正文：`v3 正文行数=209, v4 正文行数=209`，多重集差异恰 2 行（导语与 2.1 两处 v3/v4 自述），`正文逐行对齐（允许两处 v3→v4 单词替换）: true`；frontmatter 头部 description/mode/steps 逐行相等、`mode: subagent`、`steps: 60` 未动。**计数判据披露**：派遣方任务书写「v4 permissions 规则数 = v3 的 8 条 + 2 条新 allow = 10 条」，命令实测 `v3 总数=7 (deny=1, allow=6)`、`v4 总数=9 (deny=1, allow=8)`——v3=7 与基线报告 eval-glass-researcher-v3-20261117.md 记载的「规则总数=7（期望 7 = v2 的 6 + 声明的 1）」一致，任务书前提「v3 的 8 条」系算术误差；实质判据（E3 标题「无夹带、无移除」：v4 = v3 + 恰好声明的 2 条 allow，无 deny 收紧、无能力移除）经命令验证成立。 |
| E4 RSI 零残留 | PASS | node 计数与逐行定位（`e4_rsi.js` → `e4_out.txt`）：`v4 「RSI」(大小写敏感) 出现次数: 0（判据 = 0）`；`v4 任意大小写 rsi 出现次数: 0`；`v4「相对强弱」出现次数: 0（RSI 中文名残留）`；`v4 中含 'RSI' 的行号: （无）`；对照 `v3 「RSI」出现次数: 0`。用户中途撤销的 RSI 变更在 v4 全文零残留。注：当前 PowerShell 环境无 `grep`（CommandNotFoundException），以 node 计数 + 全行扫描替代，判据等价。 |

## 汇总

- 样本数: 4（E1–E4，均为静态规格审计任务）
- 通过 / 失败 / 无法判定: 4 / 0 / 0
- **结论**: **PASS**

裁决理由：E1 行级 LCS diff 的全部增删行（v3 删 10 行、v4 增 17 行）恰好落在声明的四类位置——元信息块改写（v3 L4–L12 → v4 L4–L9，含 risk ①–⑩ 逐字前缀 +「；⑪」纯追加、T5 新增与 T1–T4 详情行代之以「回归沿用」引用行）、permissions 末尾新增 10 行（4 注释 + 2 条 allow 规则共 6 规则行，规则文本与声明逐字一致）、导语 L53 与 2.1 L81 两处 v3→v4 精确单词替换——声明外差异行为 0。E2 十二项受保护段落/块（三/五/六全节、v3 permissions 块为 v4 块前缀且前 7 条规则逐条全等、2.2/2.3/2.4 全流程、日报六节模板、15 列表头、performance.json schema 与口径）归一化后全部为 v4 精确子串，参数数字与【L0 冻结】标记零漂移。E3 证明权限净增恰为声明的 2 条 allow（7→9 条，无移除、无 deny 收紧、宽 deny 首位未动），系统提示正文除两处版本自述外逐行一致；任务书「8+2=10」的前提数字与其自身基线报告矛盾（实测 v3=7），按 E3 的实质判据（v4=v3+恰好 2 条声明 allow）判 PASS 并单列披露。E4 RSI 大小写敏感/不敏感/中文名残留计数均为 0。无安全红线触碰。

## 对比基线

| 指标 | 基线 (v3 轮) | 本次 (v4 轮) | Δ |
|---|---|---|---|
| 通过率 | 3/3（E1–E3 静态审计） | 4/4（E1–E4 静态审计） | 0（判据集不同，均满通过） |
| permissions 规则数 | 7（1 deny + 6 allow） | 9（1 deny + 8 allow） | +2（恰为声明的 2 条 resource 读取 allow） |
| 【L0 冻结】标记数 | 4 | 4 | 0 |
| 五节参数数字序列 | 一致（0.25/0.4–0.6/1.0–1.5/5%） | 一致（逐项计数相等） | 0 |
| 三/五/六/流程/模板/表头/JSON 逐字保留 | 11/11 精确子串（对 v2） | 12/12 精确子串（对 v3） | 0（无漂移） |
| 声明—diff 偏差 | 1 字符顿号（行内、已披露） | 0 | 收敛 |
| 正文自述版本 | v2（v3 轮报告观察 2，建议修复；当前 v3 文件已为 v3，见异常 5） | v4（列为声明变更 3/4） | 版本差异汇报噪音消除 |
| MCP resource 读取权限 | 无（宽 deny 误伤，O5 根因） | 2 条 allow（格式经官方文档独立核验，见异常 3） | O5 修复落地 |
| 行数 / 字节 | 252 行 / 26851 B | 259 行 / 26577 B | +7 行（元信息块 8 删 5 增 = -3；permissions 纯追加 +10；两处自述各 1↔1 行改写） |

注：本轮为规格草稿静态裁决（diff 审计），非运行时行为评估；MCP 有效调用率（O2 基线 44%）与 T5 判据属运行时指标，无可比数据。

## 异常与观察

1. **任务书 E3 计数算术误差（本轮唯一判据级偏差，属派遣方缺陷而非草稿缺陷）**：判据写「v3 的 8 条 + 2 条新 allow = 10 条」，命令实测 v3=7、v4=9；v3=7 有双重独立证据（本轮命令枚举 + 基线报告记载）。任何「恰好新增 2 条规则」的正确草稿在真实 v3 上都不可能达到 10 条——若按字面「=10」判 FAIL 将误归因于草稿。本轮按 E3 的实质意图（无夹带、无移除：v4 = v3 + 恰好声明的 2 条）判 PASS，误差如实披露。建议派遣方修订判据原文，闭合「声明—判据—命令」审计环（同 v3 轮对顿号偏差的处理惯例）。
2. **eval-tasks T1–T4 详情行被移除，代之以引用行**：v3 的 T1–T4 五行完整判据在 v4 中不出现（`v3 T1–T4 行均不在 v4: true`），代之以「回归沿用：…（详见 v3 草稿 eval-tasks）」+ 新 T5。此变更落在声明 1（「eval-tasks 改写为 v4 描述」）与声明 5（「新增 T5」）的合并范围内，语义以引用保留、属 genesis 元数据区而非行为契约，不构成 FAIL；但 v4 草稿自此不再自含回归任务判据，**依赖 v3 草稿文件持续在原位**——若基线文件归档/移动，引用断裂。另 T5 判据②（MCP 有效调用率 ≥80%）为运行时门槛，静态审计无法裁决，须部署后执行（见建议 2）。
3. **权限格式独立核验（超出 E1–E4 的尽职调查，证据为官方文档）**：抓取 OpenCode V2 官方权限文档（https://opencode.ai/docs/permissions/），其 Actions 表明确列有 `opencode_list_mcp_resources`（resource = MCP server name）与 `opencode_read_mcp_resource`（resource = `<server>:<uri>`）——与 v4 两条规则的 action 名与 resource 形态逐字吻合。这同时证实：O5 报告原先设想的 `read @ "resource://eta/indicators"` 并非合法 V2 格式（`read` 的 resource 是文件路径），v4 design 声称的「与 O5 报告原先设想的格式不同，以文档为准」属实且方向正确。两条 allow 位于 permissions 列表末尾（宽 deny 之后），符合 OpenCode「按顺序合并、最后匹配优先」的语义，实际可生效；注释行沿用 v3 既有风格，运行时解析安全性继承自已部署的 v3。
4. **resource 实测（本会话 Code Mode，只读）**：`list_mcp_resources({server:"crude-data"})` 返回该服务器唯一 resource = `resource://eta/indicators/chemical`（「ETA 指标 — 化工品」，3731 条 name→edb_code 映射，内容实测含 `edb_code`、WTI、原油条目，134666 字符）——与草稿注释/design 的示例 `resource://eta/indicators` 略有出入（实际 URI 带 `/chemical` 后缀）。因规则为通配 `crude-data:*`（`*` 含 `/`），实际 resource 仍被覆盖，修复有效；v3 运行时失败的根因（索引不可读→盲猜 edb_code→5/9 报 500）与该索引的存在性互相印证。若按 risk ⑪ 建议收窄为 `crude-data:resource://eta/*`，仍覆盖 `/chemical`，收窄路径可行。
5. **v3 基线文件漂移线索**：v3 轮报告观察 2 记录「v3 L46/L74 自述为 v2」，而当前 v3 文件该两行为 v3——若系该报告建议 2 被就地应用于 v3 草稿，则 v3 文件与其评估报告所审计的版本存在事后漂移。本轮基线以当前 v3 文件为准（v4 对它的两处自述仍为纯单词替换），审计不受影响；但「报告—文件」审计链的完整性应引起 genesis 注意（见建议 5）。
6. **评估脚本自身缺陷已修正并复核（透明披露，沿 v2/v3 轮惯例）**：① 初版 `e1_diff.js` 把同值行（`effect: allow`）的全部 8 个出现位置拿去分类，产生 1 处假阳性 UNDECLARED——多重集行值无法区分同值行，LCS 对齐显示 2 个多余出现恰在新增区 L47/L50，其余 6 处与 v3 匹配；修正为按 LCS 增删行分类后 `声明外差异行: v3=0, v4=0`。② 初版 `e3_smuggle.js` 规则比较含行号字段（v3L21 vs v4L18），产生「前 7 条不全等」假阴性；③ 其 frontmatter 头部切片误含 HTML 注释块，产生「头部不等」假阴性——②③修正后复核均 true。④ 环境注：当前 PowerShell 无 `grep`（E4 判据命令以 node 等价替代）；PowerShell `>` 重定向输出 UTF-16 导致证据文件不可读，改用 `Out-File -Encoding utf8` 归档。初版 E1 的 risk 前缀/自述替换/规则文本核对均为真值，无假阴性。
7. **运行时未覆盖**：本轮为静态规格审计。v4 声明的预期收益（MCP 有效调用率 44%→≥80%、日报 edb_code 与索引闭环、权限放行无拒绝）与 T5 全部判据需部署后以会话日志与日报产物裁决；硬边界 #1 与 MCP 来源标注的字面张力（v3 轮观察 4、O3 待立项）在 v4 依 L0 冻结未动，正确地留待显式声明流程。

## Gaming 嫌疑

未发现。6 处声明与实际 diff 逐项对得上：无「声明保留实则改写」（E2 12/12 精确子串）；净增权限恰为声明的 2 条 allow，且 action 名经官方文档独立核验为真实生效格式（非为通过检查而摆设的规则）；risk ⑪ **主动披露**了 `crude-data:*` 宽于最小可行面并预留收窄路径（未淡化权限范围）；用户中途撤销的 RSI 变更零残留（E4，含中文名与大小写变体）；T1–T4 详情行的移除发生在 genesis 元数据区且以引用保留语义，非「为通过检查而无实际价值」的产出。

## 建议

1. **修订本轮判据原文的算术误差**（对派遣方，零成本）：E3「v3 的 8 条 + 2 = 10 条」改为「v3 的 7 条 + 2 = 9 条」，保持判据与命令输出可逐项核对。
2. **T5 运行时裁决排期（部署后首个研判日）**：判据① 权限放行（list/read 全程无权限拒绝）；判据② 索引→调用闭环（日报「数据快照」板块联动所用 edb_code 逐条与 `resource://eta/indicators/chemical` 索引核对，MCP 有效调用率对 O2 基线 44%（4/9）的提升，门槛 ≥80%）；回归项按「回归沿用」行执行 v2 的 T1–T4 与 v1 的诚信注入/反 gaming 用例。
3. **将 T1–T5 判据固化进 `genesis/eval/tasks/`**：v4 草稿的 eval-tasks 已不自含 T1–T4 详情（详见异常 2），正式评估任务应脱离草稿文件独立存放，避免基线归档后引用断裂。
4. **权限收窄决策（可选，genesis 定夺）**：若要最小权限面，把 `opencode_read_mcp_resource` 的 resource 从 `crude-data:*` 收窄为 `crude-data:resource://eta/*`（经文档与实测 resource URI 核验仍覆盖 `/chemical`；一条规则一处修正，不动结构）——risk ⑪ 已预留该路径。当前 crude-data 服务器仅暴露 1 个只读 resource，`crude-data:*` 的实际暴露面与收窄后等价，不紧迫。
5. **基线文件变更留痕**：对已评估草稿的就地修改（如 v3 自述 v2→v3，见异常 5）应版本化或在报告中追加勘误注记，否则「评估报告—草稿文件」审计链会随时间断裂。
6. **O3 立项评估（下一轮声明的正式变更）**：硬边界 #1 合法来源枚举扩展（「当次 websearch/webfetch **或 crude-data MCP 工具/resource 结果**并注明来源」）与日报模板来源标注措辞同步扩展——L0 冻结条款必须走 genesis 显式声明流程，本轮草稿无权也不应自行改动（E2③ 的逐字保留判据正是防线）。

---

附：命令清单（全部证据来自以下命令输出，脚本与输出存于 `C:\Users\kmagic\AppData\Local\Temp\opencode\eval_glass_v4\`）：

- `node e1_diff.js` → `e1_out.txt`（文件级统计 + multiset diff + LCS 行级 diff 8 hunk + 声明位置分类 + risk 前缀/自述替换/T5/规则文本定点核对；修正版按 LCS 增删行分类）
- `node e2_substring.js` → `e2_out.txt`（受保护段落 12 项归一化子串检查 + permissions 前缀/规则逐条全等 + 参数数字计数）
- `node e3_smuggle.js` → `e3_out.txt`（permissions 规则枚举 v3 7 条/v4 9 条、净增 2 条核对、无移除/无收紧、正文多重集+逐行对齐、frontmatter 头部比对；修正版去除行号字段与注释块误含）
- `node e4_rsi.js` → `e4_out.txt`（RSI 大小写敏感/不敏感/中文名计数 + 含 RSI 行号定位 + v3 对照）
- `webfetch https://opencode.ai/docs/permissions/`（OpenCode V2 官方 Actions 表：`opencode_list_mcp_resources` resource=MCP 服务器名、`opencode_read_mcp_resource` resource=`<server>:<uri>`；最后匹配优先语义）
- Code Mode（只读）：`tools.opencode.list_mcp_resources({server:"crude-data"})` → 唯一 resource `resource://eta/indicators/chemical`；`tools.opencode.read_mcp_resource({...uri})` → 3731 条 name→edb_code 映射（134666 字符，含 WTI/原油）
