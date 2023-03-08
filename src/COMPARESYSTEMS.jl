@doc raw"""
    plotinitialconditions(x::AbstractArray, y::AbstractArray, x_name::String, y_name::String)

Plots two initial condtions as heatmaps next to each other.
"""
function plotinitialconditions(x::AbstractArray, y::AbstractArray, x_name::String, y_name::String)
    plotx = heatmap(x, title= x_name);
    ploty = heatmap(y, title= y_name);
    return plot(plotx, ploty, layout = (1, 2), size = (1000, 400))
end



@doc raw"""
    animatesystem(x::Function, y::Function, x_name::String, y_name::String, ts::AbstractArray, limit::AbstractArray, name::String)

Creates an gif-animation of time dependent variables plottet as heatmaps next to each other.
"""
function animatesystem(x::Function, y::Function, x_name::String, y_name::String, ts::AbstractArray, limit::AbstractArray, name::String, fps::AbstractFloat)
    animation = @animate for t in ts
    plotx = heatmap( x(t), clim = (limit[1], limit[2] ), title = x_name);
    ploty = heatmap( y(t), clim = (limit[1], limit[2] ), title = y_name);
    plot(plotx, ploty, layout = (1, 2), size = (1000, 400))
    end
    return gif(animation, name*".gif", fps=fps)
end



@doc raw"""
    plotcomparenorms(sol::Function, limitsol::Function, sol2::Function, limitsol2::Function, p::AbstractFloat, ts::AbstractArray, figlabel::String, figlabel2::String)

Plots difference of L_p norms of time dependnt variables in time. 
"""
function plotcomparenorms(sol::Function, limitsol::Function, sol2::Function, limitsol2::Function, p::AbstractFloat, ts::AbstractArray, figlabel::String, figlabel2::String)
    l = length(ts)
    diff = zeros(l)
    diff2 = zeros(l)
    for i in 1:l
        t = ts[i]
        diff[i] = norm( sol(t) - limitsol(t) , p)
        diff2[i] = norm( sol2(t) - limitsol2(t) , p)
    end
    fig = plot(ts, diff, label = figlabel, title = "L2-Norm Comparison")
    fig = plot!(ts, diff2, label = figlabel2, title = "L2-Norm Comparison")
    return fig
end 
