---
title: "When Does Memory Become Mass?(记忆何时变成质量?)带 memory 的系统里的 inertia 与 feedback — 中英混搭版"
date: 2026-07-02
author: "Macheng Shen"
description: "一个把累积的过去带进现在的系统,可以用一个 memory kernel 建模。对这个 kernel 到底**是什么**,有两种直觉在争:控制论的 feedback,还是牛顿的 inertia。一段短推导显示,它们是同一个对象的两个不同 projection——而且一个纯 dissipative(viscous)的 memory,靠自己**永远**造不出稳定的 inertia。这一版是中英混搭,按我自己的阅读习惯写的:贴切的英文术语保留,中文更顺的用中文,必要时英文后加(中文)。"
section_label: essay
---

{{< langswitch current="zh" en="memory-inertia-feedback.md" zh="memory-inertia-feedback-zh.md" >}}

*Macheng Shen*

*Epistemic status(认识论状态):一段 self-contained 的推导,外加一个下午做完的可复现小 toy。核心的 linear-response 结果(Section 3–4)我有把握——一旦你看清那个 sign,它就是教科书里的 Mori–Zwanzig。framing 类的断言(Section 1、6)是 `design_hypothesis`:拿出来是为了招 critique,不是当成已定论断言。按本站惯例声明:这段推导与这篇 write-up 由我的 agent 系统产出、再由我核过。欢迎纠错。*

*Corrections(2026-07-02,一次详尽的外部技术审查之后):核心结果站得住——代数、符号、pole 条件都对,而"monotone forgetting 不是 inertia;inertial memory 必须 store and return(存了再还)"这句活了下来。下面有三处被修正:(1) wrong-sign 的 mass 并不是物理上的 "runaway"——只有一个 truncated approximation 才不稳定;(2) Channel B 里一个负的 `γ_eff` 并**不**意味着 exact system 不稳定——在 `k, B, gA > 0` 下它永远稳定,只是那个 low-frequency expansion 越出了它的适用范围;(3) "passive" 说得太宽,而 Higgs analogy 说得太强。修正后的断言在文中就地标出。*

---

## 1. The question(那个问题)

很多系统把自己的过去带进现在。一个 habit,是靠重复学来的、行动门槛被压低的一个 low bar。磁体里的 hysteresis,是材料在"记住"它施加过的场的历史。用观修的语言说,*karma*(业力)——剥掉它的道德外衣——不过是这么一句主张:累积的、重复的行动,会往一个系统**现在**的响应方式里沉一份 bias。每一种情况里,"过去作用于现在"最诚实的 first-principles 归宿都是一个 **memory kernel**:现在的 drift 不只依赖瞬时状态,而是依赖对状态历史的一个加权积分,

```
        t
drift ~ ∫  K(t − t') ( · )(t') dt'
        0
```

当人们非正式地推理这类系统时,会冒出两种不同的力学隐喻,而它们通常被当成可互换的:

- **Feedback**(控制论式):过去设一个 loop gain——positive feedback 放大,negative feedback 阻尼。相关的量是 damping 的符号,以及那个 effective restoring force 的曲率。
- **Inertia**(牛顿式):过去给系统 *mass*——一种对改变自身速度的抵抗,一个 `M · ẍ` 项。变化现在成了二阶;系统能 overshoot、能振荡。

这两幅图并不明显是一回事。Feedback 活在一个 **first-order**(一阶)世界里(rates、gains、damping)。Inertia 本质上是 **second-order**(二阶)的(acceleration、momentum、resonance)。于是问题是:**一个 overdamped、first-order 系统里的 memory kernel,能真的长出一个货真价实的 second-order inertia 吗——还是它永远只是在 renormalize feedback?** 而如果它能长出 inertia,是在什么条件下?

有一条约束从一开始就值得尊重。在现代物理里,mass 不是一种 primitive 物质;它是耦合到一个 background field 的一种 *emergent effect*(Higgs mechanism 就是最锋利的例子)。所以诚实的目标不是去 postulate inertia——而是找到 inertia **从**耦合到某物中**涌现**出来,并精确看清那个涌现在什么时候成功、什么时候失败。

## 2. Setup(设置)

主力方程是 generalized Langevin equation(GLE)。对一个坐标 `x`,带一个 restoring force `−U'(x)`、一个 memory friction kernel `K`、以及噪声 `ξ`:

```
m ẍ(t) = − ∫₀ᵗ K(t−t') ẋ(t') dt' − U'(x) + ξ(t)
```

我们关心的是 **overdamped**(过阻尼)regime——取 bare mass `m → 0`,于是**没有**任何 inertia 是人手放进去的。问题是这个 kernel `K` 能不能把它放回来。把 restoring force 线性化,`U'(x) = k·x`,并到频域里工作,`ẋ → −iω x`,配上 one-sided kernel transform

