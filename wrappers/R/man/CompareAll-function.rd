\name{CompareAll-function}
\Rdversion{1.1}
\alias{compareAll}
\docType{methods}
\title{
Compare a given set of spatial histograms
}
\description{
This function computes the Kantorovich-Wasserstein among a given set of \code{M} spatial histograms. All the histograms are defined over the same grid map.

The grid map is described by the two lists of \code{N} coordinates \code{Xs} and \code{Ys}, which specify the coordinates of the centroid of each tile of the map.
For each tile \code{i} with coordinates \code{Xs[i], Ys[i]}, we have a positive weight for each histogram.

The two lists of coordinates are passed to \code{compareOneToMany} as a matrix with \code{N} rows and two columns.
The weights of the histograms are passed as a single matrix with \code{N} rows and \code{M} columns.
}
\usage{
compareAll(Coordinates, Weights, L = 3, recode = TRUE,
           method = "approx",    algorithm = "colgen",
           model="mincostflow",  verbosity = "silent",
           timelimit = 14400,    opt_tolerance = 1e-06,
           unbalanced = FALSE, unbal_cost = 1e+09, convex = TRUE)
}
\arguments{
  \item{Coordinates}{A \code{Matrix} with \code{N} rows and two columns:
    \itemize{
      \item{\code{Coordinates[,1]}: }{\emph{(First Column)} Vector of horizontal coordinates of the centroids of each tile of the map. Data type: vector of positive integers.}
      \item{\code{Coordinates[,2]}: }{\emph{(Second Column)} Vector of vertical coordinates of the centroids of each tile of the map. Data type: vector of positive integers.}
    }
  }

  \item{Weights}{A \code{Matrix} of positive weights of the tiles specified by the \code{Coordinates} matrix, one column for each input histogram.}

  \item{L}{Approximation parameter.
    Higher values of \emph{L} gives more accurate solution, but requires longer running time. Data type: positive integer.}

  \item{recode}{If equal to \code{True}, recode the input coordinates as consecutive integers.}

  \item{method}{Method for computing the KW distances: \code{exact} or \code{approx}.}

  \item{algorithm}{Algorithm for computing the KW distances: \code{fullmodel} or \code{colgen}.}

  \item{model}{Model for building the underlying network: \code{bipartite} or \code{mincostflow}.}

  \item{verbosity}{Level of verbosity of the log: \code{silent}, \code{info} or \code{debug}.}

  \item{timelimit}{Time limit in second for running the solver.}

  \item{opt_tolerance}{Numerical tolerance on the negative reduce cost for the optimal solution.}

  \item{unbalanced}{If equal to \code{True}, solve the problem with unbalanced masses.}

  \item{unbal_cost}{Cost for the arcs going from each point to the extra artificial bin.}

  \item{convex}{If equal to \code{True}, compute the convex hull of the input points.}
}

\details{
The function \code{compareAll(Coordinates, Weights, ...)} computes the distances among a given set of spatial histograms.
All the histograms are specified by the \code{M} columns of matrix \code{Weights}, and where the support points (i.e., centroids of each tile of the map)
are defined by the coordinates given in \code{Xs} and \code{Ys} in the two columns of matrix \code{Coordinates}.
The algorithm used to compute such distance depends on the parameters specified as optional arguments of the function.

The most important is the parameter \code{L}, which by default is equal to 3 (see \code{\link{compareOneToOne}}).
}
\value{
    Return an R List with the following named attributes:
  \itemize{
  \item{\code{distances}: }{A symmetric matrix of dimension \code{M}x\code{M} of KW-distances among the input histograms.}
  \item{\code{status}: }{Status of the solver used to compute the distances.}
  \item{\code{runtime}: }{Overall runtime in seconds to compute all the distances.}
  \item{\code{iterations}: }{Overall number of iterations of the Network Simplex algorithm.}
  \item{\code{nodes}: }{Number of nodes in the network model used to compute the distances.}
  \item{\code{arcs}: }{Number of arcs in the network model used to compute the distances.}
  }
}
\seealso{
See also \code{\link{compareOneToOne}}, \code{\link{compareOneToMany}}, \code{\link{Histogram2D}}, and \code{\link{Solver}}.
}
\examples{
# Define a simple example
library(SpatialKWD)

# Random coordinates
N = 90
Xs <- as.integer(runif(N, 0, 31))
Ys <- as.integer(runif(N, 0, 31))
coordinates <- matrix(c(Xs, Ys), ncol=2, nrow=N)

# Random weights
m <- 3
test3 <- matrix(runif(m*N, 0, 1), ncol=m)

# Compute distance
print("Compare all pairwise distances with an approximate algorithm:")
d <- compareAll(coordinates, Weights=test3, L=3)
cat("L: 3, runtime:", d$runtime, " distances:", "\n")
m <- matrix(d$distance, ncol=3, nrow=3)
print(m)
}
