module TUMProject
    
    using LinearAlgebra, SparseArrays, Plots    # use packages

    #user's functions
    export uniform2dgrid,  
           laplace2dpbc, 
           laplace2ddbc, 
           fastreactionsystem, 
           fastreactionlimitsystem, 
           fastreactionlimitsystem2, 
           plotinitialconditions, 
           animatesystem, 
           plotcomparenorms
    
    include("GRIDS.jl") # include grids
    include("LAPLACEOPERATORS.jl") # include Laplace operators
    include("REACTIONDIFFUSIONSYSTEMS.jl") # include reactions diffusion systems
    include("LIMITSYSTEMS.jl") # include limit systems
    include("COMPARESYSTEMS.jl") # include compare systems

end