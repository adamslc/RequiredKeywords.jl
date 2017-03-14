using RequiredKeywords
using Base.Test

# Assignment form
@required_keywords f(a; x, y::Int, z::Int=2) = a * x * y * z

@test f(2, x=2, y=2,z=2) == 16
@test f(2, x=2, y=2) == 16
@test_throws UnassignedKeyword f(2, x=2)
@test_throws TypeError f(2, x=2, y=2.0)

# Standard form
@required_keywords function g(a; x, y::Int, z::Int=2)
    a * x * y * z
end

@test g(2, x=2, y=2,z=2) == 16
@test g(2, x=2, y=2) == 16
@test_throws UnassignedKeyword g(2, x=2)
@test_throws TypeError g(2, x=2, y=2.0)