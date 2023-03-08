"""
    AbstractLaPlaceOperator
    
    Supertype of all Laplace operators.
"""
abstract type AbstractLaplaceOperator end

"""
    Laplace2DPBC <: AbstractLaplaceOperator

Two dimensional Laplace operator with periodic boundary conditions implemented.  
"""
struct Laplace2DPBC <: AbstractLaplaceOperator
   L 
end 

"""
    Laplace2DDBC <: AbstractLaplaceOperator

Two dimensional Laplace operator with dirichlet boundary conditions implemented.   
"""
struct Laplace2DDBC <: AbstractLaplaceOperator
   L 
end 

"""
    laplace2dpbc(grid::AbstractGrid)

Initializes two dimensional Laplace operator with periodic boundary conditions on some grid.
"""
function laplace2dpbc(grid::AbstractGrid)
    n = grid.h_n
    N = grid.N
    h = grid.h_step
    
    L = diagm( 0 => -4*ones(N), 1 => ones(N-1), -1 => ones(N-1) )
    for i in 1:(n - 1) 
        L[i*n, i*n + 1] = 0
        L[i*n + 1, i*n] = 0
    end

    L += diagm( n => ones(N-n), -n => ones(N-n) )
    L += diagm( N-n => ones(n) )
    L += diagm( -N + n => ones(n) )
    
    for i in 1:n:N 
       L[i, i + (n-1)] = 1
       L[i + (n-1), i] = 1
    end 

    Laplace2DPBC( sparse(L./h^2) )
end

"""
    laplace2ddbc(grid::AbstractGrid)

Initializes two dimensional Laplace operator with dirichlet boundary conditions on some grid.
"""
function laplace2ddbc(grid::AbstractGrid)
    n = grid.h_n
    N = grid.N
    h = grid.h_step
   
    dbc = ones(Bool, n, n) 
    dbc[1,:] .= 0
    dbc[end,:] .= 0
    dbc[:,1] .= 0
    dbc[:,end] .= 0
    dbc = reshape(dbc,:)
    
    L = diagm( 0 => -4*ones(N), 1 => ones(N-1), -1 => ones(N-1))
    L += diagm( n => ones(N-n), -n => ones(N-n))
    
    L = dbc .* L

    Laplace2DDBC( sparse(L./h^2) )
end

"""
    Δ(x)

    Creates two dimensional Laplace operator with periodic boundary conditions as a function of x.
"""
(Δ::Laplace2DPBC)(x) = Δ.L * x

"""
    Δ(x)

    Creates two dimensional Laplace operator with dirichlet boundary conditions as a function of x.
"""
(Δ::Laplace2DDBC)(x) = Δ.L * x