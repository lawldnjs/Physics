using Plots

const g = 9.81
const ρ = 1.225
const Cd = 0.47

const r = 0.037
const m = 0.145
const A = π * r^2

v0 = 30.0
θ = 45.0
θ_rad = deg2rad(θ)

x0, y0 = 0.0, 0.0
vx0 = v0 * cos(θ_rad)
vy0 = v0 * sin(θ_rad)

dt = 0.01
t_max = 10.0

x_data = [x0]
y_data = [y0]
vx, vy = vx0, vy0
x, y = x0, y0

for t in 0:dt:t_max
    global vx, vy, x, y

    if (t > 0) && (y <= 0)
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

max_height = maximum(y_data)
range = maximum(x_data)
flight_time = (length(x_data) - 1) * dt

println("Max Height = ", round(max_height), "m")
println("Flight Distance = ", round(range, digits=2), "m")
println("Flight Time = ", round(flight_time, digits=2), "s")

p = plot(x_data, y_data;
    xlabel="Distance",
    ylabel="Height",
    title="BaseBall Toosa",
    legend=false,
    aspect_ratio=:equal
)

savefig("baseball_toosa_graph.png")
println("Graph Image Saved")