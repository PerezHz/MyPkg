module MyPkg

# __precompile__(false)

using TaylorIntegration

# greet() = print("Hello World!")

@taylorize xdot2(x, p, t) = (local b2 = 3; b2-x^2)

end # module
