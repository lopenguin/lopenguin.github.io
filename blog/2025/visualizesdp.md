+++
title = "Visualizing Semidefinite Relaxation"
hasmath = true
hascode = false
hasplotly = true

date = Date(2025, 12, 10)
tags = ["blog", "SDP", "visualization"]
+++

# Visualizing Semidefinite Relaxations
Many robotics researchers (including myself!) have shown something like this image to explain the main idea behind an SDP relaxation:

@@figure
    ~~~ <img src="/assets/blog/sdp_visualizations/standard.png" style="max-width:100%;width:600px;margin:auto;"/> ~~~
    @@figcaption 
        Semidefinite relaxations are not, as this picture suggests, a convex approximation of a non-convex function.
    @@
@@

This visualization gets across the rough point: we solve a convex problem and arrive at the global minimizer (sometimes). But it's also wrong. The relaxation doesn't change the function value! Consider a generic relaxation:

\begin{equation}
f_\mathrm{orig}(x) = x^T A x
\ 
\overset{\text{relax}}{\longrightarrow}
\ 
f_\mathrm{SDP}(X) = \langle A, X \rangle,\  X\succeq 0.
\end{equation}

First of all, $f_\mathrm{orig}$ and $f_\mathrm{SDP}$ don't even have the same domain. We can restrict $f_\mathrm{SDP}$ to rank-1 matrices in order to plot them together. But then $X = xx^T$ so $f_\mathrm{orig}$ and its relaxation overlap:

@@figure
    ~~~ <img src="/assets/blog/sdp_visualizations/standard_correct.png" style="max-width:100%;width:300px;margin:auto;"/> ~~~
    @@figcaption 
        The correct visualization on the same domain is... not very helpful.
    @@
@@

Clearly, two dimensions is not enough to convey an accurate picture. Even with 3D plots we cannot perfectly show an SDP relaxation. But we can get much closer to the true spirit of it. In my view, the key insight of semidefinite relaxations is *lifting*. The relaxation doesn't magically find a convex function which has the same minimum as the original polynomial. Instead, it minimizes a higher-dimensional extension of $f_\mathrm{orig}$. Once you understand this, it is easy to see the certificate (the lifted minimizer is on the original domain) and why the relaxation sometimes doesn't work (the lifted minimizer is not on the original domain).

Here is the relaxation image I would show:

@@figure
    ~~~ <img src="/assets/blog/sdp_visualizations/better_sdp.png" style="max-width:100%;width:300px;margin:auto;"/> ~~~
    @@figcaption 
        While still not completely accurate, this highlights the lifting nature of an SDP relaxation.
    @@
@@

You can play around with a 3D version of this in [Desmos](https://www.desmos.com/3d/2cdf9680bd). This is not an SDP relaxation! But it is sort of the same style of lifting relaxation. The original problem is:

\begin{equation}
\label{eq:orig}
\min_{\substack{x, y\in\mathbb{R}}}
x^2 + y\\
\mathrm{s.t.\:} x^2 + y^2 = 1
\end{equation}

Eq. \eqref{eq:orig} is non-convex due to the quadratic equality constraint. But we can easily relax it by changing the constraint to an inequality:

\begin{equation}
\min_{\substack{x, y\in\mathbb{R}}}
x^2 + y\\
\mathrm{s.t.\:} x^2 + y^2 \leq 1
\end{equation}

The relaxation lifts from a 1D optimization (along the intersection of a cylindrical surface and a 2D manifold) to a 2D optimization problem (a cylindrical volume and a 2D manifold). As a 1D problem, there are two local minima. By "lifting", the new problem has only one local minima which must be the global solution to \eqref{eq:orig}.

Since we cannot visualization an SDP relaxation in 2D or 3D, this is a good approximation of the main idea. Unlike the 2D picture, it shows that the benefit of a relaxation comes from lifting, not from some magic convex version of the objective. I think its important to show something which is at least consistent with the mathematics to first order. It makes the field more approachable.