"""
    AbstractReactionDiffusionSystem{T<:AbstractFloat}
    
Supertype of all reaction diffusion systems.
"""
abstract type AbstractReactionDiffusionSystem{T<:AbstractFloat} end

"""
    FastReactionSystem{T}  <: AbstractReactionDiffusionSystem{T}
    
A subtype of a reaction diffusion system. A fast reaction system of the form

dt u = D_u*Δ(u) + f(u,v)/epsilon
dt v = D_v*Δ(v) + g(u,v)
"""
struct FastReactionSystem{T<:AbstractFloat}  <: AbstractReactionDiffusionSystem{T}
    Δ::AbstractLaplaceOperator        # Diffusion operator
    f::Function                       # first reaction term
    g::Function                       # second reaction term
    D_u::T                            # first diffusion term
    D_v::T                            # second diffusion term
    eps::T                            # multiscale parameter
end

"""
    fastreactionsystem(Δ, f, g, D_u, D_v, eps)

Creates fast reaction system.
"""
function fastreactionsystem(Δ, f, g, D_u, D_v, eps)
    return FastReactionSystem(Δ, f, g, D_u, D_v, eps)
end

"""
    function (model::FastReactionSystem)(dS, S, N, t)

Shorthand fuction used to solve system with ODE solver.
"""
function (model::FastReactionSystem)(dS, S, N, t)
    u = S[1:N] 
    v = S[N+1:2*N] # split S into u and v 
    (; Δ, f, g , D_u, D_v, eps) = model
    dS .= [ D_u .* Δ(u) .+ f.(u,v)./eps;
           D_v .* Δ(v) .+ g.(u,v)     ] # stack u and v into S
    return nothing
end