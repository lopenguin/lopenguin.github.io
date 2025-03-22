+++
title = "Global Solutions over SO(3)"
hasmath = true
hascode = false

date = Date(2025, 2, 26)
tags = ["rotations", "non-convexity"]
+++

# Global Solutions to Non-Convex Problems: SO(3)
**Teaser.** Rotations are an inescapable challenge in robotics. In perception, they are often the only source of non-convexity in an otherwise benign quadratic program. In spite of this, many problems involving rotations can be solved to *global* optimality even when NP-hard in general. Examples include pose graph optimization \citep{sesync}, [category-level pose estimation](https://arxiv.org/abs/2104.08383) and [tracking](https://arxiv.org/abs/2406.16837), and [state estimation](https://arxiv.org/abs/2308.12418), among others. I assemble here the various approaches of achieving global optimality with the aim of exposing gaps in understanding and technique.

(TODO: SET UP BIBTEX)

## Some Background on SO(3)
The special orthogonal group, denoted SO(3), is a manifold composed of orthogonal matricies with determinant $+1$. It is a special case of the orthogonal group O(3), which includes rotations and reflections.

One common relaxation is to drop the determinant constraints (in 3D, these are the cross product constraints). Once reason this works is because the O(3) manifold is composed of two disjoint sets, distinguished by their determinant. 

(TODO: explain this. Starting point is SE-Sync. Make this a collapsable section.)

characterized by $12$ quadratic equality constraints.

## The Q-Method, Point Cloud Registration, and Arun's Method


## QCQPs and Shor's Relaxation
*Wait... its all the Lagrangian? Always has been*


## Manopt and Certifying Local Solvers


## Off the Deep End: Moment/SOS Hierarchy


## Wild Ideas (that probably will not work)


## Open Questions


## References
**Textbooks**

**Papers**
- \biblabel{sesync}{Rosen (2016)} Rosen, Carlone, Bandeira, and Leonard,  [SE-Sync: A Certifiably Correct Algorithm for Synchronization over the Special Euclidean Group](https://arxiv.org/abs/1612.07386), 2016.
- \biblabel{sesync}{Rosen (2016)} Rosen, Carlone, Bandeira, and Leonard,  [SE-Sync: A Certifiably Correct Algorithm for Synchronization over the Special Euclidean Group](https://arxiv.org/abs/1612.07386), 2016.