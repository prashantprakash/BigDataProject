<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Rival Rooster</title>

<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
 <script src="http://code.jquery.com/jquery-migrate-1.2.1.js"></script>
<link href="css/bootstrap.min.css" rel="stylesheet">


<script type="text/javascript" src="js/jquery.jqplot.min.js"></script>
<script type="text/javascript" src="js/jqplot.barRenderer.min.js"></script>
<script type="text/javascript"
	src="js/jqplot.categoryAxisRenderer.min.js"></script>
<!-- <script type="text/javascript" src="js/jqplot.pointLabels.min.js"></script> -->
<!-- <script type="text/javascript" src="js/jquery-1.11.1.min.js"></script> -->
<script src="js/bootstrap.min.js"></script>

<script type="text/javascript" src="js/jqplot.highlighter.min.js"></script>
<script type="text/javascript" src="js/jqplot.canvasTextRenderer.min.js"></script>
<script type="text/javascript" src="js/jqplot.canvasAxisTickRenderer.min.js"></script>
<!-- Custom CSS -->
<link href="css/sb-admin.css" rel="stylesheet">
<!-- Custom Fonts -->
<link href="font-awesome/css/font-awesome.min.css" rel="stylesheet"
	type="text/css">
<link rel="stylesheet" type="text/css" href="css/jquery.jqplot.min.css" />
<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    
    <script>
    $(document).ready(function(){
    	var s1 = [20,25,30,40,10,35,40];
    	var s2 = [50,15,42,30,24,18,24];
    	var l6 = [11, 9, 5, 12, 14, 8, 7, 9, 6, 11, 9, 3, 4];
    	var ticks = ['Aug','Sept', 'Oct', 'Nov', 'Dec','Jan','Feb'];
    	var ticks1 = [[1,'Dec 10'], [2,'Jan 11'], [3,'Feb 11'], [4,'Mar 11'], [5,'Apr 11'], [6,'May 11'], [7,'Jun 11'], [8,'Jul 11'], [9,'Aug 11'], [10,'Sep 11'], [11,'Oct 11'], [12,'Nov 11'], [13,'Dec 11']];
    	plotBarChart('chart1',ticks,s1);
    	plotBarChart('chart2',ticks,s2);
    	plotLineChart('chart3',l6,ticks1);
    	plotLineChart('chart4',l6,ticks1);
    });
    
    function plotLineChart(chart,l6,ticks) {
    	plot2 = $.jqplot(chart,[l6],{
    	       stackSeries: true,
    	       showMarker: false,
    	       highlighter: {
    	        show: true,
    	        showTooltip: false
    	       },
    	       seriesDefaults: {
    	           fill: true,
    	       },
    	       series: [
    	        {label: 'Hourly Usage'}
    	       ],
    	       legend: {
    	        show: true,
    	        placement: 'insideGrid'
    	       },
    	       grid: {
    	        drawBorder: false,
    	        shadow: false
    	       },
    	       axes: {
    	           xaxis: {
    	              ticks: ticks,
    	              tickRenderer: $.jqplot.CanvasAxisTickRenderer,
    	              tickOptions: {
    	                angle: -90 
    	              },
    	              drawMajorGridlines: false
    	          }           
    	        }
    	    });
    	     
    	    // capture the highlighters highlight event and show a custom tooltip.
    	    $('#'+chart).bind('jqplotHighlighterHighlight', 
    	        function (ev, seriesIndex, pointIndex, data, plot) {
    	            // create some content for the tooltip.  Here we want the label of the tick,
    	            // which is not supplied to the highlighters standard tooltip.
    	            var content = plot.series[seriesIndex].label + ', ' + plot.series[seriesIndex]._xaxis.ticks[pointIndex][1] + ', ' + data[1];
    	            // get a handle on our custom tooltip element, which was previously created
    	            // and styled.  Be sure it is initiallly hidden!
    	            var elem = $('#customTooltipDiv');
    	            elem.html(content);
    	            // Figure out where to position the tooltip.
    	            var h = elem.outerHeight();
    	            var w = elem.outerWidth();
    	            var left = ev.pageX - w - 10;
    	            var top = ev.pageY - h - 10;
    	            // now stop any currently running animation, position the tooltip, and fade in.
    	            elem.stop(true, true).css({left:left, top:top}).fadeIn(200);
    	        }
    	    );
    	     
    	    // Hide the tooltip when unhighliting.
    	    $('#'+chart).bind('jqplotHighlighterUnhighlight', 
    	        function (ev) {
    	            $('#customTooltipDiv').fadeOut(300);
    	        }
    	    );
    }
    
    function plotBarChart(chart,ticks,s1){
    	$.jqplot.config.enablePlugins = true;
        
         
        plot1 = $.jqplot(chart, [s1], {
            // Only animate if we're not using excanvas (not in IE 7 or IE 8)..
            animate: !$.jqplot.use_excanvas,
            seriesDefaults:{
                renderer:$.jqplot.BarRenderer,
                pointLabels: { show: true }
            },
            axes: {
                xaxis: {
                    renderer: $.jqplot.CategoryAxisRenderer,
                    ticks: ticks
                }
            },
            highlighter: { show: false }
        });
        $('#'+chart).bind('jqplotDataClick', 
            function (ev, seriesIndex, pointIndex, data) {
                $('#info1').html('series: '+seriesIndex+', point: '+pointIndex+', data: '+data);
            }
        );
    }
    
    </script>
</head>
<body>
	<div id="wrapper" style="padding-left: 0px;">
		<div id="page-wrapper">
			<div id="customTooltipDiv">
			</div>
			<div class="container-fluid">
				<div class="row">
					<div class="col-xs-6">
						<div class="panel panel-green">
							<div class="panel-heading">
								<h3 class="panel-title">
									<i class="fa fa-clock-o fa-fw"></i> Last 6 months stats
								</h3>
							</div>
							<div class="panel-body">
								<div id="chart1"></div>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="panel panel-green">
							<div class="panel-heading">
								<h3 class="panel-title">
									<i class="fa fa-clock-o fa-fw"></i> Last 6 months stats
								</h3>
							</div>
							<div class="panel-body">
								<div id="chart2"></div>
							</div>
						</div>
					</div>

				</div> <!-- end of row1 -->
				
				<div class="row">
					<div class="col-xs-6">
						<div class="panel panel-green">
							<div class="panel-heading">
								<h3 class="panel-title">
									<i class="fa fa-clock-o fa-fw"></i> Last 24 hours Usage
								</h3>
							</div>
							<div class="panel-body">
								<div id="chart3"></div>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="panel panel-green">
							<div class="panel-heading">
								<h3 class="panel-title">
									<i class="fa fa-clock-o fa-fw"></i> Last 24 hours Usage
								</h3>
							</div>
							<div class="panel-body">
								<div id="chart4"></div>
							</div>
						</div>
					</div>

				</div> <!-- end of row2 -->

			</div>
			<!-- end of container -->

		</div>
		<!-- end of page-wrapper -->

	</div>
	<!-- end of wrapper -->
</body>
</html>