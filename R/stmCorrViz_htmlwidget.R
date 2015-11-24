#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @export
stmCorrViz_htmlwidget <- function(
  stmJSON = NULL,
  width = NULL,
  height = NULL
) {

  # forward options using x
  x = list(
    stmJSON = stmJSON
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'stmCorrViz_htmlwidget',
    x,
    width = width,
    height = height,
    package = 'stmCorrViz'
  )
}

stmCorrViz_htmlwidget_html <-  function(id, style, class, ...){
  htmltools::tags$div(
    id = id,
    style = style,
    style = "overflow: scroll;",
    class = class,
    htmltools::HTML(
'
<svg></svg>
<div class="modal fade" id="topicModal" tabindex="-1" role="dialog" aria-labelledby="topicModalLabel" aria-hidden="true">
<div class="modal-dialog"><div class="modal-content"><div class="modal-header"><button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button><h4 class="modal-title" id="topicModalLabel">Topic Information</h4></div>
<div class="modal-body" id="topicBody"><h5>Top Words</h5><ul id="word-list"><li id="high-prob">Highest Probability: </li><li id="frex">FREX: </li><li id="lift">Lift: </li><li id="score">Score: </li></ul><hr><h5>Representative Documents</h5>
<div id="doc1" class="modal-body scrollbox"></div>
<br><div id="doc2" class="modal-body scrollbox"></div><div class="modal-footer"><button type="button" class="btn btn-default" data-dismiss="modal">Close</button></div></div><div class="modal-body" id="modelBody"><h5>Summary</h5><span id="mod1-text"></span><hr><div id="barchartDiv">
<h5>Topic Proportions in Corpus</h5><br></div><br><div class="modal-footer">
<button type="button" class="btn btn-default" data-dismiss="modal">Close</button></div></div><div class="modal-body" id="clusterBody"><h5>Summary</h5><span id="clust1-text"></span><br><br><div class="modal-footer">
<button type="button" class="btn btn-default" data-dismiss="modal">Close</button></div></div></div></div>
'
    )
  )
}

#' Shiny bindings for stmCorrViz_htmlwidget
#'
#' Output and render functions for using stmCorrViz_htmlwidget within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a stmCorrViz_htmlwidget
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name stmCorrViz_htmlwidget-shiny
#'
#' @export
stmCorrViz_htmlwidgetOutput <- function(outputId, width = '100%', height = '400px'){
  shinyWidgetOutput(outputId, 'stmCorrViz_htmlwidget', width, height, package = 'stmCorrViz')
}

#' @rdname stmCorrViz_htmlwidget-shiny
#' @export
renderStmCorrViz_htmlwidget <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  shinyRenderWidget(expr, stmCorrViz_htmlwidgetOutput, env, quoted = TRUE)
}
