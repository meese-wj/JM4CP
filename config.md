<!--
Add here global page variables to use throughout your website.
-->
+++
author = "W. Joe Meese"
mintoclevel = 2

ignore = ["node_modules/", "template_code/"]

generate_rss = true
website_title = "Julian Methods for Computational Physics"
website_descr = "Assorted Notes from a Self-Taught Julia Enthusiast"
website_url   = "https://meese-wj.github.io/JM4CP/"

using Git, Dates, TimeZones
function git_last_modified(filepath, format="%cI")
    command = `$(git()) log -1 --pretty=$("format:" * format) $filepath`
    return readchomp(command)
end

function LastUpdated(filepath, date_format = "E U m, Y at HH:MM:SS")
    output = git_last_modified(filepath)
    zdt = ZonedDateTime(output, "yyyy-mm-ddTHH:MM:SSzzzz")
    return Dates.format(zdt, date_format)
end
+++

@def prepath = "JM4CP"

<!--
Add here global latex commands to use throughout your pages.
-->
\newcommand{\R}{\mathbb R}
\newcommand{\scal}[1]{\langle #1 \rangle}

\newcommand{\newtablink}[2]{
    ~~~
    <a href="#2" target="_blank">#1</a>
    ~~~
}

\newcommand{\note}[1]{@@note @@title ⚠ Note@@ @@content #1 @@ @@}

\newcommand{\codeinfo}[1]{@@codeinfo @@title ⚠ Code Info@@ @@content #1 @@ @@}

\newcommand{\codeshow}[1]{@@code-output \show{#1} @@}

\newcommand{\FirstPostedLastUpdated}[1]{
~~~
<p>
<em><strong>First Posted:</strong> #1</em>
</p>
<p>
<em><strong>Last Updated:</strong> {{fill fd_mtime}}</em>
</p>
~~~
---
}

\newcommand{\Footnotes}[]{
## Footnotes

Clicking on the specific footnote number will take you back to where you were in the text.
}

\newcommand{\NotEnoughTime}[]{

 ```julia-repl
(v1.8) pkg> activate ./Universe

(Universe) pkg>

julia> using Universe

julia> Universe.make_more_time()
[Info: Processing request...
[Info: This may take a few moments.
```

}