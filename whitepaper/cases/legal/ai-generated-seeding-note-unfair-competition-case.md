# AI-Generated Seeding Note Unfair Competition Case

status: legal case candidate
not yet absorbed into whitepaper main text
source audit required before promotion
not proof of FAO
do not cite until source audit completed

---

## Case Overview

| Attribute | Detail |
|-----------|--------|
| **Court** | 浙江省杭州市中级人民法院 (Hangzhou Intermediate People's Court) |
| **Date** | 2026-05-12 disclosed as typical case; actual trial concluded earlier (see Source Audit) |
| **Case Type** | Unfair competition dispute (不正当竞争纠纷) |
| **Plaintiff** | Operator of a well-known social sharing platform (domestic) |
| **Defendant** | Two companies jointly operating an AI writing tool |
| **Core Dispute** | Whether定向提供 AI-generated "seeding notes" (种草笔记) to a specific platform constitutes unfair competition |
| **Remedy** | Stop infringement + compensate plaintiff for economic losses and reasonable expenses totaling RMB 100,000 |

---

## Source Audit

| # | Claim | Source URL / Path | Evidence Type | Truth-State | Confidence | Notes |
|---|-------|-------------------|---------------|-------------|------------|-------|
| 1 | 杭州中院披露该案 | https://news.cctv.com/2026/05/12/ARTI8WYlR9mPd6KyPj3GhncE260512.shtml (CCTV) | State media report | **verified** | high | CCTV, Xinhua, 光明网, 中新网, 澎湃新闻 all reported on 2026-05-12 |
| 2 | 全国首例涉及 AI 代写"种草笔记"不正当竞争案件 | https://app.xinhuanet.com/news/article.html?articleId=202605131adbdc7e185c46c5beab26f3fba98df3 (Xinhua) | State media report | **verified** | high | Multiple authoritative outlets uniformly describe as "全国首例" |
| 3 | 原告为知名社交平台经营者 | https://news.cctv.com/2026/05/12/ARTI8WYlR9mPd6KyPj3GhncE260512.shtml | State media report | **partially verified** | high | Reports refer to "某社交平台" without naming; consistent industry understanding points to Xiaohongshu (小红书) |
| 4 | 被告共同运营面向特定平台的 AI 写作工具 | https://news.cctv.com/2026/05/12/ARTI8WYlR9mPd6KyPj3GhncE260512.shtml | State media report | **verified** | high | Tool offered web, App, and WeChat mini-program versions |
| 5 | 功能模块直接嵌入平台名称（"种草文案"/"旅游攻略"/"笔记标题"） | https://www.ithome.com/0/949/198.htm (IT之家) | Tech media report | **verified** | high | Module names directly used platform-related naming; promotional language: "符合平台调性的分享文案" |
| 6 | 法院采用"四要素判定法" | https://www.thepaper.cn/newsDetail_forward_33161691 (澎湃新闻) | Media report quoting judge assistant | **verified** | high | Judge assistant Zhang Zongbin (张宗滨) introduced the four-element test in interview |
| 7 | 四要素内容（生成式 AI / 特定场景应用层 / 指向性与诱导性 / 营利性商业行为） | https://www.chinadaily.com.cn/a/202605/12/WS6a02c5cca310942cc49abd03.html (China Daily) | Media report | **verified** | high | (1) generative AI service; (2) specific platform as application layer; (3) clear directivity and inducement; (4) for-profit commercial conduct |
| 8 | 赔偿 10 万元 | https://news.cctv.com/2026/05/12/ARTI8WYlR9mPd6KyPj3GhncE260512.shtml | State media report | **verified** | high | "经济损失及合理开支共计10万元" |
| 9 | 技术中立抗辩未被完全接受 | https://news.cctv.com/2026/05/12/ARTI8WYlR9mPd6KyPj3GhncE260512.shtml | State media report | **verified** | high | Court: "技术本身是中立的，但技术的应用不是中立的" |
| 10 | 案件已生效/终审 | https://www.jcxx.wang/show-6-217542-0.html (决策信息网) | Media report | **partially verified** | medium | Reports describe as "终审判决" or "判决现已生效"; actual judgment document not directly retrieved from court database |
| 11 | 案件实际审结时间早于 2026-05 | https://www.caict.ac.cn/kxyj/qwfb/ztbg/202601/P020260107597270920028.pdf (CAICT 2026 report) | Official research institute report | **verified** | high | CAICT January 2026 report notes: "8月，浙江省杭州市中级人民法院就涉生成式人工智能服务不正当竞争纠纷案作出二审判决" — confirming trial concluded by August 2025 |
| 12 | 2026-05-12 为典型案例披露，非首次判决 | Multiple sources above | Synthesis | **inferred** | high | 2026-05-12 is "disclosure as typical case" date, not judgment date; aligns with CAICT report and coordinated media coverage |
| 13 | 收费模式：终身会员 168 元 / 年会员 98 元 / 月会员 40 元 | https://www.thepaper.cn/newsDetail_forward_33161691 | Media report quoting judge | **verified** | medium | Judge assistant disclosed pricing in interview; exact numbers may vary by source (some reports cite 199/98/40) |

**Source Audit Summary:**
- Core facts (court, case type, defendants' conduct, remedy amount, four-element test) are **verified** through multiple authoritative state media outlets (CCTV, Xinhua, 光明网, 中新网).
- The "nation's first" characterization is uniformly reported but not independently confirmed by judicial administration.
- Actual judgment date appears to be **August 2025** (per CAICT report); 2026-05-12 is the **public disclosure** date as a typical case, likely coordinated with the "Clear·Rectify AI Application Chaos" special campaign (清朗·整治AI应用乱象) launched by the Cyberspace Administration.
- Plaintiff identity (Xiaohongshu) is inferred from context but not explicitly named in official reports.

---

## FAO Mapping

| Court / Case Element | FAO Concept | Mapping Strength | Truth-State | Notes |
|----------------------|-------------|------------------|-------------|-------|
| **生成式 AI 服务** | Capability type recognition | **strong** | verified | Court first asks: is this a generative AI service? FAO's pre-flight layer similarly requires capability classification before routing |
| **特定平台应用场景** | Definition domain narrowing | **strong** | verified | Tool was not generic; it was scoped to a specific platform. FAO's "definition domain as governance membrane" directly maps: when the water is scoped to one platform, the platform's rules become part of the domain |
| **"种草文案"/"旅游攻略"/"笔记标题"功能模块** | Tool description as behavior boundary | **strong** | verified | Module names are not neutral labels; they are behavioral prescriptions. FAO: how a tool is described changes what actions it triggers |
| **"无需真实体验 / 一键生成"** | Inducement to false task-world construction | **strong** | verified | Tool explicitly induces users to construct a false experiential world. FAO truth-state principle: unverified cannot pose as verified |
| **会员收费 / 商业变现** | Cost-benefit asymmetry / externality | **strong** | verified | Tool operator profits; platform bears governance cost; consumers bear information-pollution cost. FAO cost-line: costs are misallocated across stakeholders |
| **平台治理成本增加** | Externalized governance cost | **medium** | partially verified | Court notes platform must increase operational costs to combat false content. FAO: when a node expands its domain without absorbing governance cost, cost is externalized |
| **技术中立抗辩未被完全接受** | Capability neutrality is insufficient once deployed in a harmful domain | **strong** | verified | Court: technology itself is neutral, but its application is not. FAO core principle: capability can be neutral; deployment in a domain activates responsibility |
| **真实体验 vs AI 编造体验** | Truth-state / source-of-experience boundary | **strong** | verified | Core of case: AI-generated "personal experience" without experience. FAO: the source of an experience claim must be traceable to an experiential subject |
| **四要素判定法** | Structured pre-flight / task admission check | **medium** | verified | Court's four-step test resembles FAO's PRE-FLIGHT logic: classify capability → scope domain → check inducement → verify commercial intent before triggering action |
| **真实内容生态作为竞争性权益受保护** | Ecosystem integrity as a governance asset | **medium** | partially verified | Court extends Anti-Unfair Competition Law to protect "authentic content ecosystem" built through long-term investment. FAO-adjacent: an organization's truth-state infrastructure is a competitive asset |

---

## Required Questions

### 1. Why is this case suitable as an FAO whitepaper legal case candidate?

Because it is the **first Chinese judicial case** to explicitly address:
- Generative AI tool provider responsibility (not just user responsibility)
- Domain-scoped AI deployment (not generic tool use)
- The distinction between "technology neutrality" and "application neutrality"
- Structured judicial test for AI service provider duty of care

It bridges the gap between abstract FAO governance principles (boundary-setting, truth-preserving, cost allocation) and concrete legal enforcement.

### 2. What is the most important insight for FAO?

> **When an AI tool is scoped to a specific domain (platform), the tool provider inherits a duty of care tied to that domain's rules — not because the tool is dangerous, but because it is "aimed."**

This directly supports FAO's "definition domain as governance membrane" concept: the narrower the domain, the more explicit the governance obligation.

### 3. Does it support "domain expansion must be accompanied by governance layer expansion"?

**Yes — but indirectly.**

The case does not discuss "domain expansion" in FAO terms. However, the court's reasoning implies: when a tool's capability is extended into a specific platform's content ecosystem (domain expansion), the provider must simultaneously extend its governance attention (duty of care) to that ecosystem. Failure to do so = unfair competition.

This is compatible with FAO's "when the water changes, responsibility must be re-anchored" principle.

### 4. Does it show that tool description, function modules, and product positioning themselves change liability boundaries?

**Yes — explicitly.**

The court's second and third elements focus precisely on:
- How the tool named its modules ("符合平台调性的分享文案")
- How it positioned itself (specific platform, not generic)
- How it described its value proposition ("一键生成" without real experience)

The court treats these as **evidence of inducement and intent**, not mere marketing language. This supports FAO's view that tool description is part of the "action trigger boundary."

### 5. What is the insight for cost-line?

Three-party cost misallocation:

| Stakeholder | Cost Incurred | Benefit Received | FAO Cost-Line Label |
|-------------|---------------|------------------|---------------------|
| Tool provider (defendant) | Minimal (API/infra) | Membership fees (168/98/40 RMB) | **Profit without governance absorption** |
| Platform (plaintiff) | Content moderation, ecosystem defense, trust repair | None from tool; harmed | **Externalized governance cost** |
| Consumer/users | Information pollution, decision error risk | None (deceived by false reviews) | **Information asymmetry cost** |

FAO cost-line implication: when AI capability is deployed in a narrow domain without the provider absorbing proportional governance cost, the cost is forced onto the platform and end-users. This is a **cost externality** requiring membrane-level correction.

### 6. Does it duplicate existing legal cases?

**No.**

Current `whitepaper/cases/legal/` contains:
- `ai-replacement-labor-arbitration-factcheck.md` — labor arbitration, AI replacing human workers
- `legal-ali-vs-li-2026.md` — individual rights case, personal vs. platform

This case fills a **different gap**: AI tool provider liability for generative content in a specific platform domain under unfair competition law. No overlap.

### 7. Should it be absorbed into whitepaper main text in the future?

**Default position: candidate only, no main-text absorption yet.**

Conditions for future absorption:
- [ ] Source audit completed with direct judgment document retrieval
- [ ] Plaintiff identity confirmed (Xiaohongshu or other)
- [ ] Whether court's "four-element test" becomes established judicial doctrine (follow-up cases)
- [ ] Whether this case is cited by subsequent AI governance cases
- [ ] FAO framework has formalized "definition domain" concept enough to receive case mapping

---

## Comparison with Anthropic Copyright Case

| Dimension | Anthropic Copyright Case | AI Seeding Note Case |
|-----------|--------------------------|----------------------|
| **Jurisdiction** | US (N.D. Cal.) | China (Hangzhou) |
| **Legal basis** | Copyright infringement / fair use | Anti-Unfair Competition Law |
| **Core issue** | Training data legality | AI-generated content authenticity |
| **Defendant type** | AI model developer | AI tool operator (application layer) |
| **Plaintiff type** | Individual authors / publishers | Platform operator |
| **Key legal innovation** | Fair use doctrine applied to AI training | "Four-element test" for AI service provider duty of care |
| **Settlement/Judgment** | $1.5B settlement | RMB 100,000 judgment |
| **FAO relevance** | Input boundary governance (training data) | Action trigger + truth-state governance (output authenticity) |
| **Governance layer** | 定界 / input boundary | 行事 + 守真 / action trigger + truth-preserving |

The two cases are **complementary**: Anthropic addresses what goes *into* AI; this case addresses what comes *out* of AI in a scoped domain.

---

## Truth-State Summary

| Item | Truth-State |
|------|-------------|
| Hangzhou court disclosed the case | **verified** |
| Nation's first AI seeding note unfair competition case | **verified** (uniform media characterization) |
| Plaintiff is Xiaohongshu (inferred) | **partially verified** |
| Defendants operated platform-scoped AI writing tool | **verified** |
| Four-element judicial test exists and was applied | **verified** |
| Remedy: stop + RMB 100,000 | **verified** |
| Technology neutrality defense rejected | **verified** |
| Judgment is final / effective | **partially verified** (reports say "终审"; actual judgment doc not directly retrieved) |
| 2026-05-12 is disclosure date, not judgment date | **inferred** (supported by CAICT Jan 2026 report) |
| Tool pricing: lifetime 168 / annual 98 / monthly 40 RMB | **partially verified** (judge disclosed in interview) |
| Case suitable as FAO whitepaper candidate | **inferred** (pending further source audit) |

---

## Open Questions for Future Source Audit

1. Can the actual judgment document be retrieved from China Judgments Online (中国裁判文书网) or Zhejiang court database?
2. What are the exact defendant company names (B company / C company)?
3. Was there a first-instance judgment before the second-instance ("终审") judgment in August 2025?
4. Has this case been cited in subsequent AI governance cases?
5. What is the relationship between this case and the Cyberspace Administration's "Clear·Rectify AI Application Chaos" campaign launched concurrently?

---

*Candidate file. Not yet absorbed into whitepaper. Source audit partially complete. Additional judicial document verification required before promotion to main text.*

*Generated: 2026-05-13*
