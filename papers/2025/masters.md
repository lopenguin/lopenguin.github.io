+++
title = "Master's Thesis"
hasmath = false
hascode = false
hasjsx = false

date = Date(2025, 5, 16)
arxiv = ""
venue = "D-Space"
link = "/papers/2025/masters"
code = ""
video = "/papers/2025/masters"
authors = "Lorenzo Shaikewitz"

tags = ["rotations", "SDP", "papers", "selected", "CASTW", "masters"]
+++

# Master's Thesis: Optimization Techniques for Trustworthy 3D Object Understanding

I submitted my master's thesis to the department on Friday, May 16. It's focused on fundamental algorithms for estimating the position, orientation, and shape of objects. You can download a draft 
~~~
<a target="_blank" href="https://drive.google.com/file/d/1ddFhrA-AP_cN_WmZDIanHxaTQoyg3i-K/view?usp=sharing">here</a>.
~~~
Here's a brief outline:

1. **Preliminaries.** A review of the mathematics, including Shor's relaxation, conformal prediction, and quaternion algebra.
1. **Certifiable Object Tracking.** We propose an algorithm to track objects and estimate their shape over multiple observations. It's globally optimal in the certifiable sense. Compared to the [publication](https://ieeexplore.ieee.org/document/10756720), we add a world-frame motion model which is significantly faster.
1. **Conformal Pose Uncertainty.** Pose estimation with statistically valid translation and rotation bounds. We propagate conformal prediction bounds from the measurements (keypoints) to a pose uncertainty set, and efficiently bound the set using an ellipse.
1. **Sub-Millisecond Local Pose and Shape Estimates.** We rewrite the first-order optimality conditions as a nonlinear eigenproblem which can be solved in less than a millisecond using self-consistent field iteration. Solutions are local (no certificate), but can update quickly.

## Extra Videos
### Certifiable tracking

~~~
<iframe width="560" src="https://www.youtube.com/embed/eTIlVD9pDtc?si=R9y1kZ3ghJdxcQEj" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen style="display: block;margin: 0 auto; max-width: 100%; aspect-ratio: 16 / 9;"></iframe>
~~~

### Conformalized pose estimates
Some examples of conformal uncertainty sets (rotational uncertainty for fixed translation):

~~~
<p>
<img src="/assets/blog/masters/duck352.png" alt="Example uncertainty sets" style="width:560px;">
</p>
~~~

A video showing the central pose estimate for the "duck" object (if the video is broken, try a different browser or download):

~~~
<video width="640" height=auto controls style="display: block;margin: 0 auto; max-width: 100%;">
    <source src="/assets/blog/masters/est.mp4" type="video/mp4">
    Your browser does not support the video tag.
</video>
~~~

### Self-consistent field iterations
~~~
<div class="row">
    <div class="column" style="width: 33.33%; float: left;">
        <img src="/assets/blog/masters/scf_oneiter.gif" alt="One iteration of SCF">
    </div>
    <div class="column" style="width: 33.33%; float: left;">
        <img src="/assets/blog/masters/scf_onemin.gif" alt="One iteration of SCF">
    </div>
    <div class="column" style="width: 33.33%; float: left;">
        <img src="/assets/blog/masters/scf_twomins.gif" alt="One iteration of SCF">
    </div>
</div> 
~~~
These animations show the trajectory of self-consistent field iteration as stereographic projections of quaternions onto the volume of the unit ball. Left, a single SCF trajectory which quickly converges. Center, an example problem where any initialization leads to the same optima. Right, an example problem where starting at an orange point leads to one minimum, and starting at a green point leads to a distinct minimum. The cross marker shows the ground truth.

## Poster
~~~
<a href="/assets/blog/masters/MastersPoster.png">
<img src="/assets/blog/masters/MastersPoster.png" alt="Click to zoom in">
</a>
~~~

## Corrections
These corrections apply to the version on MIT DSPACE. 
~~~
<a target="_blank" href="https://drive.google.com/file/d/1ddFhrA-AP_cN_WmZDIanHxaTQoyg3i-K/view?usp=sharing">This draft</a>
~~~
is up to date with the latest version.

1. The functions $\Omega_2$ with $\Omega_1$ are exchanged in eq. 2.23, which led to an error that propagates through 2.24 and 2.25. Eq. 2.25 should read:
$$
\mathbf{x}^\mathsf{T}\mathbf R\mathbf y
    = 
    -\mathbf q^\mathsf{T} \mathbf{\Omega}_1(\tilde{\mathbf x})\mathbf{\Omega}_2(\tilde{\mathbf y})\mathbf q
$$
2. There should be a negative sign in the lower off-diagonal block in eqs. 4.16 and 4.18.

## BibTeX
```plaintext
@misc{Coming soon!}
```

## Related Papers
{{paperswithtags selected SDP}}
