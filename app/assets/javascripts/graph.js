/* global d3 */
/* global nv */

function draw_calories(data) {

    var now = new Date();
    var from = new Date().setDate(now.getDate()-15);

    var svg = d3.select("#graph_calories"),
        WIDTH = 850,
        HEIGHT = 400,
        MARGINS = {
            top: 50,
            right: 50,
            bottom: 50,
            left: 150
        },
        xRange = d3.time.scale()
            .domain([from,now])
            .rangeRound([
                MARGINS.left, 
                WIDTH - MARGINS.left - MARGINS.right
            ]),
        yRange = d3.scale.linear()
            .range([
                HEIGHT - MARGINS.top, 
                MARGINS.bottom
            ])
            .domain([0, 4000]),
        xAxis = d3.svg.axis()
            .scale(xRange)
            .orient('bottom')
            .tickFormat(function(d){
                return d3.time.format('%m/%d')(new Date(d));
            }),
        yAxis = d3.svg.axis()
            .scale(yRange)
            .tickSize(5)
            .orient('left')
            .tickSubdivide(true),
        lineFunc = d3.svg.line()
            .interpolate('basis')
            .x(function(d,i){
                return xRange(new Date(d.date));
            })
            .y(function(d){
                return yRange(d.calories);
            });
    
    svg.append('svg:g')
        .attr('class', 'x axis')
        .attr('transform', 'translate(0,' + (HEIGHT - MARGINS.bottom) + ')')
        .call(xAxis);
    
    svg.append("svg:text")
		.attr("transform", "translate(350,390)")
		.attr("text-anchor", "start")
		.text("Date (Month/Day)");

    svg.append('svg:g')
        .attr('class', 'y axis')
        .attr('transform', 'translate(' + (MARGINS.left) + ',0)')
        .call(yAxis);
    
    svg.append("svg:text")
		.attr("transform", "translate(25,200)")
		.attr("text-anchor", "start")
		.text("Calories");
    
    svg.append('svg:path')
      .attr('d', lineFunc(data))
      .attr('stroke', 'Gray')
      .attr('stroke-width', 2)
      .attr('fill', 'none');
    
    /*
    var color = d3.scale.category20b();
    var WIDTH = 800,
        height = 400,
        MARGINS = {
            top: 20,
            right: 20,
            bottom: 20,
            left: 50
        },
        
    xAxis = d3.svg.axis()
        .scale(xScale),
  
    yAxis = d3.svg.axis()
        .scale(yScale);

    var xScale = d3.scale.linear()
        .range([MARGINS.left, WIDTH - MARGINS.right])
        .domain([1, 14]);
    var yScale = d3.scale.linear()
        .range([MARGINS.left, WIDTH - MARGINS.right])
        .domain([d3.min(data), d3.max(data)]);
    */
}

function draw_weights(data) {

    var now = new Date();
    var from = new Date().setDate(now.getDate()-15);

    var svg = d3.select("#graph_weights"),
        WIDTH = 850,
        HEIGHT = 400,
        MARGINS = {
            top: 50,
            right: 50,
            bottom: 50,
            left: 150
        },
        xRange = d3.time.scale()
            .domain([from,now])
            .rangeRound([
                MARGINS.left, 
                WIDTH - MARGINS.left - MARGINS.right
            ]),
        yRange = d3.scale.linear()
            .range([
                HEIGHT - MARGINS.top, 
                MARGINS.bottom
            ])
            .domain([50, 300]), // .domain(d3.extent(data, function(d) { return d.Weight; })),
        xAxis = d3.svg.axis()
            .scale(xRange)
            .orient('bottom')
            .tickFormat(function(d){
                return d3.time.format('%m/%d')(new Date(d));
            }),
        yAxis = d3.svg.axis()
            .scale(yRange)
            .tickSize(5)
            .orient('left')
            .tickSubdivide(true),
        lineFunc = d3.svg.line()
            .interpolate('basis')
            .x(function(d,i){
                return xRange(new Date(d.Date));
            })
            .y(function(d){
                return yRange(d.Weight);
            });
    
    svg.append('svg:g')
        .attr('class', 'x axis')
        .attr('transform', 'translate(0,' + (HEIGHT - MARGINS.bottom) + ')')
        .call(xAxis);
        

    // Add the text label for the x axis
    svg.append("text")
        .attr("transform", "translate(" + (WIDTH / 2) + " ," + (HEIGHT + MARGINS.bottom) + ")")
        .style("text-anchor", "middle")
        .text("Date");
    
    svg.append("svg:text")
		.attr("transform", "translate(350,390)")
		.attr("text-anchor", "start")
		.text("Date (Month/Day)");

    svg.append('svg:g')
        .attr('class', 'y axis')
        .attr('transform', 'translate(' + (MARGINS.left) + ',0)')
        .call(yAxis);
    
    svg.append("svg:text")
		.attr("transform", "translate(20,200)")
		.attr("text-anchor", "start")
		.text("Weight (lb)");
    
    svg.append('svg:path')
      .attr('d', lineFunc(data))
      .attr('stroke', 'Gray')
      .attr('stroke-width', 2)
      .attr('fill', 'none');
}


function error() {
    console.log("error")
}
