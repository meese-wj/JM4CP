@def title = "Julia Basics II"
@def hascode = true

# The Programmatic Minimum

## What's in this tutorial?

\FirstPostedLastUpdated{August 9, 2022}

\toc

## Basic build blocks

In this section, we'll discuss the basics of how to get Julia code up and running.

### Functions & Methods

We start with the primary datatype in Julia: function methods. As described in the [previous tutorial](/pages/GettingStarted/juliabasics_part1), Julia revolves around `function`s which are **abstract**, and `methods` which are **concrete**. In other words, whenever one implements a particular `function` for a **specific** set of argument `Type`s, then it is referred to as a `method` of that `function`.

Method definitions are beautifully simple in Julia. For example, they can be written as

```julia:./ex_line
line(x, m, b) = m * x + b 
```

for a `function` `line` which computes the value of a line given some arguments. In this `method` definition, `line` takes in the arguments `(x, m, b)`.

In the `REPL`, go ahead and copy-and-paste `line` into the command line and hit `Enter`. You should see the following output:

\codeshow{./ex_line}

Here we see that `line` has one method. We can use that one method to do calculations, for example as

```julia:./ex_line
@show line(1, 2, 3)
```

\codeshow{./ex_line}

Now, let's add `::Vector` to the `x` argument and change up the definition a bit. (The `::` flag is how one can specify type information in Julia.)

```julia:./ex_line
line(x::Vector, m, b) = m .* x .+ b
```

Here, the `.` in front of the `*` and `+` operators _vectorize_ your code and simply mean "apply this operation to each element" and so it inherently implies the use of a loop over all elements of `x` for the multiplication first, and then again over all elements of the `Vector` `m .* x` for the addition. All it cost us is a replacement of `*` and `+` by `.*` and `.+`. Not too shabby! 

Now, let's check `methods` again to verify that our `line` was overwritten:

```julia:./ex_line
methods(line)
```

\codeshow{./ex_line}

As you can see, our original `line` method was not overwritten, but _overloaded_. Now this `line` has _two_ distinct methods, one where the `x` argument is a `Vector`, and one where it is not. By default, if no type information is supplied to the arguments, they are _inferred_ by Julia to be the type `Any` which is the supertype of all other types. So it literally could represent _anything_. 

So which method will be called in the following cases?

```julia:./ex_line
@show line(1, 2, 3)
@show line([1, 2, 3], 2, 3)
```

\codeshow{./ex_line}

(As will be talked about [later in this tutorial](#arrays_matrices_and_vectors), one can create a column in Julia `Vector` of type `Int` by writing `[1, 2, 3]`.) Notice how the first example returns the same result from before, whereas the second returns the column vector resulting from our `line` method with the `Vector` first argument.

What does this mean? It means that Julia is smart enough to call the appropriate method of a `function` for its supplied argument types. Furthermore, it shows that because methods with more specific argument types are preferred over those with more general argument types. Otherwise, the `m * x + b` method _should_ have been called (and subsequently then thrown an error) for our `Vector` argument rather than the correct `m .* x .+ b` one. Indeed, the ordered set of most specific type arguments of a method uniquely identify it. Therefore, methods will only be **overwritten** if **all** arguments are specified exactly the same way. Otherwise, Julia makes a new method for the new argument types, and then use its own \newtablink{multiple dispatch}{https://en.wikipedia.org/wiki/Multiple_dispatch?oldformat=true} system to choose the right one. Behold the power!

But, with great power comes great responsibility: sometimes we can accidentally creat what are called _method ambiguities_. For example, suppose we want the slopes `m` always to be of type `Float64`. We can do this by writing

```julia:./ex_line2
line(x, m::Float64, b) = m * x + b # hide
line(x::Vector, m, b) = m .* x .+ b # hide
line(x, m::Float64, b) = m .* x .+ b
```

Then, we call `methods` again and see

```julia:./ex_line2
methods(line)
```

\codeshow{./ex_line2}

meaning that we have successfully added a third method for `line`. Or have we? Because if we call `line([1, 2, 3], 2.0, 3)`, we now see an error:

```julia-repl
julia> line([1, 2], 2.0, 3)
ERROR: MethodError: line(::Vector{Int64}, ::Float64, ::Int64) is ambiguous.
```

As the rest of the error message shows, this is because Julia isn't sure whether to call the method that specializes the `x` argument from `Any` to `Vector`, or to call the method that specializes the `m` argument from `Any` to `Float64`. As Julia should suggest:

```julia-repl
Possible fix, define
  line(::Vector, ::Float64, ::Any)
```

So all we would need to do is define, yet another, method to tell Julia specifically what we need it to do:

```julia:./ex_line3
line(x, m::Float64, b) = m * x + b # hide
line(x::Vector, m, b) = m .* x .+ b # hide
line(x, m::Float64, b) = m .* x .+ b # hide
line(x::Vector, m::Float64, b) = m .* x .+ b

methods(line)
```

\codeshow{./ex_line3}

giving us four methods in total. Now by calling that last line that threw an error, we see that everything is fixed and we get the correct result.

```julia:./ex_line3
@show line([1, 2, 3], 2.0, 3)
```

\codeshow{./ex_line3}

That about wraps things up for functions. The last thing I want to point out is that there are actually a couple of more ways to create new functions. The first uses a `begin ... end` block allowing one to have multiple lines, like so

```julia
line(x, m, b) = begin
    result = m * x
    result += b
    return result
end
```

or one can use the `function ... end` block which is the more normal way to have multiple-line functions in Julia:

```julia
function line(x, m, b)
    result = m * x
    result += b
    return result
end
```

With either of these two methods (:wink:), one can then have arbitrarily many lines in functions as one then pleases. But, as is true for all programming, it is considered good practice to have very small functions that all do very specific things, then then to stitch them together to make more complicated code.

\codeinfo{
Notice that in these last multi-line function method definitions, that we used the keyword `return`. This is not necessary for
Julia, unlike languages like Python and C++. (In Python and C++, a lack of a return keyword implies the function returns `nothing` or is `void`, respectively.)
    
We could have just left the final lines as `result += b`, because this on its own returns `result`. Generally, Julia will return the output from the last line of any function, and so sometimes people would write the last example as:

```julia
function line(x, m, b)
    result = m * x
    result += b
end
```
    
I personally like to keep the `return` keyword there for two reasons. First, sometimes it isn't possible to write functions without them, as is the case with branching functions, _etc_. Secondly, I like verbose, readable code. I don't like having to out-smart the code. I prefer when it tells me _exactly_ what it is trying to do.
}

### Variables

To be continued...

### Scopes

## Helpful built-in types

### Strings

### Arrays, Matrices, and Vectors

### Tuples

### Named-Tuples and Dictionaries

## User-defined types: structs

### Mutability

## Built-in macros

## Is Julia a statically-typed language?