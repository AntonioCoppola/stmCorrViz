HTMLWidgets.widget({

  name: 'stmCorrViz_htmlwidget',

  type: 'output',

  initialize: function(el, width, height) {

    return {};

  },

  renderValue: function(el, x, instance) {
    // clear out in case of dynamic/Shiny
    d3.select(el).select("svg").html("");
    
    var width = el.getBoundingClientRect().width,
        height = el.getBoundingClientRect().height;
    
    var margin={top:30,right:20,bottom:30,left:20};
    
    var barHeight=20,barWidth=width*.8;
    
    var i=0,
        duration=400,
        root;
    
    var tree=d3.layout.tree().nodeSize([0,20]);
    
    var diagonal=d3.svg.diagonal()
                   .projection(function(d){
                     return[d.y,d.x];
                   });
                   
    var svg=d3.select(el).select("svg")
              .attr("width",width+margin.left+margin.right)
              .attr("height",height+margin.top+margin.bottom)
              .append("g")
                .attr(
                  "transform",
                  "translate("+margin.left+","+margin.top+")"
                );
                
    root= x.stmJSON;
    
    root.x0=0;
    root.y0=0;
    
    update(root);
    
    function update(source){
      var nodes=tree.nodes(root);
      var height=Math.max(500,nodes.length*barHeight+margin.top+margin.bottom);
      
      d3.select(el).select("svg")
        .transition()
        .duration(duration)
        .attr("height",height);
        
      d3.select(self.frameElement)
        .transition()
        .duration(duration)
        .style("height",height+"px");
        
      nodes.forEach(function(n,i){n.x=i*barHeight;});
      
      var node=svg.selectAll("g.node")
                  .data(nodes,function(d){
                    return d.id||(d.id=++i);
                  });
      var nodeEnter=node.enter().append("g")
                .attr("class",function(d){
                  if(d.size){
                    return"node leaf"
                  } else {
                    return"node noleaf"
                  }
                })
                .attr("transform",function(d){
                  return "translate("+source.y0+","+source.x0+")";
                })
                .style("opacity",1e-6);
      nodeEnter.append("rect")
                .data(nodes)
                .attr("y",-barHeight/2)
                .attr("height",barHeight)
                .attr("width",barWidth)
                .style("fill",color)
                .on("click",clickModal);
      
      nodeEnter.append("text")
                .attr("dy",3.5)
                .attr("dx",5.5)
                .text(function(d){
                  if (d.children){
                    return d.name;
                  } else {
                    return d.topic_no + ": " + d.name;
                  }
                });
                
      svg.selectAll("g.noleaf")
                .append("svg:foreignObject")
                .attr("width",20)
                .attr("height",20)
                .attr("y","-10px")
                .attr("x",barWidth-15)
                .append("xhtml:span")
                .attr("class","control glyphicon glyphicon-minus")
                .attr("width","30")
                .on("click",function(d){
                  click(d);
                });
                
      nodeEnter
        .transition()
        .duration(duration)
        .attr("transform",function(d){
          return"translate("+d.y+","+d.x+")";
        })
        .style("opacity",1);
                
      node
        .transition()
        .duration(duration)
        .attr("transform",function(d){
          return"translate("+d.y+","+d.x+")";
        })
        .style("opacity",1)
        .select("rect")
        .style("fill",color);
        
      node
        .exit()
        .transition()
        .duration(duration)
        .attr("transform",function(d){
          return"translate("+source.y+","+source.x+")";
        })
        .style("opacity",1e-6)
        .remove();
        
      var link=svg.selectAll("path.link")
                  .data(tree.links(nodes),function(d){
                      return d.target.id;
                  });
      
      link.enter().insert("path","g")
                  .attr("class","link")
                  .attr("d",function(d){
                    var o={x:source.x0,y:source.y0};
                    return diagonal({source:o,target:o});
                  })
                  .transition()
                  .duration(duration)
                  .attr("d",diagonal);
                  
      link
        .transition()
        .duration(duration)
        .attr("d",diagonal);
      
      link
        .exit()
        .transition()
        .duration(duration)
        .attr("d",function(d){
          var o={x:source.x,y:source.y};
          return diagonal({source:o,target:o});
        })
        .remove();
        
      nodes.forEach(function(d){
        d.x0=d.x;d.y0=d.y;
      });
    }
    
    function click(d){
      if(d.children){
        d._children=d.children;
        d.children=null;
      } else {
        d.children=d._children;
        d._children=null;
      }
      
      update(d);
    }
    
    function color(d){
      return d._children?"#3182bd":d.children?"#c6dbef":"#fd8d3c";
    }
    
    function clickModal(d){
      if(d.size){
        $("#doc1").text(d.thought_1);
        $("#doc2").text(d.thought_2);
        $("#high-prob").text("Highest Probability: "+d.prob);
        $("#topicModalLabel").text("Topic "+d.topic_no+" Information");
        $("#frex").text("FREX: "+d.frex);
        $("#lift").text("Lift: "+d.lift);
        $("#score").text("Score: "+d.score);
        $("#proportion").text(""+d.proportion);
        $("#modelBody").hide();
        $("#clusterBody").hide();
        $("#topicBody").show();
        $("#topicModal").modal("show");
      } else if(d.this_root){
        $("#topicModalLabel").text("Fitted Model Information");
        $("#mod1-text").text(d.summary);
        $("#topicBody").hide();
        $("#clusterBody").hide();
        $("#modelBody").show();
        $("#topicModal").modal("show");
        if ($("#barchartDiv").children().length == 2){
          proportionChart();
        }
      } else {
        $("#topicModalLabel").text("Cluster Information");
        $("#clust1-text").text("This cluster comprises topics "+d.topic_no.join(", ")+".");
        $("#topicBody").hide();
        $("#modelBody").hide();
        $("#clusterBody").show();
        $("#topicModal").modal("show");
      }
    }
    
    function proportionChart(){
      for(var t=window.innerHeight/3.5,a=window.innerWidth/2.5,r=35,e=35,n=root.proportions.length,o=[.5];o.length<n;)
      o.push(o[o.length]+1);
      var i=d3.select("#barchartDiv").append("svg")
              .attr({
                width:a,
                height:t,
                style:"display: block; margin: auto;"
              }),
          l=d3.scale.linear()
              .domain([0,d3.max(root.proportions)])
              .range([0,t-r]),
          s=d3.scale.linear()
              .domain([0,n])
              .range([0,a-e]),
          d=d3.scale.linear()
              .domain([0,d3.max(root.proportions)])
              .range([t-r,0]),
          p=d3.svg.axis()
              .scale(d)
              .orient("left"),
          c=d3.svg.axis()
              .scale(s)
              .orient("bottom")
              .tickValues(d3.range(.5,n+.5,1));
              
        i.selectAll("rect")
          .data(root.proportions)
          .enter()
          .append("rect")
          .attr({
            x:function(t,r){return r*(a-e)/n+e},
            y:function(a){return t-l(a)-r},
            width:(a-e)/n-1,
            height:l,fill:"orange"
          })
        
        i.append("g")
          .attr({
            "class":"x axis",
            transform:"translate("+e+","+(t-r)+")"
          })
          .call(c)
        
        i.append("g")
          .attr({
            "class":"axis",
            transform:"translate("+e+")"
          })
          .call(p)
        
        i.append("text")
          .attr("class","x label")
          .attr("text-anchor","middle")
          .attr("x",a/2)
          .attr("y",t-6)
          .text("Topic")
    }
  },

  resize: function(el, width, height, instance) {

  }

});
