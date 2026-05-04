# Templates

> 节点接入模板，不是运行内核。

---

## 文件说明

| 文件 | 用途 |
|------|------|
| `identity-cloud-node.md` | 内网云节点的身份锚点模板 |
| `user.md` | 接口另一端角色模型占位（观察期，有意保留） |

---

## 迁移状态

`templates/` 作为**历史模板层（legacy templates）**保留，不再是当前角色或身份的正式入口：

- `identity-cloud-node.md` — 保留为 legacy template。角色边界已由 [`framework/role/ROLE-CONTRACT.md`](../../framework/role/ROLE-CONTRACT.md) 承接，真实性约束已由 [`framework/assurance/TRUTH-CONTRACT.md`](../../framework/assurance/TRUTH-CONTRACT.md) 承接。但 "Cloud Node / 组织节点" 身份定位尚无 framework 内一对一正式承接，**不应视为完整迁移**。
- `user.md` — 保留为 legacy template。与根目录 `USER.md` 定位不等价，不做正式迁移判断。

---

## 与内核的关系

- `toolkit/minimal-core/` — 运行内核（方向、记忆、节律）
- `toolkit/governance/` — 治理护栏（真实性约束、失败报告、最小自主排查）
- `templates/` — 接入模板（身份锚点、用户接口占位）

模板层不替代内核，只提供节点接入时的初始结构。
