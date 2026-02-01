using Plots

function get_slope(f, x, h=1e-5)
    return (f(x + h) - f(x - h)) / (2h)
end

function find_min(f, x0, α, n_iter, tol=1e-6)
    x = x0
    x_history = [x]
    f_history = [f(x)]
    
    for i in 1:n_iter
        slope = get_slope(f, x)
        x_new = x - α * slope

        if abs(x_new - x) < tol
            println("Converged at step ", i)
            x = x_new
            push!(x_history, x)
            push!(f_history, f(x))
            break
        end

        x = x_new
        push!(x_history, x)
        push!(f_history, f(x))

        #println("Step ", i, ": x = ", x, ", f(x) = ", f(x))
    end

    return x, x_history, f_history
end
