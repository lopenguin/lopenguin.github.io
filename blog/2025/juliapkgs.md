+++
title = "Julia Packages"
hasmath = true
hascode = false

date = Date(2025, 6, 19)
tags = ["blog", "julia", "p3p", "pnp", ""]
+++

# A Small Index of My Julia Packages
Recently, I've had a lot of fun building and releasing simple packages for the Julia programming language. If you haven't used Julia, it's a fantastic language for mathematicians and the mathematically-inclined: you can use greek letters as variable names, you can omit that ugly `*` sign between constant coefficients and variables (you can write `2x` for `2*x`, for example), and most importantly it is fast. When I think about working on the future of robotics, Julia is my language of choice.

As such, I've recently assembled a couple of small informal Julia packages. I thought it would be helpful to put them all in one place.

## [TutorialTSSOS.jl](https://github.com/lopenguin/TutorialTSSOS.jl)
This package is designed as a basic tutorial for [TSSOS](https://github.com/wangjie212/TSSOS) geared towards roboticists and computer vision researchers. TSSOS is a fantastic tool for automatically generating sparse semidefinite relaxations of polynomial optimization problems at arbitrary order, but it can be somewhat hard to use. In the tutorial, I give a simple example (certifiable PnP) and walk through the steps of constructing the polynomial problem and solving it with TSSOS. PnP is a particularly good example because the first order relaxation is only sometimes tight, but the second order relaxation is almost always tight. A great strength of TSSOS is easily generating the higher-order relaxation when the lower-order is not tight.

The tutorial also includes an example script which goes deeper into [my fork of TSSOS](https://github.com/lopenguin/TSSOS.jl). In my fork, I change the output arguments to expose the JuMP model that TSSOS solves. This allows greater transparency (you can easily inspect the model before solving it), the use of additional solvers, and the ability to impose additional constraints. Of course, it also adds to the overhead of solving and processing a solution. The goal of the example is to show you one way to process the solution which can be easily copied into a different problem setup.

As I gather feedback on this first iteration of the tutorial I hope to add more examples and perhaps flesh out the advanced PnP example.

## [SimpleRotations.jl](https://github.com/lopenguin/SimpleRotations.jl)
This is a very minimal package which implements basic transforms between rotation representations and related functions such as generating a random rotation matrix or projecting a matrix to $\mathrm{SO}(3)$. It's not designed to be fast, minimal, or complete. Just simple. At this point, it's become a dependency of most of projects.

## [P3P.jl](https://github.com/lopenguin/P3P.jl)
I implement in Julia the direct P3P method by [Nakano](https://github.com/g9nkn/p3p_problem). The code is pretty much a direct port of the MATLAB implementation and was written quickly to fill my need (for a P3P solver in Julia). I'm open to implementations of more P3P solvers, or to folding this into a larger image processing library. The package consists of only the Nakano P3P function.

## [TSSOS (fork)](https://github.com/lopenguin/TSSOS.jl)
This is my fork of the fantastic project [TSSOS](https://github.com/wangjie212/TSSOS) for polynomial optimization. I largely modify TSSOS for interpretability and flexibility. In particular, I adjust the functions `cs_tssos_first` and `cs_tssos_higher!` to also return the JuMP model of the convex semidefinite program. The user can choose to solve this program themselves, with any conic solver and any additional constraints. It's also really easy to inspect the SDP to make sure the right constraints are imposed.

The fork is far from perfect. In particular, the interface is somewhat lazily written to interface with TSSOS. In time, I hope to incorporate some of this code in the main TSSOS project and rework it for a better interface.