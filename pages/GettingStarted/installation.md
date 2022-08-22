@def title = "Downloading & Installing Julia"
@def tags = ["installation", "download"]

# How can I get Julia on my machine?

\FirstPostedLastUpdated{July 30, 2022}

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

- Current stable version: as of the time of this writing, is `v1.8.0`.
- Long-term support (LTS): as of the time of this writing, is `v1.6.7`.
- Older versions.
  - These typically are not recommended for beginners since Julia is still developing quickly.
- Nightly builds.
  - These are _unstable_ versions of Julia currently under development. They are intended for anyone interested in testing their packages on the latest version of the Julia source to prepare for new releases.

## For those of us who like Linux terminals

The supported Linux and FreeBSD platforms can be found \newtablink{here}{https://julialang.org/downloads/#supported_platforms}.

It is possible to both build Julia from source or to obtain the generic binaries from the Julia downloads page above. The Julia team recommends using the latter steps unless you really know what you're doing.

As documented \newtablink{here,}{https://julialang.org/downloads/platform/#linux_and_freebsd} to obtain the generic binaries, one just needs to type the following into the terminal:

```bash
wget https://julialang-s3.julialang.org/bin/linux/x64/1.8/julia-1.8.0-linux-x86_64.tar.gz
tar zxvf julia-1.8.0-linux-x86_64.tar.gz
```

The first command pulls the `julia-1.8.0-linux-x86_64.tar.gz` tarball from the `julialang` servers into whichever directory you're currently in and the second unzips it and creates a new `julia-1.8.0` folder. At this point it is safe to remove the tarball with

```bash
rm julia-1.8.0-linux-x86_64.tar.gz
```

Finally, since this is not a true install with `sudo`, one must tell your environment where to find the `julia` binary. The recommended location from the Julia team is in one's `.bashrc` file, located at `~/.bashrc`. All one must do then is append the following line:

```bash
export PATH="$PATH:<path-to-julia>/julia-1.8.0/bin"
```

For example, on my machine, `julia` is located at `/home/joe/julia-1.8.0` and so the `<path-to-julia> == /home/joe`. Then, save and exit the `.bashrc` file and type

```bash
. ~/.bashrc
```

to load the new enviroment as one must do after editing the `.bashrc` file. (Upon opening the terminal, the command above is called, so you won't need to worry about doing this every time afterwards.)

After that, all you need to do is type `julia` into the terminal and you'll see the `REPL`!

## Note for the future

~~~
<iframe src="https://giphy.com/embed/bNhbKYM4WFA2s" width="480" height="380" frameBorder="0" class="giphy-embed" allowFullScreen></iframe><p><a href="https://giphy.com/gifs/spongebob-squarepants-bNhbKYM4WFA2s">via GIPHY</a></p>
~~~

I will be learning soon how to install Julia to a cluster for my research, and I will be sure to include what I learn here as well!
