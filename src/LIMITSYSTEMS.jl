"""
    AbstractLimitSystem{T<:AbstractFloat}
    
Supertype of all limit systems.
"""
abstract type AbstractLimitSystem{T<:AbstractFloat} end

"""
    FastReactionLimitSystem{T}  <: AbstractLimitSystem{T}
    
A subtype of a limit system corresponding to a fast-reaction system.
"""
struct FastReactionLimitSystem{L<:AbstractLaplaceOperator , T<:AbstractFloat}  <: AbstractLimitSystem{T}
    Δ::L                              # Diffusion operator
    h::Function                       # f=0 solved for u
    g::Function                       # second reaction term
    D_v::T                            # second diffusion term
end

@doc raw"""
      fastreactionlimitsystem(Δ, h, g, D_v) -> FastReactionLimitSystem

The limit system of a fast-reaction equation. It is a system of the form
```math
\begin{aligned}
0 = f(u,v) \\
\partial_t v = D_v \Delta(v) + g(h(v),v)
\end{aligned}
```
In this form it is assumed that one can solve f=0 for u = h(v), so that the system is only depending on v.
"""
function fastreactionlimitsystem(Δ, h, g, D_v)
    return FastReactionLimitSystem(Δ, h, g, D_v)
end

function Base.show(io::IO, model::FastReactionLimitSystem)
    println(io, @sprintf "Limit System of Fast-Reaction-System")
end

"""
    (model::FastReactionLimitSystem)(dS, S, N, t)

Shorthand function used to solve system inplace.
"""
function (model::FastReactionLimitSystem)(dS, S, N, t)
    v = S 
    (; Δ, h, g , D_v) = model
    dS .= D_v .* Δ(v) .+ g.(h.(v),v) 
    return nothing
end

#"""
#    FastReactionLimitSystemVersion2{T}  <: AbstractLimitSystem{T}
#    
#A subtype of a limit system. Algebraic Differential system of the form
#
#0 =  f(u,v)
#dt v = D_v*Δ(v) + g(u,v)
#"""
#struct FastReactionLimitSystemVersion2{T}  <: AbstractLimitSystem{T}
#    Δ::AbstractLaplaceOperator        # Diffusion operator
#    f::Function                       # first reaction term
#    g::Function                       # second reaction term
#    D_v::T                            # second diffusion term
#end
#
#"""
#    fastreactionlimitsystem2(Δ, f, g, D_v)
#
#Creates fast reaction limit system type
#"""
#function fastreactionlimitsystem2(Δ, f, g, D_v)
#    return FastReactionLimitSystemVersion2(Δ, f, g, D_v)
#end
#
#"""
#    (model::FastReactionLimitSystem)(out, dS, S, N, t)
#
#Shorthand function used to solve system with Algebraic Differential solver.
#"""
#function (model::FastReactionLimitSystemVersion2)(out, dS, S, N, t)
#    u .= S[1:N]
#    v .= S[N+1:2*N]
#    (; Δ, f, g , D_v) = model
#    out[1:N] .= f.(u, v)
#    out[N+1:2*N] .=  D_v .* Δ(v) .+ g.(u,v) .- dS[N+1:2*N] 
#    return nothing
#end
