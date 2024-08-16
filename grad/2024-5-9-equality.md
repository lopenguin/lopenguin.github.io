# Solving optimization problems with quadratic equality constraints
One thing I find odd about optimization theory is the division between the objective and the constraints. In a way, separating the two is a workaround for the limitations of dealing with infinity. To see what I mean, consider the following unconstrained optimization problem:

$$
\argmin_{x, y}\: (x-a)^2 + (y-b)^2 + \lambda(x-y)^2
$$

What is the effect of the $\lambda (x-y)^2$ term? For $\lambda=0$, the solution is simply $x=a$ and $y=b$, setting the objective to 0. But as $\lambda$ increases it forces $x$ and $y$ to be closer and closer. In the limit $\lambda\rightarrow\infty$, it is easy to see the solution must have $x=y$. Mathematically, the problem starts to resemble the *constrained* optimization problem:

$$
\argmin_{x, y}\: (x-a)^2 + (y-b)^2 \\
\mathrm{s.t.}\:\:x = y
$$

In fact, the unconstrained problem has a closed form solution for any choice of constants $a$, $b$, $\lambda$. The solution reflects this limiting behavior:

$$
x = \frac{(1+\lambda)a + \lambda b}{2\lambda+1} \Rightarrow x = \frac{a/\lambda + a + b}{2+1/\lambda}
$$

In the limit as $\lambda\rightarrow\infty$, $x = y = (a+b)/2$. It is now clear that the $\lambda(x-y)^2$ term performs exactly the same function as the constraint $x=y$ for $\lambda\rightarrow\infty$.

What's going on here? Can we move terms between the objective and constraint set through weights in general? The nonconvexity of problems with convex quadratic *equality* constraints suggests the answer is no, that limit arguments can only take you so far. To start an answer it helps to consider places where this objective trick is *almost* used: relaxations and dual problems, which often move the constraints into the objective.

## Relaxations and Duals
The standard [Lagrangian relaxation](https://en.wikipedia.org/wiki/Lagrangian_relaxation) 


TODO: Lagrangian relaxation, stationarity KKT, dual problem


## A Potential Problem: Inequality Constraints

## Solving Problems with Quadratic Equality Constraints
Consider the following quadratically constrained linear program:
$$
\argmin_{\mathbf{x}\in\mathbb{R}^n}\: \mathbf{A}\mathbf{x} 
$$


## Generalizing
$$
\argmin_{\mathbf{x}\in\mathbb{R}^n}\: \mathbf{f}(\mathbf{x}) + \lambda \mathbf{g}(\mathbf{x})
$$

To make this explicit, consider the canonical optimization problem:

$$
\argmin_{x\in\mathbb{R}^n}\: f_0(x) \\
\mathrm{s.t.}\:\:\: f_i(x) \leq 0\\
\quad\:\:\:\: h_j(x) = 0
$$

Suspending careful consideration of infinity, we could have written:

$$
\argmin_{x\in\mathbb{R}^n}\: f_0(x) + \sum_i\infty\cdot f_i(x) + \sum_j\infty\cdot\|h_j(x)\|^2
$$

Allow, for a moment, $\infty\cdot0 = 0$. Then, this new objective is infinity if any of the inequality or equality constraints are broken. If $h_j(x) != 0$, the entire objective goes to inifinty.

Clearly, there are a couple of problems with this. Besides using $\infty$ as a coefficient, the inequality constraints $f_i(x)$ don't play as nicely. If $f_i(x)<0$ the objective becomes negative infinity, and the other terms cease to matter. But hopefully the basic intuition is clear, at least for the equality constraints.

## Motivating

This fluidity between constraints and objective terms seems to an implicit part of how we solve problems. Lagrangian duality

## An example
Consider the two dimensional problem:
$$
\min_{x,y}\:(x-2y)^2 \quad\mathrm{s.t.}\:\; x^2 + y^2 = 1
$$
