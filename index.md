@def title = "Julian Methods for Computational Physics"
@def tags = ["syntax", "code"]

# Assorted Notes from a Self-Taught Julia Enthusiast

\toc

## Summary Overview

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

## Helpful Resources

As I said above, I taught myself how to use Julia. What that actually translates to is that I've _learned_ from an online community of generous teachers who publish many of their educational materials for free. Here's a list, in no particular order, of resources that I cannot recommend enough to anyone interested in Julia programming.

- Tom Kwong. [_Hands-On Design Patterns and Best Practices with Julia: Proven solutions to common problems in software design for Julia 1.x_.](https://www.amazon.com/Hands-Design-Patterns-Julia-comprehensive/dp/183864881X) Packt Publishing, 2020.
  - Only Julia resource I've spent money on. Worth every penny and one of the few textbooks I've legitimately read cover-to-cover (he's a very fast-paced writer despite the book being 500+ pages long). Kwong does an excellent job communicating why he, like most in the Julia community, consider the  multiple-dispatch paradigm superior to the traditional object-oriented paradigm in software design. He also has a plethora of hands-on examples showing how this is the case.

- Dabbling Doggo. [_julia for talented amateurs_.](https://www.youtube.com/c/juliafortalentedamateurs/about) Youtube Channel.
  - This YouTuber has inspired me a lot to continue with Julia and create tutorials of my own. They seem to be interested in learning all things Julia and make videos to document their own progress, including how to use Julia to make static websites like with one!

## Disclaimer

I'm not affiliated or endorsed in any way by any person or any company responsible for making the Julia ecosystem a great place for computational physics (although it would be cool to be... :sunglasses:)

I just think Julia is really great and want you to think so, too.