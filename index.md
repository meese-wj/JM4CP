@def title = "Julian Methods for Computational Physics"
@def tags = ["syntax", "code"]

# Assorted Notes from a Self-Taught Julia Enthusiast

\toc

## Summary Overview

~~~
<em>Last Updated: {{fill fd_mtime}}</em>
~~~

Computers are a powerful tool for physics. When physics students learn how to use them to help solve problems, they may appeal to legacy examples in high-level languages like Python and MATLAB, especially if they don't have any prior programming experience. If they do, or maybe if they happen to be pretty brave, they may jump into something like Java, or low-level languages like Fortran, C, or C++.

The higher-level languages are usually pretty attractive because they're simpler to write code in than the lower-level ones, again especially for students with little programming experience. But the tradeoff is that they are normally _slow_ (cough-cough Python), so any time the student wants to build a big project and really push the boundaries of simulated science, they fail to get the job done. We then normally hold our noses and go for the lower-level languages, become initially enamored with their speed and eventually frustrated with their complexity (looking at you, C++). Most of us who do heavy-duty simulations on supercomputing clusters then have to worry about portability of libraries, environments, and other nauseating nuances that all distract from the thing we actually wanted to study: _physics_.

The Julia programming language is an attempt to reduce this overhead for programmers, especially those of us with no formal computer science training. It strives to be as simple as a high-level language while keeping pace with the low-level ones. It's made to be used _interactively_ like Python or MATLAB while reaching the speeds of a _compiled_ language like Fortran or C. It really is quite a stunning tool that I personally think _all_ physicists's should learn.

The downside?

Julia is _young_. So it does not have nearly as much documentation and help as a language like Python (even though it really does have quite a bit).

Julia is _different_. Most project design patterns physicists learn are either how to write scripts that can't be maintained in the long-run, or how to write code bases according the the _Object-Oriented Programming_ paradigm. Julia can be scripty, but it is certainly not an object-oriented language. So for most of us, the maintainability patterns based on an abstract type hierarchy with multiple-dispatch seem foreign and too difficult to implement.

But once you get it, Julia is _beautiful_.

## Purpose

This website serves as my repository of notes and tutorials on how to use _Julia Methods for Computational Physics_ (JM4CP). It's a work in progress, but I plan to cover all sorts of incredibly useful tricks the Julia has up her sleeve that will help you, the reader, do better computational science. 

I also will prove to you that while Julian design practices may seem crazy compared to ones we're used to, they are very natural extensions to how we, as physicists, organize abstract and concrete concepts in our everyday lives.

## Tutorial Links

These notes and tutorials are always accessible from the navigation pane in the upper-left corner of the screen. Otherwise, one can find them here:

1. [Getting Started](/pages/GettingStarted/gettingstarted)

## For More Information...

Check out _Helpful Resources_ by clicking this [link](/pages/helpful_resources) or by using the sidebar to the left. I plan to keep this list of resources that I find helpful updated as I go.

## Disclaimer

I'm not affiliated or endorsed in any way by any person or any company responsible for making the Julia ecosystem a great place for computational physics (although it would be cool to be... :sunglasses:)

I just think Julia is really great and want you to think so, too.