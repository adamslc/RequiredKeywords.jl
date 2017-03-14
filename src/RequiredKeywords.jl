"""
Implements the `@required_keywords` macro which allows function definitions to have keyword
arguments without a default value. These keywords must always be specified. If they are not,
a `UnassignedKeyword` exception is thrown.
"""
module RequiredKeywords
    import Base: showerror
    export UnassignedKeyword, @required_keywords, @showexp

    """
    Indicated that a funtion has been called without specifying a keyword which has no default.
    """
    struct UnassignedKeyword <:Exception
        msg::String
    end

    Base.showerror(io::IO, e::UnassignedKeyword) = print(io, "Unassigned Keyword:  ", e.msg)

    """
        @required_keywords f(...; x::Int=0, y::Int) = ...

    Allows function definitions to have keyword arguments without a default value. These
    keywords must always be specified. If they are not, a `UnassignedKeyword` exception is thrown.
    """
    macro required_keywords(exp)
        # Check if exp is a function definition
        if exp.head == :function || (exp.head == :(=) && exp.args[1].head == :call)
            # Find the list of parameters in function
            paramListID = 0
            for (i, arg) in enumerate(exp.args[1].args)
                typeof(arg) == Symbol && continue
                arg.head != :parameters && continue

                paramListID = i
            end

            # Check each parameter, update if necessary
            for (i, param) in enumerate(exp.args[1].args[paramListID].args)
                if typeof(param) == Symbol || param.head == :(::)
                    msg = "Required keyword $param not included."
                    newParam = Expr(:kw, :($param), :( throw(UnassignedKeyword( $msg )) ))
                    exp.args[1].args[paramListID].args[i] = newParam
                end
            end
        else
            throw("@required_keywords can only be applied to a function.")
        end

        # Return modified function definition
        esc(:( $exp ))
    end

    macro showexp(exp)
        show(exp)
    end

end # module