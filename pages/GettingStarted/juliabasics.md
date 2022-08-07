@def title = "Julia Basics"
@def hascode = true
@def tags = ["basics", "syntax", "usage"]

# Basic Julia Syntax and Usage

_Last Updated: August 6, 2022_

In this tutorial, we'll go over a few Julia basics. We will only need the Julia `REPL` for this tutorial, which you can open simply by starting Julia.

\note{
    On Windows, you can hit the `Windows` button on your keyboard to open the start menu and type `Julia` to find the executable. Alternatively, one can open the terminal and simply type `julia` on `*`nix systems, or `julia.exe` for Windows, into the command line.

    Either method will open an interactive command-line interface called the Julia `REPL` which stands for `R`ead-`E`valuate-`P`rint-`L`oop.
}

The code that we will need to execute in the `REPL` will be outlined in code blocks with _solid_ borders like so:

```julia:./code_jb/helloworld
println("Hello World")
```

and the output of these code blocks will be shown in code blocks with _dashed_ borders as:

\output{./code_jb/helloworld}

## What's in this tutorial?

This will be a bit of a different Julia tutorial, than those that cover simple syntax and basic types. These are special cases, and since we physicists like to generalize as much as possible _and only then_ specialize, we will apply the same techniques here.

First, I'll introduce you to the Julian way to conceptualize functions, methods, and types in the language while contrasting heavily against more standard languages like Python and C++. Then we'll discuss how, despite Julia being different from these more typically used languages in physics, the Julian way is a natural extension of how we normally understand relationships between different things. Then we'll show an example of the type system in practice with the `Number` type, and finally conclude by going over some of the details with concrete numerical examples.

\toc

As is usual, feel free to skip around, but fair warning this tutorial is covered somewhat sequentially.

## Julia version

```julia:./code_jb/version
print(VERSION)
```

\output{./code_jb/version}

Just so we're all on the same page, this tutorial was tested with the following Julia version: \textoutput{./code_jb/version}.

## All about `Type`s

Julia, unlike other programming languages used in physics like Python, Java, and C++, is **not** object-oriented (OO). In OO languages, the primary thing that is used by the programmer when writing software is the data object, usually called a _class_. This means that classes, and _class-structure_ ultimately control everything about the way the code is run, including which specific functions are called as the code executes. In this sense, data _owns_ functions in OO programming.

This is not the case for Julia. In Julia, _functions_ are primary, and no data can _own_ any function. The thing that differentiates how code executes is through function `methods` which may do different things depending on the `Type`s of arguments supplied to them.

This all may sound super abstract, but I promise, the concept is actually very similar to what you would've learned in elementary school with arithmetic. Take, for example, the _addition_ operation. In Julia, the function is named `+`, just like how we're used to. And for any two numbers $a$ and $b$, we know _conceptually_ what it means to add them as $a + b$. But how did we learn how to _compute_ it?

Well, for nonnegative integers, we basically increment $a$ by $1$ a total of $b$ times. For example,

$$
2 + 3 = 2 + 1 + 1 + 1 = 3 + 1 + 1 = 4 + 1 = 5.
$$

Then of course we were probably taught to memorize particular increments so that for $2 + 33$ we didn't have to do the above over and over again. Great! So that's (nonnegative) integer addition.

But what was the algorithm we learned for when we _couldn't_ increment by nice units of $1$? How, for instance, do we add $2$ and $3.5$, given that $2$ is an integer but $3.5$ is a decimal? Well, we `promote` $2$ to $2.0$ and write both as $2 + 0/10$ and $3 + 5/10$, and then sum the terms according to which power of $10$ appears as an overall multiplicative factor. For example,

$$
2 + 3.5 = 2 + \frac{0}{10} + 3 + \frac{5}{10} = (2 + 3) + \frac{1}{10} (0 + 5) = 5 + \frac{5}{10}.
$$

Then, finally, we write $5 + 5/10$ as $5.5$.

What is important to recognize here is that the specific `methods` of addition (`+`) used in the two examples _differ_ even though the `function`s are _conceptually equivalent_. 

