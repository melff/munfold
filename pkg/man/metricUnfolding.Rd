\name{unfold}
\alias{unfold}
\alias{biplot.unfolding}
\alias{plot.unfolding}
\alias{uapply}
\alias{unfold.matrix}
\alias{unfold.formula}
\title{Metric Unfolding}
\description{
\code{unfold} computes a metric unfolding solution
based on a rectangular matrix, that is, reconstructs
two sets of points from the distances between points
of the first set and the points of the second set.

\code{uapply} applies a function
the two point sets that are reconstructed by \code{unfold}.
}
\usage{
unfold(x,...)

\method{unfold}{matrix}(x, ndims=NULL, squared=FALSE, tol=1e-7,
          method=c("Schoenemann", "CG"), \dots)

\method{unfold}{formula}(x,data=parent.frame(), \dots)

\method{biplot}{unfolding}(x, dimen=c(1,2), type=attr(x,"biplot_type"),
  xlim, ylim, tpos=c(4,2), tposdim=1,
  asp=1, lty=c(1,2), lwd=c(1,1), pch=c(1,3), cex=c(1,1),
  col=c("black","black"), contour.col="black", contour.lty=1,
  xlab=paste("Dimension ",dimen[1]),
  ylab=paste("Dimension ",dimen[2]),
  \dots)

\method{plot}{unfolding}(x, y=NULL ,dimen=1, discrete=attr(x,"plot_discrete"),
  use.rownames=discrete, xlab=paste("Dimension ",dimen), \dots)

uapply(x,FUN)
}
\arguments{
\item{x}{for \code{unfold.matrix}: a rectangular matrix that contains distances
  or squared distances (if argument \code{squared} is \code{TRUE}).
    For \code{unfold.formula}: a formula which specifies the variables
    that form the columns of the matrix of distances.
    For \code{biplot.unfolding} and \code{plot.unfolding}: an object that contains an unfolding solution.
    }
\item{data}{a data frame or an environment that contains variables specified in
  the formula given as first argument.}
\item{ndims}{an optional integer value that specifies the
  dimensionality of the solution. If \code{NULL} the
  dimensionality is selected automatically based
  on a singular value decomposition of the matrix
  of squared distances.
  }
\item{squared}{a logical value; does the matrix \code{D} contain squared distances?}
\item{tol}{a tolerance value for the convergence of the
  conjugate gradients method.}
\item{method}{a method for the iterative computation
  of the unfolding solution.}
\item{y}{a dummy argument for compatibility with default methods, ignored.}
\item{dimen}{for \code{biplot}: a two-element integer vector,
  for \code{plot}: a single integer value, that specifies
  the dimension(s) of the unfolding solution to be plotted.
  }
\item{type}{a character vector of length less then or equal to 2.
  Determines how each of the two point sets of the unfolding
  solutions are represented in the biplot.
  Valid choices are
  \itemize{
    \item{\code{"points"}}{the respective set of points are plotted
      as points in the biplot.}
    \item{\code{"lines"}}{the points of the respective set
      are connected by lines.}
    \item{\code{"both"}}{the points of the respective set
      are plotted as points and connected by lines.}
    \item{\code{"text"}}{the points of the respective set
      are represented by the corresponding row names
      and, if argument \code{tpos} is present,
      by points.
      }
    \item{\code{"density"}}{contour lines are drawn of
      two-dimensional kernel density estimate for the
      respective set of points.
     This biplot type
      uses the function \code{\link[MASS]{kde2d}}
      of library \code{MASS}.
      }
  }
}
\item{tpos}{a two-element integer vector; specifies
  the position of text labels relative
  to the points. For the meaning of these integer values
  see \code{\link[graphics]{text}} }
\item{tposdim}{an integer value; specifies which how elements of \code{tpos}
  are used. Labels of points with negative positions along coordinate axis
  \code{dimen[tposdim]} are positioned according to \code{tpos[1]},
  labels of other points are positioned according to \code{tpos[1]}.
  }
\item{xlab, ylab, xlim, ylim, asp, lty, lwd, pch, cex, col}{arguments passed to base graphics functions}.
\item{contour.col, contour.lty}{colour and line type for contour lines,
  see \code{\link[graphics]{contour}}. }
\item{discrete}{a logical vector of lenght 2;
  if \code{TRUE}, the respective set of points are represented
  by spikes in theplot, otherwise the set is represented
  by a graph of a kernel density estimate.
  }
\item{use.rownames}{logical; should row names used for annotation?}
\item{\dots}{further arguments passed to \code{\link[stats]{optim}} in
  case of \code{unfold} or \code{\link[graphics]{points}}
  in case of the plotting methods.}
\item{FUN}{a function applied to the two sets of points that result
from the unfolding.}
}
\details{
\code{unfold} first computes an unfolding solution according to
Schoenemanns metric unfolding algorithm that uses only
linear algebra operations. This preliminary solution is
then refined by minimizing the stress using a conjugate-gradients
method.

\code{uapply} applies a given function to the two sets of points
recovered by an unfolding solution. It applies the function
to the components \code{A} and \code{B} of an object
of class \code{"unfolding"}.
}
\value{
\code{unfold} returns an object of class \code{"unfolding"}
with components

  \item{A}{a numeric matrix representing
  the first set of points. Each row contains the coordinate
  of one point of the first set.}
  \item{B}{a numeric matrix representing
  the second set of points. Each row contains the coordinate
  of one point of the second set.}
  \item{fitted}{a numeric matrix that contains the
    fitted squared distances.}
  \item{stress}{A stress value, denotes the "badness of fit".}

}
\examples{
r <- seq(from=0,to=2*pi,length=24)
a1 <- cos(r)*4 + 0.00001*rnorm(r)
a2 <- sin(r)*4 + 0.00001*rnorm(r)
b1 <- c(.5,-.5,-.5,.5)*3 + 5
b2 <- c(.5,.5,-.5,-.5)*3 + 1

D1 <- outer(b1,a1,"-")
D2 <- outer(b2,a2,"-")

Dsq <- D1^2+D2^2


Dsq.uf<-unfold(sqrt(Dsq),squared=FALSE)

oldpar <- par(mfrow=c(1,2))
A <- cbind(a1,a2)
B <- cbind(b1,b2)

ltype <- c(rep(1,NROW(A)),rep(2,NROW(A)))

orig <- rbind(A,B)
unfolded <- rbind(Dsq.uf$A,Dsq.uf$B)

xlim <- ylim <- range(orig)#*1.5

plot(A,type="b",pch=1,
    xlim=xlim,ylim=ylim,
    xlab="Dimension 1",ylab="Dimension 2",main=expression("Original data"),asp=1)
lines(B,type="b",pch=3,lty=2)
abline(h=0,v=0,lty=3)

biplot(Dsq.uf,type="b",
    xlim=xlim,ylim=ylim,
    main=expression(paste(italic(unfold)," solution")),asp=1)


par(oldpar)

}
\keyword{multivariate}
\keyword{hplot}