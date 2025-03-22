# This file was generated, do not modify it. # hide
import Plots #hide

# spiral
t = LinRange(0,6*π,1000)
Plots.plot3d(cos.(t), sin.(t), t,label="trajectory")

t2 = LinRange(0.5,5*π+2, 8)
Plots.scatter3d!(cos.(t2), sin.(t2), t2,label="samples")
Plots.quiver!(cos.(t2),sin.(t2),t2, quiver=(-0.5*sin.(t2), 0.5*cos.(t2), 0.5*ones(8)), color=:red)
Plots.quiver!(cos.(t2),sin.(t2),t2, quiver=(0.5*cos.(t2), 0.5*sin.(t2), -0.5*zeros(8)), color=:green)
# Plots.quiver!(cos.(t2),sin.(t2),t2, quiver=(-0.5*sin.(t2), 0.5*cos.(t2), -0.5*ones(8)), color=:blue)
Plots.savefig(joinpath(@OUTPUT, "cast-bodyframe.svg")); #hide