The takeaway is that I would argue the way we already think about things is very similar to how the Julia language is built. We have these generic conceptual beasts called `function`s that are each supposed to do particular things. Then, we have to implement new `methods` for our `function`s whenever they have different argument `Type`s.

Because of this, all of the power of Julia's `function`s come from caring all about `Type`s[^1]. Indeed, in Julia one can develop hierarchical, or tree-like, relationships between different `Type`s to be even more expressive in code. This allows `function`s as concepts to be defined for `abstract` types and then specialized down the tree for _concrete_ types. Ultimately, we end up with very performant code written very similarly to how we, as scientists, would conceptualize the operations on paper!

As an example, we will first talk about `Number`s in this generic way.

## `Number`s: Oh the places you can go!

Starting from a physics-oriented perspective, we probably are most inclined to see how numbers are used in Julia. The parent-type of all numbers is a `Number` whose subtypes are:

```julia:number_subtypes
using InteractiveUtils
subtypes(Number)
```

\show{number_subtypes}

\codeinfo{
    The line `using InteractiveUtils` is the Julian way to load the `InteractiveUtils` module. This is only necessary to bring the `subtype` function into scope for scripts. If you're still in the `REPL`, there is no need to load it directly.
    
    The `subtype` function is built into Julia and is used to identify hierarchical relationships between `DataType`s.

    Likewise, there is a `supertype` function that can be used to traverse the hierarchy in the other way as 

    ```julia:real_supertype
    supertype(Real)
    ```

    \show{real_supertype}
}

Applying this function again to each of `Number`'s subtypes, we find:

```julia:more_number_subtypes
using InteractiveUtils # hide
for type in subtypes(Number)
    # First get the subtypes
    subs = subtypes(type)
    # Now iterate through them and print them nicely
    println("subtypes($type):")
    for sub in subs
        println("|--> $sub")
    end
    println()
end
```

\show{more_number_subtypes}

*Wait! I thought we were looking at numbers, but instead we're already at for-loops, string interpolation, and printing!*

Okay, I know I jumped the gun a little bit, but my reasons are twofold. 

Firstly, and most importantly, I wanted to show that for the most part, Julia syntax can be read almost like English, much like Python can. If you haven't tried just reading it left-to-right, give it a go. If it helps, there are a few spoilers to keep in mind:

1. Whitespace does not matter in Julia (unlike Python). Scoping ends at the `end` keyword.
1. The `#` character denotes a comment in Julia. Everything to the left of it is read as real code, but everything to the right of it is ignored.
1. The function `println` (pronounced _print line_) prints its arguments together on a new line.
1. The `$` character _interpolates_ values in Julia. So if a variable `x = 4`, then `"$x"` will become the string `"4"`.

Secondly, this was the simplest way I could think to show you just how many different possible `Number`s that come built-in with Julia.

Okay, going back to the subtypes. One can see from the output that there are _zero_ subtypes of a `Complex` `Number` in Julia[^2], but there are _four_ subtypes of `Real`s. There are `Integer`s and `Rational`s, as well as types that are called `AbstractFloat`s and `AbstractIrrational`s.

It turns out that all of these are still "abstract" in the sense that they do not have any particular representation in the computer. But, these begin to hint at the amount of numerical complexity that Julia built-in. It shows how the Julia team have made it a priority for Julia to stand out as a scientific language, and from personal experience it really speeds one's productivity to have such a rich numerical ecosystem available right out of the box. This is one of the reasons why Julia is so helpful as a scientific language.

We're not going to recurse all the way down `Number`'s type hierarchy (although you certainly can if you want to!). A helpful figure that shows this hierarchy though is given below

