\name{collapseMergeList}
\alias{collapseMergeList}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
collapseMergeList(merge_list, merge_matrix, aggregate, K)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{merge_list}{
%%     ~~Describe \code{merge_list} here~~
}
  \item{merge_matrix}{
%%     ~~Describe \code{merge_matrix} here~~
}
  \item{aggregate}{
%%     ~~Describe \code{aggregate} here~~
}
  \item{K}{
%%     ~~Describe \code{K} here~~
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
function (merge_list, merge_matrix, aggregate, K) 
{
    calls <- which(merge_matrix \%in\% aggregate)
    old_refs <- c()
    row_indices <- c()
    col_indices <- c()
    for (i in seq(length(calls))) {
        call <- calls[i]
        if (call <= K - 1) {
            row_indices[i] <- call
            col_indices[i] <- 1
        }
        else {
            row_indices[i] <- call - K + 1
            col_indices[i] <- 2
        }
        old_refs[i] <- merge_list[row_indices[i]][[1]][col_indices[i]]
    }
    deletion_seq <- data.frame(old_refs = old_refs, row_indices = row_indices, 
        col_indices = col_indices)
    deletion_seq <- deletion_seq[order(old_refs), ]
    for (i in seq(nrow(deletion_seq))) {
        row_index <- deletion_seq$row_indices[i]
        col_index <- deletion_seq$col_indices[i]
        old_ref <- deletion_seq$old_refs[i]
        merge_list[row_index][[1]] <- c(merge_list[row_index][[1]], 
            merge_list[old_ref][[1]])
    }
    for (row_index in names(merge_list)) {
        delete <- which(merge_list[paste(row_index)][[1]] \%in\% 
            aggregate)
        if (any(delete)) 
            merge_list[row_index][[1]] <- merge_list[row_index][[1]][-delete]
    }
    merge_list <- merge_list[-aggregate]
    return(merge_list)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
