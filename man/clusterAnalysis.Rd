\name{clusterAnalysis}
\alias{clusterAnalysis}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
clusterAnalysis(stmobj, labels_number = 3)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{stmobj}{
%%     ~~Describe \code{stmobj} here~~
}
  \item{labels_number}{
%%     ~~Describe \code{labels_number} here~~
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (stmobj, labels_number = 3) 
{
    labels <- labelTopics(stmobj)
    theta <- stmobj$theta
    d <- dist(cor(theta))
    clust <- hclust(d, method = "complete")
    K <- stmobj$settings$dim$K
    clust$labels <- rep(NA, K)
    for (i in seq(K)) {
        l <- labels$frex[i, ]
        l <- paste(l[1:labels_number], collapse = ", ")
        clust$labels[i] <- l
    }
    return(clust)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
