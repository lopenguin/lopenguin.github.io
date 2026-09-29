+++
title = "Separation Polynomials and SDP Optimization"
hasmath = true
hascode = false
hasplotly = true

date = Date(2026, 9, 28)
tags = ["blog", "SDP", "visualization", "polynomials"]
+++

# Separation polynomials and SDP optimization
Last spring, I took Pablo Parrilo's [semidefinite programming course](https://canvas.mit.edu/courses/36978) and got to dive really deep into polynomial optimization. One of the things that piqued my interest was generalizing separating hyperplanes to separating *polynomials*. I've already written about how the [SOS hierarchy generalizes the Lagrangian](/blog/2025/lagrangiansos/). The separating hyperplane story is, in a sense, the same story from a different perspective. After all, [separation implies optimization](https://www.mit.edu/~gfarina/2024/67220s24_L04A_separation/L04A.pdf).

## The Setup