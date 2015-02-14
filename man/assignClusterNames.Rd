\name{assignClusterNames}
\alias{assignClusterNames}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
assignClusterNames(out, lab_no, beta_weights, vocab)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{out}{
%%     ~~Describe \code{out} here~~
}
  \item{lab_no}{
%%     ~~Describe \code{lab_no} here~~
}
  \item{beta_weights}{
%%     ~~Describe \code{beta_weights} here~~
}
  \item{vocab}{
%%     ~~Describe \code{vocab} here~~
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
function (out, lab_no, beta_weights, vocab) 
{
    members <- c()
    for (i in seq(length(out$children))) {
        if (!("size" \%in\% names(out$children[[i]]))) 
            out$children[[i]] <- assignClusterNames(out$children[[i]], 
                lab_no, beta_weights, vocab)
    }
    for (i in seq(length(out$children))) {
        members <- c(members, out$children[[i]]$topic_no)
    }
    out$topic_no <- members
    margins <- marginalize(members, beta_weights$beta, beta_weights$weights)
    labels <- vocab[margins$indices[1:lab_no]]
    out$name <- paste(sample(labels, lab_no), collapse = ", ")
    return(out)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
