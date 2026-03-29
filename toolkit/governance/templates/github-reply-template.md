# GitHub Reply Templates

克制的 GitHub 回复模板集合。用于在 OpenClaw 官方仓库参与讨论。

---

## Template A：澄清概念混淆

**适用场景**：
- memory / identity / bootstrap / injection 概念混淆

**参考回复（英文）**：
```
I noticed the discussion seems to mix [concept A] and [concept B]. 

To clarify:
- [Concept A] refers to [simple definition]
- [Concept B] refers to [simple definition]

They're related but distinct. Mixing them might lead to [specific consequence].

Does this match what you're observing?
```

**语气说明（中文）**：
先复述对方问题，再给一个更清楚的切分，不引入新体系，不用大词。

---

## Template B：解释"不稳定"的常见原因

**适用场景**：
- 对方问为什么 agent / runtime 不稳定

**参考回复（英文）**：
```
"Unstable" could mean a few different things here. Based on common patterns:

- Prompt drift: the instruction set evolves without version tracking
- Context overflow: too much history affecting current decisions  
- Task boundary leak: agent starts handling things outside its defined scope
- Injection issue: external input changing behavior unexpectedly

Which of these feels closest to what you're seeing? Or something else entirely?
```

**语气说明（中文）**：
指出可能是 prompt / injection / context / task boundary 问题，不做绝对判断，鼓励对方缩小问题范围。

---

## Template C：指出"这更像观察，不像结论"

**适用场景**：
- 对方把单案例、单体验说成普遍结构

**参考回复（英文）**：
```
This is an interesting observation from your specific case.

Just a gentle note: one case (or even a few) can reveal patterns to investigate, but building a general structure from limited samples risks [specific pitfall, e.g., overfitting to edge cases / missing counterexamples].

Have you seen this pattern hold across different [contexts / use cases / time periods]?
```

**语气说明（中文）**：
用非常温和的语气提醒，不否定对方，只强调样本不足、结论过早。

---

## Usage Rules

- 不出现 FAO
- 不出现 "our framework"
- 不出现项目链接
- 不做宣传
- 只解释局部问题
- 用现象语言，不用体系语言
- 不抢定义权
- 不进行多轮争论
