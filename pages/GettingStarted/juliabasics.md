@def title = "Julia Basics"
@def hascode = true
@def tags = ["basics", "syntax", "usage"]

# Basic Julia Syntax and Usage

_Last Updated: August 6, 2022_

In this tutorial, we'll go over a few Julia basics. We will only need the Julia `REPL` for this tutorial, which you can open simply by starting Julia.

\note{
    On Windows, you can hit the `Windows` button on your keyboard to open the start menu and type `Julia` to find the executable. Alternatively, one can open the terminal and simply type `julia` on `*`nix systems, or `julia.exe` for Windows, into the command line.

    Either method will open an interactive command-line interface called the Julia `REPL` which stands for w`R`ite-`E`xecute-`P`rint-`L`oop.
}

The code that we will need to execute in the `REPL` will be outlined in code blocks with _solid_ borders like so:

```julia:./code_jb/helloworld
println("Hello World")
```

and the output of these code blocks will be shown in code blocks with _dashed_ borders as:

\output{./code_jb/helloworld}

## What's in this tutorial?

\toc

## Julia version

```julia:./code_jb/version
print(VERSION)
```

\output{./code_jb/version}

Just so we're all on the same page, this tutorial was tested with the following Julia version: \textoutput{./code_jb/version}.

## Numbers

Starting from a physics-oriented perspective, we probably are most inclined to see how numbers are used in Julia. The parent-type of all numbers is a `Number` whose subtypes are:

```julia:number_subtypes
subtypes(Number)
```

\show{number_subtypes}

\codeinfo{
    The `subtype` function is built into Julia and is used to identify hierarchical relationships between `DataType`s.

    Likewise, there is a `supertype` function that can be used to traverse the hierarchy in the other way as 

    ```julia:real_supertype
    supertype(Real)
    ```

    \show{real_supertype}
}

Applying this function again to each of `Number`'s subtypes, we find:

```julia:more_number_subtypes
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

Okay, going back to the subtypes. One can see from the output that there are _zero_ subtypes of a `Complex` `Number` in Julia[^1], but there are _four_ subtypes of `Real`s. There are `Integer`s and `Rational`s, as well as types that are called `AbstractFloat`s and `AbstractIrrational`s.

It turns out that all of these are still "abstract" in the sense that they do not have any particular representation in the computer. But, these begin to hint at the amount of numerical complexity that Julia built-in. It shows how the Julia team have made it a priority for Julia to stand out as a scientific language, and from personal experience it really speeds one's productivity to have such a rich numerical ecosystem available right out of the box. This is one of the reasons why Julia is so helpful as a scientific language.

[^1]: This is only true in the sense of what Julia considers a subtype for compilation purposes. I'll spare you the details for now, but there are indeed "conceptual subtypes" for `Complex` in the sense that one can have a complex number made out of integers or floating-point numbers. But because parametric types are \newtablink{invariant}{https://docs.julialang.org/en/v1/manual/types/#man-parametric-composite-types}, `Complex{Int64}` is **not** a subtype of `Complex{Real}`. This may seem pretty strange at first, but this choice was made for performance (and software development) reasons.
