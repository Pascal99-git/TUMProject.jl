@testset "GRIDS.jl" begin
    @testset "Uniform grid" begin

        r = 3
        x = -r:r
        grid = uniform2dgrid(x, x)
        @test grid.N == 49
        @test grid.h_n == 7
	@test grid.h_axis[2] == -2
    end
 end
