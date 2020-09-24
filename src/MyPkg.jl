module MyPkg

# __precompile__(false)

using TaylorIntegration

b1 = 3.0

x0 = [1.0, 0.0]
tT = Taylor1(5)
x0T = Taylor1.(x0, tT.order)
dx0T = similar(x0T)
ω = 1.0

y0T = Taylor1(1.0, tT.order)

ex = :(xdot1(x, p, t) = b1-x^2)

ex2 = :(function harm_osc!(dx, x, p, t)
local ω = p[1]
local ω2 = ω^2
dx[1] = x[2]
dx[2] = - (ω2 * x[1])
return nothing
end)

nex = TaylorIntegration._make_parsed_jetcoeffs(ex)
nex2 = TaylorIntegration._make_parsed_jetcoeffs(ex2)

@eval $ex
# @eval $nex
@eval $ex2
@eval $nex2

# greet() = TaylorIntegration.jetcoeffs!(Val(xdot1), tT, y0T, nothing)
# greet(f) = TaylorIntegration._determine_parsing!(true, f, tT, y0T, nothing)
greet2() = TaylorIntegration.jetcoeffs!(Val(harm_osc!), tT, x0T, dx0T, ω)
greet2(f) = TaylorIntegration._determine_parsing!(true, f, tT, x0T, dx0T, ω)

end # module
