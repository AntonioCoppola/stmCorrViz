\name{stmJSON}
\alias{stmJSON}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
stmJSON(mod, documents = NULL, metadata = NULL, title = "STM Model", clustering_threshold = 1.5, labels_number = 7, verbose)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{mod}{
%%     ~~Describe \code{mod} here~~
}
  \item{documents}{
%%     ~~Describe \code{documents} here~~
}
  \item{metadata}{
%%     ~~Describe \code{metadata} here~~
}
  \item{title}{
%%     ~~Describe \code{title} here~~
}
  \item{clustering_threshold}{
%%     ~~Describe \code{clustering_threshold} here~~
}
  \item{labels_number}{
%%     ~~Describe \code{labels_number} here~~
}
  \item{verbose}{
%%     ~~Describe \code{verbose} here~~
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
function (mod, documents = NULL, metadata = NULL, title = "STM Model", 
    clustering_threshold = 1.5, labels_number = 7, verbose) 
{
    require(stm)
    require(slam)
    require(jsonlite)
    out <- list()
    if (verbose == TRUE) 
        cat("Performing hierarchical topic clustering ... \n")
    clust <- clusterAnalysis(mod, labels_number = labels_number)
    documents <- iconv(documents, to = "utf-8", sub = "")
    temp <- textProcessor(documents, metadata, verbose = FALSE)
    meta <- temp$meta
    vocab <- temp$vocab
    docs <- temp$documents
    prep_output <- prepDocuments(docs, vocab, meta, verbose = FALSE)
    docs <- prep_output$documents
    vocab <- prep_output$vocab
    meta <- prep_output$meta
    if (verbose == TRUE) 
        cat("Generating JSON representation of the model ... \n")
    thoughts <- findThoughts(mod, documents)
    full_labels <- labelTopics(mod)
    topic_proportions <- colMeans(mod$theta)
    K <- mod$settings$dim$K
    topic_to_topic_splits <- c()
    for (i in seq(K - 1)) if (clust$merge[i, 1] < 0 && clust$merge[i, 
        2] < 0) 
        topic_to_topic_splits <- c(topic_to_topic_splits, i)
    aggregate <- setdiff(which(clust$height <= clustering_threshold), 
        topic_to_topic_splits)
    merge_list <- list()
    for (i in seq(K - 1)) merge_list[[i]] <- clust$merge[i, ]
    names(merge_list) <- 1:(K - 1)
    merge_list <- collapseMergeList(merge_list, clust$merge, 
        aggregate, K)
    top_layer <- merge_list[paste(K - 1)][[1]]
    out$children <- buildClusters(list(), current = top_layer, 
        merge_list, labels = clust$labels, full_labels, thoughts, 
        topic_proportions)
    beta_weights <- getBetaWeights(mod, docs)
    out <- assignClusterNames(out, labels_number, beta_weights, 
        mod$vocab)
    out$name <- title
    out$this_root <- TRUE
    out$summary <- capture.output(mod)
    out$proportions <- topic_proportions
    out_JSON <- jsonlite::toJSON(out, force = TRUE)
    return(out_JSON)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
