# variants/ 草稿区

architect 的产出区 + genesis 部署前的备份区。

## 命名规范

| 类型 | 命名 | 示例 |
|---|---|---|
| 候选草稿 | `<id>.v<N>.md` | `code-reviewer.v1.md` |
| 部署前备份 | `<id>.v<N>.<YYYYMMDD-HHmm>.md` | `genesis.v1.20261117-1430.md` |

备份文件保留原文件**全部内容**，并可在文件头追加一行 HTML 注释记录备份原因：

```
<!-- backup: 迭代前备份，评估报告见 ../reports/eval-... -->
```

## 规则

1. 每个版本一份文件，不覆盖——parent 链靠文件名与 `registry.json` 的 `parent` 字段共同维护
2. evaluator 对本目录只读（防既当运动员又当裁判）
3. FAIL 的草稿保留在原地，供失败归因；不删除
4. 回滚 = 从本目录复制 parent 版本到 `.opencode/agents/`，并在 registry 追加 rollback 记录
