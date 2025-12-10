# This file was generated, do not modify it. # hide
#hideall
import Plots
# Fig 1: infinite step penalty versus linear penalty
Plots.plot([-2; 0; 0], [0; 0; 10]; label = "I(u)", lw=2)
Plots.plot!([-2; 2], [-0.8; 0.8]; label = "0.4u", lw=2)
Plots.plot!(xlabel="u", xlims=(-1.5,1.5), ylims=(-1,1),aspect_ratio=:equal)

Plots.savefig(joinpath(@OUTPUT, "linear.svg"));