$(function() {
  console.log("Loaded Bro!");
  $('.button').click(function() {
    $.ajax('/tweets/start')
  });
  var source = new EventSource('/tweets/search_results'),
      message;
  source.addEventListener('tweets.create', function (e) {
    tweet = JSON.parse(e.data);
    console.log(tweet);
  });

    var width = 600,
        height = 500;

    var projection = d3.geo.mercator()
        .center([0, 0 ])
        .scale(100)
        // .rotate([-180,0])
        .translate([width / 2, height / 2]);;

    var svg = d3.select("body").append("svg")
        .attr("width", width)
        .attr("height", height);

    var path = d3.geo.path()
        .projection(projection);

    var g = svg.append("g");

    // load and display the World
    d3.json("/assets/topo.json", function(error, topology) {

    // load and display the cities
      d3.json("/tweets/search_results", function(error, data) {
      //     var colorsArr = ["red", "green", "blue", "purple", "coral", "yellow"];
      //     var randomNum = function(min, max) {
      //   return Math.floor(Math.random() * (max - min)) + min;
      // }
          console.log(data)
          g.selectAll("circle")
             .data(data)
             .enter()
             .append("a")
      				  // .attr("xlink:href", function(d) {
      					//   return "https://www.google.com/search?q="+d.city;}
      				  // )
             .append("circle")
             .attr("cx", function(d) {
                    console.log(d.coordinates[0]);
                    return projection([d.coordinates[1], d.coordinates[0]])[0];
                    // return projection([d.lon, d.lat])[0];
             })
             .attr("cy", function(d) {
                     return projection([d.coordinates[1], d.coordinates[0]])[1];
                    // console.log(d);
                    // return projection([d.lon, d.lat])[0];
             })
             .attr("r", 3)
           .style("fill", /*colorsArr[randomNum(0, 5)]*/  "red");
      });


    g.selectAll("path")
          .data(topojson.object(topology, topology.objects.countries)
              .geometries)
        .enter()
          .append("path")
          .attr("d", path)
    });

    // zoom and pan
    // var zoom = d3.behavior.zoom()
    //     .on("zoom",function() {
    //         g.attr("transform","translate("+
    //             d3.event.translate.join(",")+")scale("+d3.event.scale+")");
    //         g.selectAll("circle")
    //             .attr("d", path.projection(projection));
    //         g.selectAll("path")
    //             .attr("d", path.projection(projection));
    //
    //     });

    // svg.call(zoom)

  });
