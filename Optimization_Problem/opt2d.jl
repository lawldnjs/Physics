using Plots

function get_grad(f, x, y, h=1e-5)
    df_dx = (f(x + h, y) - f(x - h, y)) / (2h)
    df_dy = (f(x, y + h) - f(x, y - h)) / (2h)

    return df_dx, df_dy
end

function go_down(f, x0, y0, α, n_iter, tol=1e-6)
    x, y = x0, y0

    x_hist = [x]
    y_hist = [y]
    f_hist = [f(x, y)]

    for i in 1:n_iter
        gx, gy = get_grad(f, x, y)

        x_new = x - α * gx
        y_new = y - α * gy

        dist = sqrt((x_new - x)^2 + (y_new - y)^2)

        if dist < tol
            println("Converged at step ", i)
            x, y = x_new, y_new
            push!(x_hist, x)
            push!(y_hist, y)
            push!(f_hist, f(x, y))
            break
        end

        x, y = x_new, y_new
        push!(x_hist, x)
        push!(y_hist, y)
        push!(f_hist, f(x, y))
    end

    return x, y, x_hist, y_hist, f_hist
end

function go_down_momentum(f, x0, y0, α, β, n_iter, tol=1e-6)
    x, y = x0, y0
    vx, vy = 0.0, 0.0

    x_hist = [x]
    y_hist = [y]
    f_hist = [f(x, y)]

    for i in 1:n_iter
        gx, gy = get_grad(f, x, y)

        vx = β * vx - α * gx
        vy = β * vy - α * gy

        x_new = x + vx
        y_new = y + vy

        dist = sqrt((x_new - x)^2 + (y_new - y)^2)
        
        if dist < tol
            println("Converged at step ", i)
            x, y = x_new, y_new
            push!(x_hist, x)
            push!(y_hist, y)
            push!(f_hist, f(x, y))
            break
        end

        x, y = x_new, y_new
        push!(x_hist, x)
        push!(y_hist, y)
        push!(f_hist, f(x, y))
        
        if i % 1000 == 0
            println("Step ", i, ": f = ", f(x, y))
        end
    end

    return x, y, x_hist, y_hist, f_hist
end


