\name{buildClusters}
\alias{buildClusters}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
buildClusters(out, current, merge_list, labels, full_labels, thoughts, topic_proportions)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{out}{
%%     ~~Describe \code{out} here~~
}
  \item{current}{
%%     ~~Describe \code{current} here~~
}
  \item{merge_list}{
%%     ~~Describe \code{merge_list} here~~
}
  \item{labels}{
%%     ~~Describe \code{labels} here~~
}
  \item{full_labels}{
%%     ~~Describe \code{full_labels} here~~
}
  \item{thoughts}{
%%     ~~Describe \code{thoughts} here~~
}
  \item{topic_proportions}{
%%     ~~Describe \code{topic_proportions} here~~
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
function (out, current, merge_list, labels, full_labels, thoughts, 
    topic_proportions) 
{
    for (i in seq(length(current))) {
        out[[i]] <- list()
        out[[i]]$name <- current[i]
        if (current[i] > 0) {
            out[[i]]$children <- buildClusters(list(), merge_list[paste(current[i])][[1]], 
                merge_list, labels = labels, full_labels, thoughts, 
                topic_proportions)
            out[[i]]$name <- current[i]
        }
        else {
            out[[i]]$size <- 1800
            out[[i]]$name <- labels[-current[i]]
            out[[i]]$topic_no <- -current[i]
            out[[i]]$thought_1 <- iconv(thoughts$docs[-current[i]]$Topic[1], 
                to = "utf-8", sub = "")
            out[[i]]$thought_2 <- iconv(thoughts$docs[-current[i]]$Topic[2], 
                to = "utf-8", sub = "")
            out[[i]]$prob <- paste(full_labels$prob[-current[i], 
                ], collapse = ", ")
            out[[i]]$frex <- paste(full_labels$frex[-current[i], 
                ], collapse = ", ")
            out[[i]]$lift <- paste(full_labels$lift[-current[i], 
                ], collapse = ", ")
            out[[i]]$score <- paste(full_labels$score[-current[i], 
                ], collapse = ", ")
            out[[i]]$proportion <- format(round(topic_proportions[-current[i]], 
                2))
        }
    }
    return(out)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
