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

Functions and their methods are only really useful if we're able to store their results somewhere. And where do we do this? In variables!

To define a variable in Julia, like most other languages that I know of, the name is written relative to the equals sign `=` which translates to _assignment_ rather than _equals_ like it does in mathematics. For example, if we want to store the value `4` in a variable named `thing`, then we would do so by writing

```julia-repl
julia> thing = 4
4
```

This contrasts with

```julia-repl
julia> 4 = thing
ERROR: syntax: invalid assignment location "4"
```

which _should_ be allowed mathematically, but is not allowed syntactically.

Other than that, there is not much else to variables. They can be named whatever you like, other than Julia keywords like `function`, `for`, `if`, _etc._

The final piece I want to say, however, is that variables, like in Python, are just labels. They generally do not actually represent data; rather they _point_ to data. This is particularly meaningful for people coming to Julia from the world of C, C++, and Fortran, where variables represent actual data. This means that when variables are passed around, say to function methods as arguments, then it is **cheap** in Julia (as cheap as throwing around an integer).

This is identical to Python, but it contrasts with C and C++ in particular where variables are passed around and _copied_ into functions by default. Thus, in Julia there is nothing from stopping any function from modifying the underlying data _pointed to_ by any of its arguments at any time. Meanwhile, in C/C++, a function would be modifying the _copy_ of the underlying data rather than the original. There are exceptions to this rule in Julia, though: \newtablink{primitive types}{https://docs.julialang.org/en/v1/manual/types/#Primitive-Types} like `Int`s and `Float`s or immutable types cannot and will not be modified, _ever_. Any other variable representing more complicated types, like `Vector`s which are `mutable`, will never actually _be_ the values they point to, but will rather be just labels pointing to their values.

That is as much as I want to go into these details at this point. This is a tutorial after all! And too many initial details can always be overwhelming. But I did want to say just a bit so it's always in the back of your mind.

### Scopes

Before diving into the details about specific types and how to use them, we should first discuss \newtablink{scopes.}{https://docs.julialang.org/en/v1/manual/variables-and-scoping/} These _regions of code_ represent where particular variables can be accessed and used.

There are a few important scopes to keep in mind when just starting to code:

#### The Global Scope

Any variable written outside of `function`s, `struct`s, `let`s, `macro`s, `module`s, _etc._ , lives in the global scope and can be accessed by any other part of your code at any time (assuming what is requesting access knows that the variable has been defined before the call). All variables defined in the `REPL` are in the global scope. 

I want to emphasize early on that it is generally considered bad form to write functions that depend on global variables. This is because, as mentioned in [Variables](#variables), variables are only labels that represent data, but they themselves are **not** the underlying data. So the actual data pointed to by any global variable, and more importantly its `Type`, at any time can change. The Julia compiler cannot know in advance how to handle this, and it in turn writes pretty slow code to handle the task in the most generic way it can. This problem is avoided, however, if one defines a global variable `const`, for instance in a function that `exp`onentiates like in the following example
  
```julia:./global_variable_performance
const im_a_performant_global = 4

my_performant_function(x) = exp( x * im_a_performant_global )
```

which will be performant because we promised the compiler that the global `im_a_performant_global` will never change, so its `Type` never will either.

\codeinfo{
To see just how much slower non-`const` globals can be, we can use the `BenchmarkTools` package in the standard library to accurately measure the performance between the two cases. First, we must [`Pkg.add`](/pages/GettingStarted/pkg) it to our environment like

```julia-repl
(my_environment) pkg> add BenchmarkTools
```

and use it in our code like

```julia-repl
julia> using BenchmarkTools
```

Then we will use its `@btime` macro to help us test the performance.

We define a slow global

```julia:./global_variable_performance
im_not_a_performant_global = 4

my_slow_function(x) = exp( x * im_not_a_performant_global )
```

and then benchmark both when `y = 1.0`. In order to properly use this `macro`, we must _interpolate_ the variable `y` into our expression using the `$` symbol.

```julia:./global_variable_performance
using BenchmarkTools # hide
y = 1.0

@btime my_performant_function($y)
```

\codeshow{./global_variable_performance}

```julia:./global_variable_performance
@btime my_slow_function($y)
```

\codeshow{./global_variable_performance}

So, as we can see, the use of the `const` keyword improves the performance of global variables by almost an order of magnitude! Also, the `@btime` macro shows us the number of allocations made. In the performant case, there are zero, but in the slow case, there are several. This again shows the fact that the Julia compiler is writing generic code, and since the `typeof(im_not_a_performant_global)` can change, Julia makes slow heap allocations to be as general as possible.

The takeaway is that if you **need** to use a global and you **need** speed, use `const`s.
}

#### The Local Scope

Local scopes are created basically inside any type of \newtablink{code block}{https://docs.julialang.org/en/v1/manual/variables-and-scoping/#man-scope-table} in Julia. These scopes are wiped clean once they complete their lifecycle, and any variables defined inside them are completely inaccessible to parts of code outside of them. For example, the following snippet throws an error when we try to assign the local variable `x` to the global variable `y`:

```julia
function this_defines_a_local(z)
    x = z
    return nothing
end

zval = 42
this_defines_a_local(zval)

y = x  # Errors because x is undefined outside of the local scope
```

Unlike global scopes, the Julia compiler _loves_ local variables. This is because it knows in almost every case all the details about the variables' `Type` information. So it doesn't need to be weary of any surprises, and it can optimize as much as possible.

I want to point out that in the example above, the argument variable `z` is actually a _local_ even though `zval = 42` is passed into it. What happens in these cases, since variables are just labels, is that a local copy of the label is created which points to the same data in memory[^1]\label{local_scope_head}. Then that new local label is used to access the data. When the function ends, then the local label is destroyed, but not the data it points to!

There are some more technical details about local scopes that exist in Julia that I think are beyond the scope (😎) of this tutorial. For those interested, or for those unlucky enough to encounter a "soft-scope" error early on, I'll point you to \newtablink{documentation}{https://docs.julialang.org/en/v1/manual/variables-and-scoping/#Local-Scope} for more information.

This about covers what I think is the bare minimum to get started with writing Julia code. From here, we will talk about helpful built-in types and how to use them.

## Helpful built-in types

\NotEnoughTime

### Strings

### Arrays, Matrices, and Vectors

### Tuples

### Named-Tuples and Dictionaries

## User-defined types: structs

### Mutability

## Built-in macros

## Is Julia a statically-typed language?

## Footnotes

[^1]: In this specific case, since `zval = 42` is a variable pointing to a primitive type, the local copy of the label is as expensive as a local copy of the data, and so Julia does the latter. This is a technicality that breaks since the example is so simple. However, the broader point I was making about functions modifying local copies of labels, while maintaining access to the original underlying data holds. [Go Back](#local_scope_head)