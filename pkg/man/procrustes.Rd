\name{procrustes}
\alias{procrustes}
\alias{procrustes.unfolding}
\title{Procrustes Rotation}
\description{\code{procrustes} performs procrustes rotation, at the moment only of
\code{unfold} solutions.
}
\usage{
procrustes(x, \dots)

\method{procrustes}{unfolding}(x, use=attr(x,"procrustes_use"), target, \dots)
}
\arguments{
  \item{x}{an object the components of which to rotate.},
  \item{use}{which of the components of \code{x} should be used
    as criterion for rotation.}
  \item{target}{a matrix to which the rotation criterion should
    be brought as close as possible.}
  \item{\dots}{further arguments for future methods, currently ignored.}
}
\value{a copy of \code{x} with components appropriately rotated. }