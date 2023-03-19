@testset "REACTIONDIFFUSIONSYSTEMS.jl" begin
    @testset "fast-reaction system" begin

        x = -1:1
        grid = uniform2dgrid(x, x)
        Δ = laplace2dpbc(grid)
        f(u,v) = - u + v
        g(u,v) = u - v
        D_u = 1.0
        D_v = 2.0
        eps = 0.5
    	system = fastreactionsystem(Δ, f, g, D_u, D_v, eps)
        dS = [1:9;1:9]
	S = [1:9;1:9]
	system(dS, S, 9,nothing)
	@test dS == [12,
   9,
   6,
   3,
   0,
  -3,
  -6,
  -9,
 -12,
  24,
  18,
  12,
   6,
   0,
  -6,
 -12,
 -18,
 -24]
 
 
    end
 end
