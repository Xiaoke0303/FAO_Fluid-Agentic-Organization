# Toolkit

> 旧分组索引 / 历史实现来源

toolkit/ 目录继续保留，主要作为旧分组、历史实现来源与迁移来源。当前理解仓库整体结构的首选入口应是 [framework/](../framework/)。

---

## 子目录

| 目录 | 说明 |
|------|------|
| [minimal-core/](minimal-core/) | 旧版稳定内核分组，承接方向、薄记忆、节律等主线 |
| [governance/](governance/) | 旧版治理实现分组，承接真实性、外部调用、失败暴露等 |

---

## 与 framework 的关系

- [framework/](../framework/) 是当前新的上位骨架候选
- toolkit/ 中的内容可作为新框架的来源、映射对象或历史实现参考
- 后续以 [framework/MIGRATION-PLAN.md](../framework/mapping/MIGRATION-PLAN.md) 为准逐步迁移

---

## 阅读建议

1. 先看 [framework/](../framework/) 理解新骨架
2. 再回看 toolkit/ 子目录，理解其作为历史分组和实现来源的意义
