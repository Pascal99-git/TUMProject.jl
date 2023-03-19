@testset "LIMITSYSTEMS.jl" begin
    @testset "fast-reaction limit system" begin

     	x = -1:1
        grid = uniform2dgrid(x, x)
        op = laplace2dpbc(grid)
        h(v) = v
        g(u,v) = u - v
        D_v = 2.0
    	limitsystem = fastreactionlimitsystem(op, h, g, D_v)
   	dS = [1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0]
	S = [1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0]
	limitsystem(dS, S, 9 ,nothing)
	@test dS == [ 24.0,
  18.0,
  12.0,
   6.0,
   0.0,
  -6.0,
 -12.0,
 -18.0,
 -24.0]
 
    end
 end
