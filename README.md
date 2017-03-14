# RequiredKeywords

This package allows you to specify required keyword arguments.

# Usage
```julia
julia> using RequiredKeywords

julia> @required_keywords f(x; y::Int64) = x*y
f (generic function with 1 method)

julia> f(2,y=2)
4

julia> f(2)
ERROR: Unassigned Keyword:  Required keyword y::Int64 not included.
Stacktrace:
 [1] f(::Int64) at ./REPL[5]:1
```

[![Build Status](https://travis-ci.org/adamslc/RequiredKeywords.jl.svg?branch=master)](https://travis-ci.org/adamslc/RequiredKeywords.jl)

[![Coverage Status](https://coveralls.io/repos/adamslc/RequiredKeywords.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/adamslc/RequiredKeywords.jl?branch=master)

[![codecov.io](http://codecov.io/github/adamslc/RequiredKeywords.jl/coverage.svg?branch=master)](http://codecov.io/github/adamslc/RequiredKeywords.jl?branch=master)