[![NumberTypeTree](https://i.stack.imgur.com/vWAiB.png)](https://stackoverflow.com/questions/66499573/what-does-the-type-graph-look-like-in-julia)

_Image originally from:_ [bkamins/The-Julia-Express](https://github.com/bkamins/The-Julia-Express).

## `Number`s: Give me something concrete!

Now that we've gone over `Number`s in the `abstract`, it would ultimately be pretty helpful to have some _concrete_ examples of their use.

First, let's check the type of `Number` that `1` is.

```julia:numbers_ex1
typeof(1)
```

\show{numbers_ex1}

On different systems, this type may change from `Int64` to `Int32` (though I doubt it for modern hardware). Both of these types are _concrete_, as opposed to the `Integer` type shown above which is `abstract`. The `32` or `64` refers to the number of bits used to store each integer, implying that it has a definite machine-code implementation, _unlike_ the abstract `Integer`.

So since we spent all that time discussing addition, let's add integers:

```julia:numbers_ex2
@show typeof.((2, 3)) 
@show 2 + 3
@show typeof(2 + 3)
```

\show{numbers_ex2}

So we see that by default, `2` and `3` are also `Int64`, and their sum `5` is too.

How about the other example? Adding `2` and `3.5`?

```julia:numbers_ex3
@show typeof.((2, 3.5)) 
@show 2 + 3.5
@show typeof(2 + 3.5)
```

\show{numbers_ex3}

What happened here? It looks like `typeof(3.5) == Float64`, then the sum `5.5` is also of that type. So what happened was Julia was smart enough to `convert` the `Int64` into a `Float64` and then add the two `Float64` values; just like we did above by hand!

How did it do it? There are two conversion functions that are extremely helpful: `convert` and `promote`. They work like this:

```julia:numbers_ex4
@show convert(Float64, 2)
@show promote(2, 3.5)
```

\show{numbers_ex4}

In the first case, `convert(type, value)` will convert the `value` into the `type`, provided that it's possible. In the second case, `promote(a, b)` will find out which of the two possible conversions supercedes the other for values `a` and `b`, and will return a pair/`Tuple` of values represented as that superceding type. In this case, integers always get turned into floats. Why? If we try to convert `3.5` into an `Int64` by typing it directly into the `REPL`, we get an error:

```julia-repl
julia> convert(Int64, 3.5)
ERROR: InexactError: Int64(3.5)
```

The reason for this error, as we know, is that a choice would have to be made about what do do with the decimal part of `3.5`. In other high-performance languages, like C and C++, we're free to do this `cast` without a warning. But in Julia it's prohibited for numerical safety reasons. Instead, we can use the `floor` function to remove the decimal part the way either of those languages would:

```julia:numbers_ex5
@show floor(3.5)
@show floor(Int64, 3.5)
```

\show{numbers_ex5}

The first case shows that by default, the `floor` function returns a type that is the same as that of its argument.  For the method where the first argument is a type, the `floor` function will do the conversion we ask, because there is no decimal part any longer. Note that there are also `ceil`ing and `round` functions available:

```julia:numbers_ex6
@show ceil(3.5)
@show ceil(Int64, 3.5)
@show round(3.5)
@show round(3.5; digits = 1)
@show round(Int64, 3.5)
```

\show{numbers_ex6}

\codeinfo{
    Notice that in `round(3.5; digits = 1)` there is a semicolon `;` instead of a comma `,` separating arguments. This is Julia's convention for writing keyword arguments in functions. 
    
    All non-keyword arguments come first, separated by commas, then a semicolon appears, and then all keyword arguments follow, each also separated by commas.
}

To conclude, let's do something cool. Let's add a real number with a complex number and then take the square modulus (like something we might do for \newtablink{scattering probabilities in the Born approximation}{https://en.wikipedia.org/wiki/Born_approximation?oldformat=true#Born_approximation_to_the_Lippmann%E2%80%93Schwinger_equation}):

```julia:numbers_ex7
z = 1.0 + 1.0im
r = 1
res = r + z

@show z
@show r
@show res
@show typeof(res)
@show abs(res)^2
```

\show{numbers_ex7}

In the above `abs` is the absolute value function -- notice how it works for types of `ComplexF64`, the parametric type `Complex{Float64}` -- and the carat operator `^` is the exponentiation function. 

Interestingly, there is some floating-point error apparent in the answer due to the order of operations between `abs` and `^2`. If we switch them, the error vanishes:

```julia:numbers_ex8
z = 1.0 + 1.0im
r = 1
res = r + z

@show abs(res^2)
```

\show{numbers_ex8}

and we get the expected result. As a word of warning, for those of you who don't know computers can _lie_, just like Julia did here. We know analytically that the order of operations should not matter between `abs` and `^2` (see the note below for proof), but in a computer, the situation is different due to the finite-precision of a floating-point number, _i.e._ rounding error.

\codeinfo{
    You may have caught on to the `@show` macro at this point. It is a _macro_, not a _function_, which means it has the ability of writing Julia code, whereas functions do not[^3]. The `@` sign differentiates a `macro` from a `function` at a call-site within code.

    The `@show` macro essentially takes whatever follows, prints it verbatim with an equals sign, and then prints the result. So it's very convenient, but we could've used 

    ```julia
    println("abs(res ^ 2) = $res")
    ```

    instead. (But one can imagine, or maybe has experienced, how annoying this can get with different expressions over and over!)
}

\note{
    Here we show that $\vert w\vert^2 = \left\vert w^2 \right\vert$. Consider any nonzero complex number $w = R{\rm e}^{i\theta}$. Then, we have

    $$
    \vert w\vert^2 = \left( \sqrt{R^2 {\rm e}^{i\theta}{\rm e}^{-i\theta} } \right)^2 = R^2,
    $$

    and

    $$
    \left\vert w^2 \right\vert = \left\vert R^2 {\rm e}^{2i\theta} \right\vert = \sqrt{ R^4 {\rm e}^{2i\theta}{\rm e}^{-2i\theta} } = R^2.
    $$

    (Of course, this $\vert w\vert^2 = \left\vert w^2 \right\vert$ when $w = 0$, too, but in this case we can't define the phase $\theta$, so the proof above fails. :wink:) 
}

## Conclusions

In this tutorial, we took the time to understand Julia from its very basics, with talking how functions are primary and Julia distinguishes function `methods` by argument `Type`s.

We saw how this conceptual framework is very natural and commensurate to how we, as people, normally associate functions and arguments.

We then saw how it is put into practice with the `Number` `abstract` type, and then saw an example of the tree-like structure that follows naturally from type relationships in Julia.

Finally, we made use of concrete implementations of those `abstract` `Number` types, learned about type conversions and got to see some neat mathematical functions in action. Furthermore, we got a taste for how mathematical functions may behave differently in a computer, even for simple examples such as taking the square-modulus of a complex number.

This tutorial, despite not going over _all_ basic types in Julia, sets us up to better understand how the Julia language works, and gives us the feel for some syntax. Now, we'll be able to move on to more complicated examples with the foundation we've built.

## Footnotes

[^1]: For the sake of completeness, I want to emphasize that in the OO world, it's not like integer and decimal addition somehow are executed as the same machine code. This implication came from the elementary example of `function`s and `methods`, the main conclusion generalizes well to user-defined `Type`s. In OO languages, it might generalize too all arguments of a function other than the first which is typically a self-reference to the object calling the function.

[^2]: This is only true in the sense of what Julia considers a subtype for compilation purposes. I'll spare you the details for now, but there are indeed "conceptual subtypes" for `Complex` in the sense that one can have a complex number made out of integers or floating-point numbers. But because parametric types are \newtablink{invariant}{https://docs.julialang.org/en/v1/manual/types/#man-parametric-composite-types}, `Complex{Int64}` is **not** a subtype of `Complex{Real}`, even though `Int64` is a subtype of `Real`. This may seem pretty strange at first, but this choice was made for performance (and software development) reasons.

[^3]: Technically speaking, I'm actually just wrong here. It's a little white lie that, at this point, hopefully you'll forgive. Functions in Julia _can_ and _do_ write Julia code. This is called \newtablink{<em>metaprogramming</em>}{https://docs.julialang.org/en/v1/manual/metaprogramming/} and makes the Julia language very powerful. Without going too crazy, symbolic code expressions are data types in Julia that can be manipulated just like `Number`s. One usually writes functions that do this manipulation, and then encapsulates them within a macro to tell the Julia compiler to evaluate it, construct the new code expressions, and then evaluate it in place.
