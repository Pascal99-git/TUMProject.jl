using TUMProject
using Test

@testset verbose = true "TUMProject.jl" begin
    include("GRIDS.jl")
    include("LAPLACEOPERATORS.jl") 
    include("REACTIONDIFFUSIONSYSTEMS.jl")
    include("LIMITSYSTEMS.jl")
end
