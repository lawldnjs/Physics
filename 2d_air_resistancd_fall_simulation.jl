using Plots
gr()

const g = 9.81
const ρ = 1.225
const Cd = 0.47
const m = 0.1
const A = 0.01

x0, y0 = 0.0, 100.0
vx0, vy0 = 10.0, 0.0

dt = 0.01
t_max = 10.0

x_data = [x0]
y_data = [y0]
vx, vy = vx0, vy0
x, y = x0, y0

for t in 0:dt:t_max
    global vx, vy, x, y

    if y <= 0
        break
    end

    v = sqrt(vx^2 + vy^2)

    Fd = 0.5 * ρ * Cd * A * v^2

    if v > 0
       Fdx = -Fd * (vx / v)
       Fdy = -Fd * (vy / v)
    else
        Fdx, Fdy = 0.0, 0.0
    end

    ax = Fdx / m
    ay = (Fdy - m * g) / m

    vx += ax * dt
    vy += ay * dt

    x += vx * dt
    y += vy * dt

    push!(x_data, x)
    push!(y_data, y)
end

p = plot(x_data, y_data, xlabel="x", ylabel="y")
savefig("graph.png")
