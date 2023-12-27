# munfold
## An R package which provides Schoenemann's algorithm for metric multidimensional unfolding and Procrustes rotation of unfolding results.

[![Current release on GitHub](https://img.shields.io/github/release/melff/munfold.svg)](https://github.com/melff/munfold/releases/)
[![CRAN](https://www.r-pkg.org/badges/version/munfold)](https://cran.r-project.org/package=munfold)
[![Total downloads from RStudio CRAN mirror](https://cranlogs.r-pkg.org/badges/grand-total/munfold)](https://cran.r-project.org/web/packages/munfold/index.html)
[![Monthly downloads from RStudio CRAN mirror](https://cranlogs.r-pkg.org/badges/munfold)](https://cran.r-project.org/web/packages/munfold/index.html)


Multi-dimensional unfolding is a procedure to recover positions of two
sets of points from a matrix of distances between the points of both
groups. For some of my [research
work](http://dx.doi.org/10.1016/j.electstud.2009.02.002), I implemented
the algorithm for metric multi-dimensional unfolding that Peter
Schönemann published back in 1970 in
[Psychometrika](http://www.springerlink.com/content/6123373164863474/).
This is not the most advanced algorithm, however it is quite robust and
quick when a large number of points is involved. Note that it is an
algorithm for *metric* unfolding. That is, the input data need to be
interpretable as real distances.

The package that contains my implementation of Schönemann's algorithm is
called *munfold*. It is now published on
[CRAN](http://cran.r-project.org/package=munfold). Development occurs on
[GitHub](http://github.com), where both
[releases](https://github.com/melff/munfold/releases) and the
[development tree](https://github.com/melff/munfold) can be found.

<figure>
<img src="man/figures/unfold-demo.svg" alt="unfold-demo.svg" />
<figcaption>A demonstration of multidimensional unfolding. The left
panel shows the original configuration, the right panel shows the
reconstructed configuration. Note that the Schoenemann algorithm leads
to a successful reconstruction of the circle only if the positions of
the points are very slightly perturbed.</figcaption>
</figure>

