@def title = "Downloading & Installing Julia"
@def tags = ["installation", "download"]

# How can I get Julia on my machine?

~~~
<em>Last Updated: {{fill fd_mtime}}</em>
~~~

\toc

## Vanilla installation for beginners

### Instructions after _JuliaCon 2022_

At the annual \newtablink{Julia Convention (<em>JuliaCon</em>)}{https://juliacon.org/2022/}
this year, it was announced that Julia is getting a much better installation system, called [_Juliaup_](https://github.com/JuliaLang/juliaup).

I'm personally very excited about _Juliaup_ because it will make managing and updating Julia releases much simpler (especially for Windows users). This will be great for package developers, or for people like me who want to eke out every last bit performance out of Julia as I can (for science, of course :wink:). I'll update this section when I have time to play around with it more. In the meantime, you can watch David Anthoff's _JuliaCon_ talk here:

~~~
<iframe width="705" height="396" src="https://www.youtube.com/embed/14zfdbzq5BM" title="Juliaup - The Julia installer and version multiplexer | David Anthoff | JuliaCon 2022" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
~~~

### Instructions before _JuliaCon 2022_

You can download and install Julia from \newtablink{this official website}{https://julialang.org/downloads/}.

There are a few different types of downloads that you can try out, and a brief description for them are listed below. For absolute beginners, I would recommend downloading the current stable release, or if you're _really_ nervous about the longevity of your core code, then get the LTS. The main difference between the two is that the stable release is probably faster and has more features, but the LTS version probably has fewer strange and well-hidden bugs.

- Current stable version: as of the time of this writin, is `v1.7.3`.
- Long-term support (LTS): as of the time of this writin, is `v1.6.7`.
- Upcoming release: as of today, it is `v1.8.0-rc3`
  - The `rc3` stands for _release candidate number 3_.
- Older versions.
  - These typically are not recommended for beginners since Julia is still developing quickly. 
- Nightly builds.
  - These are _unstable_ versions of Julia currently under development. They are intended for anyone interested in testing their packages on the latest version of the Julia source to prepare for new releases.

## For those of us who like Linux terminals

These instructions are for people who wish to `sudo` their way into new things. The supported Linux and FreeBSD platforms can be found \newtablink{here}{https://julialang.org/downloads/#supported_platforms}.

It is possible to both build Julia from source or to obtain the generic binaries from the Julia downloads page above. The Julia team recommends using the latter steps unless you really know what you're doing. For help on Linux/FreeBSD, check out [this blog](https://dev-juliacn.github.io/downloads/platform.html).

## Note for the future

~~~
<iframe src="https://giphy.com/embed/bNhbKYM4WFA2s" width="480" height="380" frameBorder="0" class="giphy-embed" allowFullScreen></iframe><p><a href="https://giphy.com/gifs/spongebob-squarepants-bNhbKYM4WFA2s">via GIPHY</a></p>
~~~

I will be learning soon how to install Julia to a cluster for my research, and I will be sure to include what I learn here as well!
