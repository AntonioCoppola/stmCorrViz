\name{getBetaWeights}
\alias{getBetaWeights}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
getBetaWeights(model, documents = NULL)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{model}{
%%     ~~Describe \code{model} here~~
}
  \item{documents}{
%%     ~~Describe \code{documents} here~~
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
function (model, documents = NULL) 
{
    logbeta <- model$beta$logbeta
    K <- model$settings$dim$K
    vocab <- model$vocab
    margbeta <- exp(logbeta[[1]])
    if (length(logbeta) > 1) {
        weights <- model$settings$covariates$betaindex
        tab <- table(weights)
        weights <- tab/sum(tab)
        margbeta <- margbeta * weights[1]
        for (i in 2:length(model$beta$logbeta)) {
            margbeta <- margbeta + exp(model$beta$logbeta[[i]]) * 
                weights[i]
        }
    }
    if (is.null(documents)) {
        weights <- colSums(model$theta)
    }
    else {
        D.n <- unlist(lapply(documents, function(x) sum(x[2, 
            ])))
        weights <- colSums(D.n * model$theta)
    }
    return(list(beta = margbeta, weights = weights))
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