```
K̂(ω) = ∫₀^∞ K(s) e^{iωs} ds .
```

linear response `x(ω) = χ(ω) ξ(ω)` 的逆是

```
χ⁻¹(ω) = k − iω K̂(ω) .
```

作为对照,一个 *genuine*(货真价实)的 inertial system 有 `χ⁻¹(ω) = k − m ω² − iγ ω`。所以整个问题归结为一件事:**`−iω K̂(ω)` 里含不含一个带 `m > 0` 的 `−m ω²` 项?** 符号就是一切。

## 3. Channel A — 一个 viscous(dissipative)memory kernel 给出*错误的符号*

取最简单的物理 memory friction:一个指数衰减、处处为正的 kernel,

```
K(s) = (γ / τ) e^{−s/τ},   γ, τ > 0 .
```

这是"带记忆的黏泥(sticky mud with a memory)"——一种正比于近期时间平均速度的 viscous drag。把它的 transform 在低频展开:

```
K̂(ω) = ∫₀^∞ K(s)(1 + iωs − …) ds = γ₀ + iω γ₁ + O(ω²),
   with  γ₀ = ∫K = γ,   γ₁ = ∫ s K(s) ds = γτ > 0 .
```

对*任意*正 kernel,`γ₁ = ∫ s K(s) ds > 0`——它是一个正权重乘一段正时间。现在组出 response:

```
χ⁻¹(ω) = k − iω K̂(ω) = k − iω(γ₀ + iω γ₁ + …) = k + γ₁ ω² − i γ₀ ω + …
```

逐项与 inertial form `k − m ω² − iγ ω` 比对:

```
γ (damping)     = γ₀ = ∫K            ✓  (ordinary friction, fine)
m (inertia)     = − γ₁ = − ∫ s K < 0  ✗  (WRONG SIGN)
```

**一个 pointwise-positive(逐点为正、会遗忘)的 memory friction kernel,产生一个低频 effective mass,符号是错的,`m_eff < 0`。** 光靠 non-negativity 就够了——kernel 甚至不必是单调的。事后看物理上很显然:一个 friction kernel 永远只是*移除*能量(带一点延迟);它永远无法*储存并归还* inertia 所要求的那份 kinetic energy。你没法用 drag 造出 momentum。

对这篇 essay 早先版本的说法,两点修正。**第一,wrong-sign 的 mass 不是一个物理上的 "runaway"。** 这里这个 exact 的 first-order-with-memory 系统有稳定(实)poles;那个 instability 只有当你把 low-frequency expansion 截断成一个假的 second-order ODE 时才出现,而那会制造出一个 spurious 的高频 pole。所以诚实的说法是:一个 positive 的 forgetting kernel 给出一个符号对 inertia 而言错误的 `ω²` 系数——*没有稳定的 positive-mass 解读*——而不是一个 instability。**第二,被禁的那一类是 "pointwise-positive forgetting",不是 "passive"。** Passivity 是一个频域条件(一个 positive-real 的 response,`Re K̂(ω) ≥ 0`),而一个 passive kernel *允许*在时域里探到负值。一个带负 tail lobe 的 passive kernel **能**产生 positive inertia——见下一段。做不到的,是一个对所有时间都保持 non-negative 的 kernel。

要用这条路得到*正*的 inertia,你需要 `∫ s K(s) ds < 0`,即 kernel 必须在某处走**负**——它必须 overshoot。一个带 negative lobe 的 kernel,恰恰是底下藏着一个 underdamped、*reactive*(反应式)自由度的签名,而不是一个单调 dissipative 的。这就把我们带到另一条 channel。

## 4. Channel B — 消去一个 reactive mode,inertia 涌现(à la Higgs)

不要在 velocity 上放一个 friction kernel,而是让 memory 来自一个货真价实的第二变量 `z`,它携带自己的 state——某种能 store and return 的东西。两个耦合的一阶方程:

```
ẋ = − k x + g z + ξ
ż = − A x − B z          (z relaxes at rate B)
```

把 `z` 积掉。它的解是 `x` 历史的一个 convolution——那*就是* memory kernel——回代进去给出

```
χ⁻¹(ω) = (k − iω) + gA / (B − iω) .
```

在低频展开(`gA/(B−iω) = gA/B · [1 + iω/B + (iω/B)² + …]`),读出三个 effective 系数:

```
k_eff     = k + gA/B          renormalized stiffness   — this is FEEDBACK on the restoring force
γ_eff     = 1 − gA/B²         renormalized damping     — can go NEGATIVE ⇒ positive-feedback runaway
m_eff     = gA/B³   > 0       EMERGENT INERTIA
```

