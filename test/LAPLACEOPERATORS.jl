@testset "LAPLACEOPERATORS.jl" begin
    @testset "periodic boundary condtion" begin

        x = -2:2
        grid = uniform2dgrid(x, x)
        operator = laplace2dpbc(grid)
        @test operator(1:25)) == [30.0,
  25.0,
  25.0,
  25.0,
  20.0,
   5.0,
   0.0,
   0.0,
   0.0,
  -5.0,
   5.0,
   0.0,
   0.0,
   0.0,
  -5.0,
   5.0,
   0.0,
   0.0,
   0.0,
  -5.0,
 -20.0,
 -25.0,
 -25.0,
 -25.0,
 -30.0]
        
    end
 end
