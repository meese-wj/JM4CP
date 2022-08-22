@def title = "using Pkg"
@def tage = ["Pkg"]
@def hascode = true

# `Pkg`: Julia's Built-in Package Manager

\FirstPostedLastUpdated{July 30, 2022}

In this page, we will quickly and easily create a new project environment in Julia using its own package manger, named `Pkg`.

\toc

## Motivation

Since we're pretty early on in these tutorials at this point, I will hold off on a lot of detail as to why making a local project environment is preferred over maintaining a large global environment. But I'll give two reasons for now just to keep your interest:

1. Smaller local projects typically have fewer dependencies, and therefore updating those dependencies is faster and less prone to conflicts.
1. By leveraging `Pkg`, we can make our work extremely _portable_ across different machines. This means that I can send someone else my code and just a couple of small text files and _boom!_ they can recreate everything I had and completely _reproduce_ my work.

These two reasons actually make collaborating with Julia projects very simple and great for scientists. How many times have you tried downloading some code and it can't work out of the box? This method of local environments really helps reduce this risk by improving the _portability_ and _reproducibility_ of scientific projects written in Julia.

## How to fish for packages with `Pkg`

To access the `Pkg` from the Julia `REPL`, simply hit `]` and see that the `julia>` heading change to `pkg>`. Now, to create a new project environment, type `activate .` like so:

```julia-repl
(v1.7) pkg> activate .
```

This will change the `REPL` heading again from `pkg>` to `(fish) pkg>`, given a directory name `fish`. So now we should be looking at 

```julia-repl
(fish) pkg> 
```

If you hit `Backspace`, you leave `Pkg` mode and will see `julia>` again. In an empty `fish` directory, typing 

```julia-repl
julia> readdir()
```

should yield nothing. This is because our newly `activate`d `fish` project has no dependencies. So let's add a couple. Hit `]` to enter `Pkg` mode and type

```julia-repl
(fish) pkg> add Statistics StaticArrays
```

and hit `Enter`. This will download the supplied list of packages from Julia's [General Registry](https://github.com/JuliaRegistries/General) by default. In this case we asked for two packages. When it's done, hit `Backspace` to leave `Pkg` mode, and then type 

```julia-repl
julia> readdir()
```

again. Now, you should see two new files: `Project.toml` and `Manifest.toml`.

Congrats! You've now set up a new Julia project environment called `fish` that has two dependencies: `Statistics.jl` and `StaticArrays.jl`. At this point, you could continue to play around within this environment, add more packages, delete others, _etc._, without having your actions locally affect your global Julia environment[^1].

## The generated `TOML` files

Here I'll briefly discuss what these `TOML` files are and why Julia generated _two_ of them.

### The `Project.toml` file

This file is used to uniquely specify a new project environment and list all of the packages it depends on -- its _dependencies_. If this file already exists in a directory when one goes to `activate .` a new environment, the present `Project.toml` file will be used instead of creating a new one. So in this sense the local project environment is re-`activate`d.

### The `Manifest.toml` file

This file uniquely delineates not only the your new project environment's dependencies, but also all of the dependencies' dependencies, and so on. The power of this file comes from another `Pkg` command:

```julia-repl
(v1.7) pkg> instantiate .
```

which will not only pull the dependencies listed in the `Project.toml`, but also _all_ of the specific package versions of every package listed in the `Manifest.toml`. This file and `instantiate` command is what allows for portability and reproducibility of Julia projects because it allows _anybody_ to completely recreate the specific environment configuration that you used to run your code and get your specific results. 

Pretty cool, right?

### Why not just one `TOML` file?

If a lot of the power comes from the `Manifest.toml`, why not just use this one?

It turns out that because of the way the Julia team have designed their package managment system, people who actually write Julia packages rarely need to include their `Manifest.toml`. Indeed, actually when one writes a package, they typically want it to be used by as many people as possible, without limiting their use cases by constraining them to a specific configured environment. So they test their packages on servers without sending the `Manifest.toml`[^2], and let the test servers create their own local environments. If everything works out, then they can add their package to the General Registry, and we can download and use it in _our own_ environments.

Hooray for _code reuse_!

It is only when we need, say a collaborator, advisor, or TA, to reproduce our work that we absolutely _need_ to send the `Manifest.toml`. In that case, they would _want_ to be constrained by our specific local environment to obtain the same results we did.

Hooray for _reproducibility_ in science!

## Recap and further reading

At this point, we've covered the absolute basics as far as `using` Julia's `Pkg` manager to create local project environments. 

We created the `fish` environment with two dependencies, `Statistics.jl` and `StaticArrays.jl`, both of which we pulled from Julia's General Registry of packages. By adding these dependencies, we saw that `Pkg.jl` automatically generated a `Project.toml` and `Manifest.toml` in our project directory. We then discussed the differences between these files, and how the Julia team made it so that just these files make Julia code _reusable_, _portable_, and _reproducible_.

I've tip-toed around some other important details to avoid overwhelming you with so much information, especially if you're new, not just to Julia, but programming in general. For anyone interested in more information, you can find it at:

- [`Pkg.jl` documentation.](https://pkgdocs.julialang.org/v1/)
- [Details on the `Project.toml` and `Manifest.toml`.](https://pkgdocs.julialang.org/v1/toml-files/)

## Footnotes

[^1]: The global Julia environment is named `v1.7` for Julia versions `1.7.x`. To access it again from the `fish` environment, or any other, simply write ```julia-repl
(fish) pkg> activate
``` (emphasis on no `.` or other directory name following `activate`).

[^2]: Package authors _do_ have to send the `Project.toml` though.