现在*确实*有一个正的 effective mass 了。而且注意它的形式:`m_eff = gA / B³`——一个 coupling(`gA`)除以 background mode 的 stiffness/rate 的一个幂(`B`)。它不是一种物质;它是耦合到一个 background variable 的一个 induced 效应,并且在 `B → ∞`(固定 coupling 下)时**消失**。这只是*在弱的、effective-field-theory 意义上*才 Higgs-like:一个 inertial 系数被**耦合到一个被消去的 background 自由度所诱导,并在固定耦合的 adiabatic decoupling 下消失**。别往里读多了——这里没有 gauge symmetry、没有 symmetry breaking、没有 vacuum expectation value;`B` 是一个 relaxation rate,不是一个 field stiffness 或一个相对论 invariant mass;而且如果 `gA` 与 `B` 一起被 scale,连那个干净的 decoupling story 都会破。

但"有一个 `ω²` 项"不等于"有一个物理 resonance"。两个耦合的一阶 ODE *永远*给出一个形式上二阶的特征多项式。系统到底是一个货真价实的 underdamped oscillator(complex poles、real momentum),还是只是一对被伪装的 overdamped relaxations(real poles、no momentum),取决于参数。那些 poles 是 `[[−k, g], [−A, −B]]` 的 eigenvalues;它们是 complex——货真价实的 oscillation——当且仅当

```
(k + B)² < 4(k B + g A).
```

一个小的 toy sweep(固定 `k = 1`、`gA = 4`,变 background rate `B`):

| `B` | poles | regime | `m_eff` | `γ_eff` |
|----:|:-----:|:------:|-------:|-------:|
| 0.5 | −0.75 ± 1.98i | stable oscillator; `γ_eff<0` = reduced model out of range | 32 | −15 |
| 1.0 | −1.0 ± 2.0i | stable oscillator; `γ_eff<0` = reduced model out of range | 4.0 | −3.0 |
| 2.0 | −1.5 ± 1.94i | stable oscillator (`γ_eff=0`) | 0.5 | 0.0 |
| **4.0** | **−2.5 ± 1.32i** | **inertial, stable ✓** | **0.0625** | **0.75** |
| 8.0 | −1.63 (real) | feedback only | 0.008 | 0.94 |
| 20 | −1.21 (real) | feedback only | 5e-4 | 0.99 |
| 100 | −1.04 (real) | feedback only | 5e-6 | ~1.0 |

有两点要读出来。第一,complex poles——真 inertia——只在 background mode **slow 或与系统 comparable(相当)**时出现;在 **adiabatic(fast-bath)极限 `B → ∞`,`m_eff → 0`**,你只剩下纯 renormalized feedback。第二——而这一点修正了本 essay 的一个早先版本——一个负的 `γ_eff` 并**不**意味着系统不稳定。在 `k, B, gA > 0` 下,完整的 two-mode 系统*永远*线性稳定(`tr M = −(k+B) < 0`,`det M = kB + gA > 0`);那一行 `k=1, gA=4, B=1` 给出 `λ = −1 ± 2i`,一个完全稳定的 underdamped oscillator。一个负的 `γ_eff` 只表明那个 **truncated low-frequency expansion 越出了它的适用范围**——你不能再用它的 damping 系数去预测真实的 pole 位置。那个 reduced description 不再是一个可靠的 pole model;exact system 好得很。

## 5. The two axes(两根轴)

把两条 channel 拼起来,inertia 和 feedback 确实是同一个对象——memory kernel `K̂(ω)`——的**两个 projection**。Feedback 活在它的 real(dissipative)部分,加上 stiffness 的低频 renormalization;inertia 活在它的 **reactive** 部分,即一个能 store and return 的 mode 所贡献的那一块。但它们被两根轴分开,并**不**自由可换:

1. **Channel(通道)。** Reactive/state memory(能 store *且* return 能量)→ inertia。Dissipative/friction memory(只能移除)→ feedback,而它 naive 的 `ω²` 项符号是错的。
2. **Timescale(时间尺度)。** Memory 与系统自身 dynamics comparable → inertia。Adiabatic、fast-relaxing 的 memory → feedback(那个 induced mass 消失)。

对这套"two projections"说法有两条诚实的 caveat,都欠一次仔细的外部审查:

- **reactive 与 dissipative 部分并不自由可分。** Causality 把它们绑在一起——Kramers–Kronig relations 让任何 causal response 的实部与虚部彼此决定(在频率上是 nonlocal 的)。而且这个 split 是 *representation-dependent*(依赖表示)的:在 Mori–Zwanzig framework 里,memory kernel、noise、projection 是一个 package,不是一个唯一的客观对象。所以"inertia = reactive part,feedback = dissipative part"是*在一个固定的 scalar velocity-kernel 表示内*成立,不是一条 frame-free 的定律。

