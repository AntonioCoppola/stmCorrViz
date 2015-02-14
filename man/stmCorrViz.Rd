\name{stmCorrViz}
\alias{stmCorrViz}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
stmCorrViz(mod, file_out, documents = NULL, metadata = NULL, title = "STM Model", clustering_threshold = 1.5, labels_number = 7, display = TRUE, verbose = FALSE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{mod}{
%%     ~~Describe \code{mod} here~~
}
  \item{file_out}{
%%     ~~Describe \code{file_out} here~~
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
  \item{display}{
%%     ~~Describe \code{display} here~~
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
function (mod, file_out, documents = NULL, metadata = NULL, title = "STM Model", 
    clustering_threshold = 1.5, labels_number = 7, display = TRUE, 
    verbose = FALSE) 
{
    JSON <- stmJSON(mod, documents, metadata, title, clustering_threshold, 
        labels_number, verbose)
    if (verbose == TRUE) 
        cat("Generating HTML view ... \n")
    header <- paste0("\n  <!DOCTYPE html><meta charset=UTF-8>\n  <style>.node rect{cursor:pointer;fill:#fff;fill-opacity:.5;stroke:#3182bd;stroke-width:1.5px;}\n  .node text{font:10px sans-serif;pointer-events:none;}\n  path.link{fill:none;stroke:#9ecae1;stroke-width:1.5px;}\n  .control.glyphicon{position:static;color:#4A4C4F;font-family:\"Oxygen\", sans-serif;cursor:pointer;}\n  .scrollbox {height: 120px;border: 1px solid #e5e5e5;overflow: scroll;}</style>\n  <link href=\"https://fonts.googleapis.com/css?family=Oxygen\" rel=stylesheet type=\"text/css\">\n  <link href=\"https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css\" rel=stylesheet>\n  <title>STM Visualization</title><body>\n  <script src=\"https://cdnjs.cloudflare.com/ajax/libs/d3/3.5.3/d3.min.js\"></script>\n  <script src=\"https://code.jquery.com/jquery-1.11.1.min.js\"></script>\n  <script src=\"https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js\"></script>\n  <script>var margin={top:30,right:20,bottom:30,left:20},width=window.innerWidth/1.5-margin.left-margin.right,height=window.innerHeight-margin.top-margin.bottom,barHeight=20,barWidth=width*.8;\n  var i=0,duration=400,root;var tree=d3.layout.tree().nodeSize([0,20]);var diagonal=d3.svg.diagonal().projection(function(d){return[d.y,d.x];});\n  var svg=d3.select(\"body\").append(\"svg\").attr(\"width\",width+margin.left+margin.right).attr(\"height\",height+margin.top+margin.bottom).append(\"g\").attr(\"transform\",\"translate(\"+margin.left+\",\"+margin.top+\")\");\n  root= ")
    footer <- paste0("\n \n root.x0=0;root.y0=0;update(root);function update(source){var nodes=tree.nodes(root);var height=Math.max(500,nodes.length*barHeight+margin.top+margin.bottom);\n  d3.select(\"svg\").transition().duration(duration).attr(\"height\",height);d3.select(self.frameElement).transition().duration(duration).style(\"height\",height+\"px\");nodes.forEach(function(n,i){n.x=i*barHeight;});\n  var node=svg.selectAll(\"g.node\").data(nodes,function(d){return d.id||(d.id=++i);});\n  var nodeEnter=node.enter().append(\"g\").attr(\"class\",function(d){if(d.size){return\"node leaf\"}else{return\"node noleaf\"}}).attr(\"transform\",function(d){return\"translate(\"+source.y0+\",\"+source.x0+\")\";}).style(\"opacity\",1e-6);\n  nodeEnter.append(\"rect\").data(nodes).attr(\"y\",-barHeight/2).attr(\"height\",barHeight).attr(\"width\",barWidth).style(\"fill\",color).on(\"click\",clickModal);nodeEnter.append(\"text\").attr(\"dy\",3.5).attr(\"dx\",5.5).text(function(d){return d.name;});\n  d3.selectAll(\"g.noleaf\").append(\"svg:foreignObject\").attr(\"width\",20).attr(\"height\",20).attr(\"y\",\"-10px\").attr(\"x\",barWidth-15).append(\"xhtml:span\").attr(\"class\",\"control glyphicon glyphicon-minus\").attr(\"width\",\"30\").on(\"click\",function(d){click(d);});\n  nodeEnter.transition().duration(duration).attr(\"transform\",function(d){return\"translate(\"+d.y+\",\"+d.x+\")\";}).style(\"opacity\",1);node.transition().duration(duration).attr(\"transform\",function(d){return\"translate(\"+d.y+\",\"+d.x+\")\";}).style(\"opacity\",1).select(\"rect\").style(\"fill\",color);\n  node.exit().transition().duration(duration).attr(\"transform\",function(d){return\"translate(\"+source.y+\",\"+source.x+\")\";}).style(\"opacity\",1e-6).remove();\n  var link=svg.selectAll(\"path.link\").data(tree.links(nodes),function(d){return d.target.id;});link.enter().insert(\"path\",\"g\").attr(\"class\",\"link\").attr(\"d\",function(d){var o={x:source.x0,y:source.y0};return diagonal({source:o,target:o});}).transition().duration(duration).attr(\"d\",diagonal);\n  link.transition().duration(duration).attr(\"d\",diagonal);link.exit().transition().duration(duration).attr(\"d\",function(d){var o={x:source.x,y:source.y};return diagonal({source:o,target:o});}).remove();nodes.forEach(function(d){d.x0=d.x;d.y0=d.y;});}\n  function click(d){if(d.children){d._children=d.children;d.children=null;}else{d.children=d._children;d._children=null;}update(d);}\n  function color(d){return d._children?\"#3182bd\":d.children?\"#c6dbef\":\"#fd8d3c\";}\n  function clickModal(d){if(d.size){$(\"#doc1\").text(d.thought_1);$(\"#doc2\").text(d.thought_2);$(\"#high-prob\").text(\"Highest Probability: \"+d.prob);$(\"#topicModalLabel\").text(\"Topic \"+d.topic_no+\" Information\");$(\"#frex\").text(\"FREX: \"+d.frex);$(\"#lift\").text(\"Lift: \"+d.lift);\n  $(\"#score\").text(\"Score: \"+d.score);$(\"#proportion\").text(\"\"+d.proportion);$(\"#modelBody\").hide();$(\"#clusterBody\").hide();$(\"#topicBody\").show();$(\"#topicModal\").modal(\"show\");}else if(d.this_root){$(\"#topicModalLabel\").text(\"Fitted Model Information\");$(\"#mod1-text\").text(d.summary);$(\"#topicBody\").hide();\n  $(\"#clusterBody\").hide();$(\"#modelBody\").show();$(\"#topicModal\").modal(\"show\");}else{$(\"#topicModalLabel\").text(\"Cluster Information\");$(\"#clust1-text\").text(\"This cluster comprises topics \"+d.topic_no.join(\", \")+\".\");$(\"#topicBody\").hide();$(\"#modelBody\").hide();\n  $(\"#clusterBody\").show();$(\"#topicModal\").modal(\"show\");}}</script><div class=\"modal fade\" id=\"topicModal\" tabindex=\"-1\" role=\"dialog\" aria-labelledby=\"topicModalLabel\" aria-hidden=\"true\">\n  <div class=\"modal-dialog\"><div class=\"modal-content\"><div class=\"modal-header\"><button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button><h4 class=\"modal-title\" id=\"topicModalLabel\">Topic Information</h4></div>\n  <div class=\"modal-body\" id=\"topicBody\"><h5>Top Words</h5><ul id=\"word-list\"><li id=\"high-prob\">Highest Probability: </li><li id=\"frex\">FREX: </li><li id=\"lift\">Lift: </li><li id=\"score\">Score: </li></ul><hr><h5>Topic Proportion in Corpus</h5><p id=\"proportion\"></p><hr><h5>Representative Documents</h5><div id=\"doc1\" class=\"modal-body scrollbox\"></div>\n  <br><div id=\"doc2\" class=\"modal-body scrollbox\"></div><div class=\"modal-footer\"><button type=\"button\" class=\"btn btn-default\" data-dismiss=\"modal\">Close</button></div></div><div class=\"modal-body\" id=\"modelBody\"><h5>Summary</h5><span id=\"mod1-text\"></span><br><br><div class=\"modal-footer\">\n  <button type=\"button\" class=\"btn btn-default\" data-dismiss=\"modal\">Close</button></div></div><div class=\"modal-body\" id=\"clusterBody\"><h5>Summary</h5><span id=\"clust1-text\"></span><br><br><div class=\"modal-footer\">\n  <button type=\"button\" class=\"btn btn-default\" data-dismiss=\"modal\">Close</button></div></div></div></div></body>")
    fileConn <- file(file_out)
    writeLines(paste0(header, JSON, footer), fileConn)
    close(fileConn)
    if (display == TRUE) {
        viewer <- getOption("viewer")
        if (!is.null(viewer)) 
            viewer(file_out)
        else utils::browseURL(file_out)
    }
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
