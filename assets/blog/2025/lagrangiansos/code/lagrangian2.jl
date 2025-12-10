# This file was generated, do not modify it. # hide
#hideall
import Plots
#Plots.plotlyjs()
# Fig 2: three penalties
xs = [-2.; 0; 0.01; 2]
ys = [-2.; 0; 0.01; 2]
X = [x for y in ys, x in xs]
Y = [y for y in ys, x in xs]

# step
Z = [ x <= 0 ? 0 : 10 for y in ys, x in xs ]
Plots.surface(X, Y, Z; color=:1, legend = false, opacity = 0.8, label="I(u)")

# linear
Z = [0.4*x for y in ys, x in xs]
Plots.surface!(X, Y, Z; color=:2, legend = false, opacity = 0.8, label="0.4u")

# quadratic
xs = [-2.; -1; 0; 1; 2]
ys = -2:0.2:2
X = [x for y in ys, x in xs]
Y = [y for y in ys, x in xs]
Z = [x*(y^2+0.3) for y in ys, x in xs]
Plots.surface!(X, Y, Z; color=:3, legend = false, opacity = 0.8, label="u(x² + 0.3)")


Plots.plot3d!(xlabel="u", ylabel="x", xlims=(-2,2), ylims=(-2,2), zlims=(-1,1))
Plots.plot!(camera=(10,10))