$(function() {
  console.log("Loaded Bro!");
  $('.button').click(function() {
    $.ajax('/tweets/start')
  });

  var width = 1200,
      height = 1000;

  var projection = d3.geo.mercator()
      .center([0, 0 ])
      .scale(200)
      // .rotate([-180,0])
      .translate([width / 2, height / 2]);

  var source = new EventSource('/tweets/search_results');
  var points = function(data) {

    console.log("at mapping");
    svg.append("g")
      .selectAll("circle")
      .data(data)
      .enter()
      .append("a")
      //     // .attr("xlink:href", function(d) {
      //     //   return "https://www.google.com/search?q="+d.city;}
      //     // )
      .append("circle")
      .attr("cx", function(d) {
        return projection([data[1], data[0]])[0];
      })
      .attr("cy", function(d) {
        return projection([data[1], data[0]])[1];
      })
      .attr("r", 1.25)
      .style("fill","red");
  };

  source.addEventListener('tweets.create', function (e) {
    dataSet = JSON.parse(e.data);
    points(dataSet, g, projection);
  });

});
