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

## Numbers and strings

Starting from a physics-oriented perspective, we probably are most inclined to see how numbers are used in Julia. The parent-type of all numbers is a `Number` whose subtypes are:

```julia:number_subtypes
subtypes(Number)
```

\show{number_subtypes}

\codeinfo{
    Hi
}
