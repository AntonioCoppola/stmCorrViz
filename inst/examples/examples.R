library(stmCorrViz)

require(stm)
data(gadarian)

# Pre-processing the data
temp <- textProcessor(documents=gadarian$open.ended.response, 
                      metadata=gadarian)
meta <- temp$meta
vocab <- temp$vocab
docs <- temp$documents
out <- prepDocuments(docs, vocab, meta)
docs <-out$documents
vocab<-out$vocab
meta <-out$meta

# Fitting the STM model
set.seed(02138)
mod.out <- stm(docs, vocab, 20, 
               prevalence=~treatment + s(pid_rep), data=meta)

# Generating the visualization
scv <- stmCorrViz_htmlwidget(
  stmJSON(
    mod.out,
    documents_raw=as.character(gadarian$open.ended.response), 
    documents_matrix=docs,
    verbose=TRUE
  )
)
scv

library(htmltools)
browsable(tagList(scv,scv))
