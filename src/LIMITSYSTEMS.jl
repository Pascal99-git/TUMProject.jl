"""
    AbstractLimitSystem{T<:AbstractFloat}
    
Supertype of all limit systems.
"""
abstract type AbstractLimitSystem{T<:AbstractFloat} end

"""
    FastReactionLimitSystem{T}  <: AbstractLimitSystem{T}
    
A subtype of a limit system. Algebraic Differential system of the form

0 =  f(h(v),v)
dt v = D_v*Δ(v) + g(h(v),v)
"""
struct FastReactionLimitSystem{T}  <: AbstractLimitSystem{T}
    Δ::AbstractLaplaceOperator        # Diffusion operator
    h::Function                       # f solved for u
    g::Function                       # second reaction term
    D_v::T                            # second diffusion term
end

"""
    fastreactionlimitsystem(Δ, h, g, D_v)

Creates fast reaction limit system type
"""
function fastreactionlimitsystem(Δ, h, g, D_v)
    return FastReactionLimitSystem(Δ, h, g, D_v)
end

"""
    (model::FastReactionLimitSystem)(dS, S, N, t)

Shorthand fuction used to solve system.
"""
function (model::FastReactionLimitSystem)(dS, S, N, t)
    v = S 
    (; Δ, h, g , D_v) = model
    dS .= D_v .* Δ(v) .+ g.(h.(v),v) 
    return nothing
end

"""
    FastReactionLimitSystemVersion2{T}  <: AbstractLimitSystem{T}
    
A subtype of a limit system. Algebraic Differential system of the form

0 =  f(u,v)
dt v = D_v*Δ(v) + g(u,v)
"""
struct FastReactionLimitSystemVersion2{T}  <: AbstractLimitSystem{T}
    Δ::AbstractLaplaceOperator        # Diffusion operator
    f::Function                       # first reaction term
    g::Function                       # second reaction term
    D_v::T                            # second diffusion term
end

"""
    fastreactionlimitsystem2(Δ, f, g, D_v)

Creates fast reaction limit system type
"""
function fastreactionlimitsystem2(Δ, f, g, D_v)
    return FastReactionLimitSystemVersion2(Δ, f, g, D_v)
end

"""
    (model::FastReactionLimitSystem)(out, dS, S, N, t)

Shorthand fuction used to solve system with Algebraic Differential solver.
"""
function (model::FastReactionLimitSystemVersion2)(out, dS, S, N, t)
    u .= S[1:N]
    v .= S[N+1:2*N]
    (; Δ, f, g , D_v) = model
    out[1:N] .= f.(u, v)
    out[N+1:2*N] .=  D_v .* Δ(v) .+ g.(u,v) .- dS[N+1:2*N] 
    return nothing
end