- **两条 channel 其实是一个 criterion。** 把被消去的 mode `z` 用分部积分积掉,会把 Channel B 变成一个 velocity-memory kernel `K_B(s) = δ(s) − (gA/B) e^{−Bs}`——它有一个 **negative lobe**,所以 `∫ s K_B ds = −gA/B³ < 0`,给出 `m_eff = gA/B³ > 0`。于是 Channel A 和 B 坍缩成一个单一测试:**那个 causal velocity kernel 的 first moment 是负的吗?** Monotone forgetting(A)永远不是;一个 hidden reactive mode(B)是。这就是整个结果,一行话。(一条边界:这假设了 finite moments。对 power-law / fractional memory,`∫ s K` 发散,没有一个 ordinary 的 `m_eff`——你得到的是 fractional damping 与 storage,不是一个干净的 second-order mass。)

## 6. 这对 "karma"、habit、以及 history-dependent 系统意味着什么

回到那幅起初的图。假设你想把一份 accumulated-history bias——一个 habit、一份 `karma`-like 的沉积、一条被自己过去塑形的 policy——建模成一个 memory kernel,而你忍不住想叫它 "inertia",一个让系统抵抗被 redirect 的 mass。这段推导说:**只有当那份 memory 能 store and return、并且运作在一个与它所塑形的行为 comparable 的 timescale 上,你才有资格用 inertia 这个读法。** 如果那份 accumulated bias 的诚实模型是 monotone forgetting——一个 `習氣`/习气,作为一个不断衰减、永远为正的、压在过去上的权重,而这是最自然的读法——那它就是一个 *viscous drag*,即 **feedback,而非 inertia。** 叫它 mass,是在借一个 resonance 和一份 stored momentum,而模型里并不含它。

所以要抓住的具体断言:*inertia 和 feedback 是同一个 memory kernel 的 reactive 部分与 dissipative 部分;它们不是同一个 limit。* 把 history-dependence 建模成牛顿 mass,偷偷夹带了一个假设——系统有一个 reactive storage mode——而一个朴素的"accumulated forgetting" kernel并不满足它。保守的 default 是 feedback(正比于加权近期速度的 sticky drag,恰如你会猜的那样);inertial 的升级必须靠**展示出那个 storage mode** 来*挣得*。

## 7. 一个单一的 disconfirming test(证伪测试)

对任何你想叫作 "inertial" 的具体 history-dependent 系统,写下它的 memory kernel `K(s)`,查两件事:

1. **`K(s)` 有 negative lobe 吗**(等价地 `∫ s K(s) ds < 0`)?没有 negative lobe ⇒ 纯 dissipative ⇒ feedback,而那个 "mass" 是个比喻。
2. **它的 memory time 是 non-adiabatic 吗**——与系统自身 timescale comparable,而不是快到几乎瞬时?如果 memory 相对 dynamics 很快,`m_eff → 0` ⇒ feedback。

只有当**两者**都为 yes 时,那个 second-order/inertial 描述才带真内容。否则诚实的词是 *feedback*。

对这个测试的一条 caveat,又是来自审查:一个负的 first moment,对一个 scalar finite-moment kernel 而言,确实是 positive *apparent*(表观)低频 mass 的**充分必要**条件。但 *stable、genuine*(稳定、货真价实)的 inertia 要求更多——effective damping 必须在相关 band 内保持为正(passivity),所有 poles 必须落在稳定半平面里,一对 complex pole 必须真的存在(Channel B 里的 `(k−B)² < 4gA`),而且那个 resonance 必须落在 reduced model 的适用范围内。这个两部分测试是一个合适的快速 sanity check,不是完整定理。

---

### Reproducibility(可复现性)

整个结果是几行 linear response;Section 4 里的 toy 是纯 `numpy`(无外部调用)。核心计算:

```python
import numpy as np

# Channel A: viscous memory kernel K(s) = (gamma/tau) exp(-s/tau)
def channelA_meff(gamma, tau):
    # m_eff = -∫ s K(s) ds = -gamma*tau  (always < 0)
    return -gamma * tau

# Channel B: eliminate a reactive coupled mode
def channelB(k, g, A, B):
    k_eff  = k + g*A/B
    g_eff  = 1 - g*A/B**2
    m_eff  = g*A/B**3          # > 0, -> 0 as B -> inf (Higgs pattern)
    poles  = np.linalg.eigvals(np.array([[-k, g], [-A, -B]]))
    return k_eff, g_eff, m_eff, poles   # complex poles => genuine inertia
```

*如果你发现一个 error——一个 sign、一个 limit、一个漏掉的 regime——或一个更锋利的 framing,我想听。*
