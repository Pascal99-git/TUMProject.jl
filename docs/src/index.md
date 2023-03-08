# TUMProject.jl Documentation

## Grids
```@docs
TUMProject.AbstractGrid
TUMProject.Uniform2DGrid
TUMProject.uniform2dgrid(h,v)
```

## Laplace Operators
```@docs
TUMProject.AbstractLaplaceOperator
TUMProject.Laplace2DPBC
TUMProject.laplace2dpbc(g)
TUMProject.laplace2dpbc(x)
TUMProject.Laplace2DDBC
TUMProject.laplace2ddbc(g)
TUMProject.laplace2ddbc(x)
```

## Reaction Diffusion Systems
```@docs
TUMProject.AbstractReactionDiffusionSystem
TUMProject.FastReactionSystem
TUMProject.fastreactionsystem(Δ, f, g, D_u, D_v, eps)
TUMProject.fastreactionsystem(dS, S, N, t)
```

## Limit Systems
```@docs
TUMProject.AbstractLimitSystem
TUMProject.FastReactionLimitSystem
TUMProject.fastreactionlimitsystem(Δ, h, g, D_v)
TUMProject.fastreactionlimitsystem(dS, S, N, t)
```

## Comparing
```@docs
TUMProject.plotinitialconditions(x, y, x_name, y_name)
TUMProject.animatesystem(x, y, x_name, y_name, ts, limit, name, fps)
TUMProject.plotcomparenorms(sol, limitsol, sol2, limitsol2, p, ts, figlabel, figlabel2)
