module MyPkg

# __precompile__(false)

using TaylorIntegration

macro taylorize_mypkg(ex)
    nex = TaylorIntegration._make_parsed_jetcoeffs(ex)
    return quote
        $(esc(ex))
        $(esc(nex))
    end
end

x0 = [1.0, 0.0]
tT = Taylor1(5)
x0T = Taylor1.(x0, tT.order)
dx0T = similar(x0T)
ω = 1.0

@taylorize_mypkg function harm_osc!(dx, x, p, t)
    local ω = p[1]
    local ω2 = ω^2
    dx[1] = x[2]
    dx[2] = - (ω2 * x[1])
    return nothing
end

greet2() = TaylorIntegration.jetcoeffs!(Val(harm_osc!), tT, x0T, dx0T, ω)
greet2(f) = TaylorIntegration._determine_parsing!(true, f, tT, x0T, dx0T, ω)

end # module
