<!--
Add here global page variables to use throughout your website.
-->
+++
author = "W. Joe Meese"
mintoclevel = 2

# Add here files or directories that should be ignored by Franklin, otherwise
# these files might be copied and, if markdown, processed by Franklin which
# you might not want. Indicate directories by ending the name with a `/`.
# Base files such as LICENSE.md and README.md are ignored by default.
ignore = ["node_modules/"]

# RSS (the website_{title, descr, url} must be defined to get RSS)
generate_rss = true
website_title = "Julian Methods for Computational Physics"
website_descr = "Assorted Notes from a Self-Taught Julia Enthusiast"
website_url   = "https://meese-wj.github.io/JM4CP/"
+++

@def prepath = "JM4CP"
@def hascode = true

<!--
Add here global latex commands to use throughout your pages.
-->
\newcommand{\R}{\mathbb R}
\newcommand{\scal}[1]{\langle #1 \rangle}
