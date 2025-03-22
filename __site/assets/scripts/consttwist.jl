using LinearAlgebra

# generate trajectory
v = 1.0
Ω = axang2rotm([0,0,1.], 1.)

R0 = I
p0 = zeros(3)

function axang2rotm(ω, θ)
    normalize!(ω)
    if θ == 0
        return diagm(ones(3))
    end
    K = [0. -ω[3] ω[2]; ω[3] 0 -ω[1]; -ω[2] ω[1] 0.]
    R = I + sin(θ)*K + (1 - cos(θ))*(K*K)
end