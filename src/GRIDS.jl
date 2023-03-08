"""
    AbstractGrid
    
    Supertype of all grids.
"""

abstract type AbstractGrid end

"""
    Uniform2DGrid <: AbstractGrid
    
    A subtype of grid. Quadratic grid with equidistant points.
"""

struct Uniform2DGrid <: AbstractGrid
    h_axis  # horizontal axis
    v_axis  # vertical axis
    h_n     # total number of of points horizontally
    v_n     # total number of points vertically
    h_step  # horizonatal space step
    v_step  # vertical space step
    h_grid 	# horizontal grid
    v_grid  # vertical grid
    N       # total number of grid points horizontally 
end 

"""
    uniform2dgrid(h_axis::AbstractRange, v_axis::AbstractRange)

    Creates uniform grid using discrete uniform horzontal and vertical axis.
"""

function uniform2dgrid(h_axis::AbstractRange, v_axis::AbstractRange)
    h_n = length(h_axis)
    v_n = length(v_axis)
    @assert h_n == v_n
    @assert h_n > 1 && v_n > 1
    h_step = h_axis[2] - h_axis[1]
    v_step = v_axis[2] - v_axis[1]
    h_grid = ones(h_n) * h_axis'
    v_grid = v_axis * ones(v_n)'
    N = h_n * v_n 
    Uniform2DGrid(h_axis, v_axis, h_n, v_n, h_step, v_step, h_grid, v_grid, N)   
end