"""
    AbstractReactionDiffusionSystem{T<:AbstractFloat}
    
Supertype of all reaction diffusion systems.
"""
abstract type AbstractReactionDiffusionSystem{T} end

"""
    FastReactionSystem{T}  <: AbstractReactionDiffusionSystem{T}
    
Fast-Reaction system type. 
"""
struct FastReactionSystem{T}  <: AbstractReactionDiffusionSystem{T}
    Δ::AbstractLaplaceOperator        # Diffusion operator
    f::Function                       # first reaction term
    g::Function                       # second reaction term
    D_u::T                            # first diffusion term
    D_v::T                            # second diffusion term
    eps::T                            # multiscale parameter
end

@doc raw"""
      fastreactionsystem(Δ, f, g, D_u, D_v, eps) -> FastReactionSystem

A subtype of a reaction diffusion system. It is a system of the form
```math
\begin{aligned}
\partial_t u = D_u \Delta(u) + \varepsilon^{-1}f(u,v) \\
\partial_t v = D_v \Delta(v) + g(u,v)
\end{aligned}
```
"""
function fastreactionsystem(Δ, f, g, D_u, D_v, eps)
    return FastReactionSystem(Δ, f, g, D_u, D_v, eps)
end

function Base.show(io::IO, model::FastReactionSystem)
    println(io, @sprintf "Fast-Reaction-System")
end

"""
    (model::FastReactionSystem)(dS, S, N, t) -> nothing

Shorthand function used to solve fast-reaction system with inplace ODE solver.
"""
function (model::FastReactionSystem)(dS, S, N, t)
    u = S[1:N] 
    v = S[N+1:2*N] # split S into u and v 
    (; Δ, f, g , D_u, D_v, eps) = model
    dS .= [ D_u .* Δ(u) .+ f.(u,v)./eps;
           D_v .* Δ(v) .+ g.(u,v)     ] # stack u and v into S
    return nothing
end
