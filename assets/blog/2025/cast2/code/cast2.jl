# This file was generated, do not modify it. # hide
import Plots #hide

# straight line
t = LinRange(0,6*π,1000)
Plots.plot3d(0 .*t, 0 .*t, t, label="trajectory", ylim=[-0.5,0.5], xlim=[-0.5,0.5])

t2 = LinRange(0.5,5*π+2, 8)
Plots.scatter3d!(0 .*t2, 0 .*t2, t2,label="samples")
scale = 0.15
Plots.quiver!(0*t,0*t,t2, quiver=(-scale*sin.(t2), scale*ones(8), scale*cos.(t2)), color=:red)
Plots.quiver!(0*t,0*t,t2, quiver=( scale*cos.(t2), -scale*zeros(8), scale*sin.(t2)), color=:green)
# Plots.quiver!(0*t,0*t,t2, quiver=(scale*sin.(t2), scale*ones(8), -scale*cos.(t2)), color=:blue)
Plots.savefig(joinpath(@OUTPUT, "cast-worldframe.svg")); #hide