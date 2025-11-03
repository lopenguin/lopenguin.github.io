+++
title = "Polynomial Duals and Lagrangian SOS"
hasmath = true
hascode = false

date = Date(2025, 10, 23)
tags = ["blog", "SDP", "duality"]
+++

# The moment-sum-of-squares hierarchy generalizes the Lagrangian
@@note
    @@title ⓘ See Also @@
    @@content
        This post draws from [Prof. Davis Knowles's notes on the Lagrangian](https://www-cs.stanford.edu/people/davidknowles/lagrangian_duality.pdf) and the sum-of-squares formalisms in [Nie and Demmel (2005)](https://doi.org/10.1007/s10898-005-2099-2).
    @@
@@

There's a deep, somewhat subtle connection between Lagrangian duality and the moment-sum-of-squares hierarchy for polynomial optimization. In this post I will show, for polynomial optimization problems, that the sum-of-squares hierarchy essentially generalizes the Lagrangian dual to a *polynomial* dual.

## Setup
Consider a general polynomial optimization problem:

\begin{align}
\label{eq:optprob}
p^\star = \min_{x} &f(x)\\
\mathrm{s.t.}\:&g_i(x) \leq 0,\ i=1,...,N,
\end{align}

where $f$ and $g_i$ are polynomials of order at most $d$ in $x\in\mathbb{R}^n$.

This problem is *non-convex* for generic polynomials. Instead of trying to solve it exactly, we'll focus on two relaxation approaches. The first is *Lagrangian duality*, the standard approach, which imposes a linear penalty on constraint violation. In this post we show the *moment-sum-of-squares hierarchy* generalizes the linear penality to a polynomial penalty to achieve better bounds.

## Preview
Before we get to the proofs, let me show you the Lagragian (scalar) dual and the polynomial (moment-sum-of-squares hierarchy) dual.

The Lagrangian dual is:
\begin{align}
d^\star = \max_{\lambda\geq0}\ &f(0) + \sum_{i=1}^N \lambda_i g_i(0)\\
\mathrm{s.t.}\:& \hat f(x) + \sum_{i=1}^N \lambda_i \hat g_i(x) \succeq_{sos} 0.
\end{align}

The polynomial dual from moment-sum-of-squares is:
\begin{align}
d_\kappa^\star = \max_{\lambda_i \in \mathbb{R}_\kappa[x],\ \lambda_i(x) \succeq_{sos} 0}\ & f(0) + \sum_{i=1}^N \lambda_i(0) g_i(0)\\
\mathrm{s.t.}\:& \hat f(x) + \sum_{i=1}^N \hat \lambda_i(x) \hat g_i(x) \succeq_{sos} 0.
\end{align}

I'm using a compact SOS notation, but this is the standard Lagrangian dual and moment-sos-hierarchy of order $\kappa$. The key difference is the scalar dual variable $\lambda_i$ is replaced with a dual polynomial $\lambda_i(x)$ (of order $\kappa$). Both dual problems are convex, and the polynomial dual is guaranteed (under some regularity) to return the primal solution as $\kappa\rightarrow\infty$. Let's explore these in more detail.

## Lagrangian dual
In this section, we show the Lagrangian dual gives a lower bound to \eqref{eq:optprob} and imposes a linear penalty on constraint violation. Eq. \eqref{eq:optprob} is equivalent to:

\begin{equation}
\label{eq:lagrangianform}
p^\star = \min_x \max_{\lambda \in \mathbb{R}^N_{\geq 0}} f(x) + \sum_{i=1}^N \lambda_i g_i(x).
\end{equation}

The new objective is called the *Lagrangian*. To see the equivalence with \eqref{eq:optprob}, consider the minimum and maximum together. If any of the constraints on $x$ are not satisfied, the maximum gives $+\infty$ which cannot be minimized. Thus, any finite solution requires all constraints to be satisfied. When all $g_i(x) \leq 0$, the inner maximization is solved for $\lambda_i \equiv 0$, yielding exactly \eqref{eq:optprob}.

The Lagrangian dual simply swaps the minimum and maximum. That is,
\begin{equation}
\label{eq:dual}
d^\star = \max_{\lambda \in \mathbb{R}^N_{\geq 0}} \min_x f(x) + \sum_{i=1}^N \lambda_i g_i(x).
\end{equation}

Why is this dual useful? It's a concave program! The inner optimization problem is concave (more precisely, linear) in $\lambda_i$. And the pointwise minimum (over all points $x$) of concave functions is concave (though it may no longer be linear). We'll make this precise in the next section. Taking the maximum of a concave function lies in the regime of convex optimization.

Importantly, the dual also provides a *lower bound* on the solution to \eqref{eq:optprob}. Consider the Lagrangian:
$$
\mathcal{L}(x, \lambda) \triangleq f(x) + \sum_{i=1}^N \lambda_i g_i(x).
$$

For any primal feasible $x$ (satisfying all inequality constraints) and dual feasible $\lambda \geq 0$, we have the following two inequalities:
$$
\lambda_i g_i(x) \leq 0 \implies \mathcal{L}(x, \lambda) \leq f(x),
$$
and
$$
\min_x \mathcal{L}(x, \lambda) \leq \mathcal{L}(x, \lambda).
$$

Putting these together, for all feasible $(x, \lambda)$ we have:
$$
\min_x \mathcal{L}(x, \lambda) \leq \mathcal{L}(x, \lambda) \leq f(x).
$$

By taking the maximum over $\lambda$ on the lefthand side and the primal optimal $x$ on the righthand side, we have shown *weak dualty*.

@@theorem
    **Theorem.** (Weak duality)
    The Lagrangian dual lower bounds the primal: $d^\star \leq p^\star$.
@@

### Specializing to polynomials
Let's make the concavity of the dual a little more explicit in the case of polynomials. We first introduce a little notation:

@@notation
    **Notation.**
    $f\in\mathbb{R}_d[x]$ means $f(x)$ is a polynomial in $x$ of degree at most $d$.
@@

Every polynomial $f \in \mathbb{R}_d[x]$ can be written as $[x]_{\lceil d/2 \rceil}^T A [x]_{\lceil d/2 \rceil}$ for some symmetric matrix $A$ (not necessarily unique). We call this a **quadratic form**.

@@notation
    **Notation.**
    $[x]_{d}$ is the vector of monomials of degree at most $d$. For $x\in\mathbb{R}^n$,

    $$
    [x]_{d} \triangleq [1, x_1, ..., x_n, x_1^2, x_1x_2, ..., x_n^d]^T \in \mathbb{R}^{C(d+n,\ d)}.
    $$
    
    This is called the monomial basis.
@@

Using the quadratic form of $f,\ g_i\in\mathbb{R}_{2d}[x]$, we rewrite the Lagrangian as below:

$$
\mathcal{L}(x, \lambda) = [x]_d^T A [x]_d + \sum_{i=1}^N \lambda_i [x]_d^T B_i [x]_d.
$$

Recall that the first element of the monomial basis $[x]_d$ is $1$. To derive the dual it is helpful to separate out the constant terms:
$$
\mathcal{L}(x, \lambda) = A_{1,1} + \sum_{i=1}^N \lambda_i (B_i)_{1,1} + [x]_d^T \hat A [x]_d + \sum_{i=1}^N \lambda_i [x]_d^T \hat B_i [x]_d,
$$
where $\hat A$ and $\hat B_i$ set the $(1,1)$ term to $0$ to remove the constants. From \eqref{eq:dual}, we first minimize the Lagrangian over $x$. Using the trace trick, separate $x$ from $\lambda$:

$$
\min_x \mathcal{L}(x, \lambda) = A_{1,1} + \sum_{i=1}^N \lambda_i (B_i)_{1,1} + \min_x \left\langle \hat A + \sum_{i=1}^N \lambda_i \hat B_i, [x]_d [x]_d^T\right\rangle.
$$

Since $[x]_d [x]_d^T\succeq 0$, the remaining minimum reaches $-\infty$ if $\hat A + \sum_{i=1}^N \lambda_i \hat B_i$ has any negative eigenvalues. Thus, we have the Lagrangian dual:

\begin{align}
\label{eq:dualexplicit}
d^\star = \max_{\lambda\geq0}\ & A_{1,1} + \sum_{i=1}^N \lambda_i (B_i)_{1,1}\\
\mathrm{s.t.}\:& \hat A + \sum_{i=1}^N \lambda_i \hat B_i \succeq 0.
\end{align}

This is just a convex semidefinite program! We've completed the scalar Lagrangian relaxation of our original non-convex polynomial optimization problem. By weak duality, we have $d^\star \leq p^\star$. In the case $d^\star < p^\star$, can we get a tighter bound or solve \eqref{eq:optprob} exactly? Yes, using higher-order duals from the moment-sum-of-squares hierarchy.


## Better lower bounds via moment-sum-of-squares
I've mentioned several times that the moment-sum-of-squares hierarchy replaces the scalar dual variables $\lambda_i$ with *polynomial* duals. Let's make this explicit. Eq. \eqref{eq:optprob} is equivalent to:

$$
p^\star = \min_x \max_{\lambda_i \in \mathbb{R}_\kappa[x]_{\geq 0}} f(x) + \sum_{i=1}^N \lambda_i(x) g_i(x).
$$

The proof is exactly the same as the Lagrangian dual, noting that the notation  $\lambda_i(x) \geq 0$ (in fact, we can use a weaker condition that $\lambda_i$ is sum-of-squares, but we introduce this later). It is perhaps unsurprising that the moment-sum-of-squares dual simply swaps the minimum and maximum:

$$
\label{eq:dualp}
d^\star_\kappa = \max_{\lambda_i \in \mathbb{R}_\kappa[x]_{\geq 0}} \min_x f(x) + \sum_{i=1}^N \lambda_i(x) g_i(x).
$$

The same reasoning as before gives $d^\star_\kappa \leq p^\star$. The special case $\lambda_i \in \mathbb{R}_\geq 0$ (all higher order terms are $0$) gives $d^\star \leq d^\star_\kappa$. That is, the moment-sum-of-squares dual is at least as good a lower bound as the Lagrangian dual.

@@theorem
    **Theorem.** (Weak polynomial duality)
    The polynomial dual is an upper bound on the Lagrangian dual and a lower bound on the primal: $d^\star \leq d^\star_\kappa \leq p^\star$.
@@

I want to give some intuition as to why a polynomial dual might perform better than a linear dual. Mathematically, the dual polynomial has more degrees of freedom to maximize over (this manifests as matrix comparison, which we will see below). But the idea of the Lagrangian is to move constraints into the objective with a large penalty. A polynomial dual is a much more expressive penalty than a scalar dual.

We next derive the exact form of the polynomial dual.

### The polynomial dual
For positive polynomials $\lambda_i \in \mathbb{R}_{2\kappa}[x]_{\geq 0}$, the polynomial Lagrangian is:

$$
\mathcal{L}_\kappa(x,\lambda(x)) = f(x) + \sum_{i=1}^N \lambda_i(x) g_i(x).
$$

Note the subscript $\kappa$, which indexes the maximum order of the polynomial duals and gives rise to a relaxation hierarchy. As with the scalar Lagrangian, we'll rewrite each polynomial in quadratic form and pull out the constant parts. Start with the product $\lambda_i(x)g_i(x)$, which is a polynomial of order at most $2d+2\kappa$. Breezing through some algebra, we can represent $\lambda_i(x)g_i(x)$ as $[x]_{d+\kappa}^T C_i [x]_{d+\kappa}$. In quadratic form, the Lagrangian is:

$$
\mathcal{L}_\kappa(x,C) = [x]_d^T A [x]_d + \sum_{i=1}^N [x]_{d+\kappa}^T C_i [x]_{d+\kappa}.
$$

Notice that we now have a $N$ dual matrices $C_i$, which we use for ease of exposition. From here the derivation is nearly identical to the scalar Lagrangian dual. Next, separate the constant terms:

$$
\mathcal{L}_\kappa(x,C) = A_{1,1} + \sum_{i=1}^N (C_i)_{1,1} + [x]_d^T \hat A [x]_d + \sum_{i=1}^N [x]_d^T \hat C_i [x]_d,
$$
where the hatted matrices have their $(1,1)$ element as 0 (they are polynomials with no constant term). From \eqref{eq:dualp}, we take the inner minimization of the polynomial Lagrangian over $x$. We'll use the same trace trick to separate the dual variables from $x$:

$$
\label{eq:dualpwithmin}
\min_x \mathcal{L}_\kappa(x,C) = A_{1,1} + \sum_{i=1}^N (C_i)_{1,1} + \min_x \left\langle \begin{bmatrix} \hat A & 0 \\ 0 & 0 \end{bmatrix} + \sum_{i=1}^N \hat C_i,  [x]_{d+\kappa} [x]_{d+\kappa}^T \right\rangle.
$$

In eq. \eqref{eq:dualpwithmin}, we pad $\hat A$ with zeros to account for the expanded polynomial basis. Noting that $[x]_{d+\kappa} [x]_{d+\kappa}^T\succeq 0$, we must take the inner product with a positive semidefinite matrix to get a finite minimum. This constraint gives the dual problem:

\begin{align}
d_\kappa^\star = \max_{C_i}\ & A_{1,1} + \sum_{i=1}^N (C_i)_{1,1}\\
\mathrm{s.t.}\:& \begin{bmatrix} \hat A & 0 \\ 0 & 0 \end{bmatrix} + \sum_{i=1}^N \hat C_i \succeq 0.
\end{align}


What happened here? We simply absorbed the dual polynomial into a higher-order polynomial (the ring of polynomials is closed under multiplication). After that, we used the same steps as the scalar Lagragian to derive a dual problem!

A simpler way to write the above problem uses *sum-of-squares* notation and the more restrictive constraint that $\lambda_i(x)$ are sum-of-squares (explained in the next section). For the sake of comparison with \eqref{eq:dualexplicit}, the polynomial dual is:

\begin{align}
\label{eq:dkappa}
d_\kappa^\star = \max_{\lambda_i(x) \in \mathbb{R}_\kappa[x]_{\succeq_{sos} 0}}\ & f(0) + \sum_{i=1}^N \lambda_i(0) g_i(0)\\
\mathrm{s.t.}\:& f(x) - f(0) + \sum_{i=1}^N (\lambda_i(x) g_i(x) - \lambda_i(0) g_i(0)) \succeq_{sos} 0.
\end{align}

Hopefully I've convinced you that this hierarchy generalizes the Lagrangian dual using polynomial duals. We've also seen that the polynomial dual cannot give any worse of a lower bound than the Lagrangian dual. It turns out we can make a much stronger statement: under some regularity, the polynomial dual converges to the value of the (non-convex) primal as polynomial order tends towards infinity. To see this, we first need a little background in sum-of-squares programming.


### Sum-of-squares background

<!-- SOS inequality notation (or will that scare?) -->
A sum-of-squares (SOS) polynomial is simply a polynomial that can be written as the sum of the squares of other polynomials. We'll use a convenient result from [Parrilo (2003)](https://doi.org/10.1007/s10107-003-0387-5) to connect SOS polynomials to positive semidefinite matrices.

@@theorem
    **Theorem.**  
    A polynomial $p(x)\in\mathbb{R}_{2d}[x]$ is sum-of-squares if and only if there exists $A \succeq 0$ such that $p(x) = [x]_d^T A [x_d]$. This can be checked with a semidefinite feasibility problem.
@@

This representation motivates the following shorthand notation.

@@notation
    **Notation.**
    We write $p(x) \succeq_{sos} 0$ to mean $p(x)$ is sum-of-squares. That is, $p(x)$ can be written as $p(x) = [x]_d^T A [x_d]$ with $A \succeq 0$.
@@

SOS polynomials are an important subset of the set of *positive* polynomials $p(x) \geq 0$. Checking whether a polynomial is positive is an NP-hard problem, but checking if $p(x)$ is SOS only requires solving an SDP.

<!-- Putinar -->
Fortunately, strictly positive polynomials may be represented in part with SOS polynomials. This result is called a positivestellensatz.

@@theorem
    **Theorem.** (Putinar's Positivestellensatz) Let $\mathcal{K} \triangleq \{x : g_i(x) \leq 0 \ \forall\ i\}$, where $g_i(x)$ are polynomials (a basic semialgebraic set). Assume $\mathcal{K}$ is compact. If $p(x) > 0$ for $x\in\mathcal{K}$, then
    $$ \label{eq:putinarorig} p(x) = p_0(x) - \sum_{i=1}^N p_i(x) g_i(x), $$
    where $p_i(x) \succeq_{sos} 0$ for $i=0,1,...,N$.
@@

Rearranging \eqref{eq:putinarorig}, Putinar equivalently states that there exist $p_i(x) \succeq_{sos} 0$ such that:
$$
\label{eq:putinar}
p(x) + \sum_{i=1}^N p_i(x) g_i(x) \succeq_{sos} 0.
$$

Note that Putinar guarantees the existance of some polynomials $p_i(x)$ and does not specify order. In practice, we must restrict $p_i(x)$ to order $\kappa$. This leads directly to a *hierarchy* of relaxations which use higher-order dual polynomials.


### Convergence to primal
In this section we'll show the following result, due to [Lasserre (2001)](https://doi.org/10.1137/S1052623400366802).

@@theorem
    **Theorem.** (Hierarchy convergence)
    The solution to the polynomial dual converges to the primal solution as relaxation order $\kappa\rightarrow\infty$: 
    $$
    d^\star_\kappa \rightarrow p^\star \text{ as }\kappa\rightarrow\infty.
    $$
@@

Putinar's positivestellensatz is the key to the proof. Define the constraint set $\mathcal{K} \triangleq \{x : g_i(x) \leq 0 \ \forall\ i\}$. The primal \eqref{eq:optprob} is equivalent to maximizing a lower bound on $f(x)$:

\begin{align}
p^\star = \max_c \ &c\\
\mathrm{s.t.}\ & f(x) - c \geq 0 \text{ for all } x\in\mathcal{K}.
\end{align}

Let's relax the constraint $f(x) - c \geq 0$ to $f(x) - c > 0$ and replace it with a sum-of-squares inequality using Putinar. We get the relaxed problem:

\begin{align}
\label{eq:optput}
d_\mathrm{putinar}^\star = \max_{c,\ \lambda_i(x)\succeq_{sos} 0} \ &c\\
\mathrm{s.t.}\ & f(x) - c + \sum_{i=1}^N \lambda_i(x)g_i(x) \succeq_{sos} 0.
\end{align}

By the relaxation to a strict inequality, we have $d^\star_\mathrm{putinar} \leq p^\star$.

As an aside, we now show \eqref{eq:optput} is equivalent to the polynomial dual \eqref{eq:dkappa} with no constraint on dual polynomial order $\kappa$. The constant terms can be absorbed into $c$ as follows. The $(1,1)$ element of the SOS inequality constraint reads:

$$
f(0) - c + \sum_{i=1}^N \lambda_i(0) g_i(0) \geq 0
\iff
c \leq f(0) + \sum_{i=1}^N \lambda_i(0) g_i(0).
$$

Meanwhile, the remaining SOS inequality does not include $c$. Thus, we can replace $c$ with its upper bound without changing the optimization problem, arriving at:

\begin{align}
d_\mathrm{putinar}^\star = \max_{\lambda_i(x) \succeq_{sos} 0}\ & f(0) + \sum_{i=1}^N \lambda_i(0) g_i(0)\\
\mathrm{s.t.}\:& f(x) - f(0) + \sum_{i=1}^N (\lambda_i(x) g_i(x) - \lambda_i(0) g_i(0)) \succeq_{sos} 0.
\end{align}

Having established equivalence, we now use \eqref{eq:optput} to prove the polynomial hierarchy converges. From duality, it holds $d^\star_\mathrm{putinar} \leq p^\star$. Our strategy is to squeeze the dual with a lower bound. Let $x^\star$ solve the primal \eqref{eq:optprob} with value $p^\star = f(x^\star)$. Perturb $x^\star$ to $z=x^\star + \epsilon\in\mathcal{K}$ such that $f(z) = p^\star - \delta$. The perturbed point $z$ enjoys strict positivity: $f(z) - p^\star > 0$. Therefore, $z$ is feasible for the Putinar dual \eqref{eq:optput}. Thus,

$$
p^\star - \delta \leq d^\star_\mathrm{putinar} \leq p^\star.
$$

Since $f$ is a polynomial we can make $\delta$ arbitrarily small by appropriate choice of $\epsilon$. This shows that with arbitrary high polynomial order the polynomial dual converges to the true value and completes the proof. 

The hierarchy convergence theorem is a remarkable result because it uses convex optimization techniques to solve a non-convex problem. It's worth pointing out, however, that there's no free lunch. Stepping up the relaxation order increases the size of the problem polynomially, making high-order relaxations essentially impratical in real-world applications.


## Conclusion
That was quite a journey! Duality is one of the most interesting and useful concepts in optimization, and I find it remarkable that duality can be "generalized" for a class of otherwise hard polynomial problems. The bonus of a lower bound is the possibility of a *optimality gap*. Given a primal feasible point $x$, the optimality gap is the difference between $f(x)$ and the dual $d^\star$. There many rounding schemes to obtain a good guess for $x$ from the dual solution, and this metric is the main "certificate" in certifiable optimization research.



This line of reasoning led me to a few questions for further thought:
- Is there a generalization of the dual for other classes of problems?
    - Answer (probably): we need the dual to be convex in order to get good approximations. This greatly restricts the class of possible dual functions. Polynomials worked in this case largely because polynomials are closed under multiplication.
- On the more practical side: are there other polynomial bases which have computational benefits?
