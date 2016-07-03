clusterAnalysis <-
function(stmobj, labels_number=3){
  labels <- labelTopics(stmobj)
  theta <- stmobj$theta
  d <- dist(cor(theta))
  clust <- hclust(d, method="complete")
  K <- stmobj$settings$dim$K
  clust$labels <- rep(NA,K)
  for(i in seq(K)){
    l <- labels$frex[i,]
    l <- paste(l[1:labels_number], collapse=', ')
    #clust$labels[i] <- paste('Topic ', i, ': ', l, sep='')
    clust$labels[i] <- l
  }
  return(clust)
}
