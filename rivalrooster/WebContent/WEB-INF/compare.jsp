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
  
<!-- <script type="text/javascript" src="js/jquery-1.11.1.min.js"></script> -->
<script src="js/bootstrap.min.js"></script>

<script type="text/javascript" src="js/jqplot.highlighter.min.js"></script>
<script type="text/javascript" src="js/jqplot.canvasTextRenderer.min.js"></script>
<script type="text/javascript" src="js/jqplot.canvasAxisTickRenderer.min.js"></script>
<script type="text/javascript" src="js/FlexGauge.js"></script>
<script type="text/javascript" src="js/jqplot.pieRenderer.min.js"></script>
<!--  <script type="text/javascript" src="js/jqplot.pointLabels.min.js"></script>-->
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
    
 <style type="text/css">
 
 	.fg-dial {
                font-size: 200%;
                font-weight: bold;
                left: 0;
                position: absolute;
                text-align: center;
                top: 100px;
                width: 100%;
            }
 </style>
    
    <script>
    $(document).ready(function(){
    	var s1 = [20,25,30,40,10,35,40];
    	var s2 = [50,15,42,30,24,18,24];
    	var l6 = [11, 9, 5, 12, 14, 8, 7, 9, 6, 11, 9, 3, 4];
    	var ticks = ['Aug','Sept', 'Oct', 'Nov', 'Dec','Jan','Feb'];
    	
    	//plotBarChart('chart1',ticks,s1);
    	//plotBarChart('chart2',ticks,s2);
    	//plotLineChart('chart3',l6,ticks1);
    	//plotLineChart('chart4',l6,ticks1);
    	
    	//var u1 = [2, 6, 7, 10];
        //var u2 = [7, 5, 3, 2];
        //var tickuser= ["pp","pp","pp","pp"];
        //plottopKUsersChart('chart5',u1,u2,tickuser)
        //plottopKUsersChart('chart6',u1,u2,tickuser)
        /*var gauge = new FlexGauge({
        	appendTo: '#chartleft',
        	dialValue: true,
        	arcFillInt: 20.5,
            arcFillTotal: 100
        });
        
        var gauge = new FlexGauge({
        	appendTo: '#chartright',
        	dialValue: true,
        	arcFillInt: 10,
            arcFillTotal: 100
        });*/
         
        
        /*var pieticks =[[['Verwerkende industrie', 9],['Retail', 8], ['Primaire producent', 7], 
                	    ['Out of home', 6],['Groothandel', 5], ['Grondstof', 4], ['Consument', 3], ['Bewerkende industrie', 2]]];
        
        plotPieChart('chart7',pieticks);
        plotPieChart('chart8',pieticks); */
        
        //var sentticks = [[['postive',345],['negative',456]]];
        //plotPieChart('chart9', sentticks);
        //plotPieChart('chart10', sentticks);
        $("#submitcompare").click(function(){
        	//alert("hi");
        	console.log();
        	$("#chart1").empty();
        	$("#chart2").empty();
        	$("#chart3").empty();
        	$("#chart4").empty();
        	$("#chart5").empty();
        	$("#chart6").empty();
        	$("#chart7").empty();
        	$("#chart8").empty();
        	if($( "#smedia" ).val()=="fb"){
        		console.log($("#tocmp").val());
        		plotchartsFacebook($("#frmcmp").val(),$("#tocmp").val());
        	} else if($( "#smedia" ).val()=="twt") {
        		plotchartsTwitter($("#frmcmp").val(),$("#tocmp").val());
        	}
        });
        var tagdata;
        var option;
        $('#smedia').change(function() {
            var idx = this.selectedIndex;        
            console.log(idx);
            console.log($( "#smedia" ).val());
            console.log($( "#smedia option:selected" ).text());
            $("#frmcmp").empty();
            $("#tocmp").empty();
            if(idx==1){
            	option=1;
            	$.getJSON( "operation?choice=tags", function( data ) {
            		tagdata = data;
            		for (i = 0; i < data.length; ++i) {
            			$("#frmcmp").append("<option value="+data[i].pageID+">"+data[i].pageName+"</option>");
            		}
            		
            	});
            	
            	
            }else if(idx==2){
            	option=2;
            	$.getJSON( "toperation?choice=tags", function( data ) {
            		tagdata = data;
            		for (i = 0; i < data.length; ++i) {
            			$("#frmcmp").append("<option value="+data[i]+">"+data[i]+"</option>");
            		}
            		
            	});
            }
            //$("select#selected").prop('selectedIndex', idx);  
        });
        
        $("#frmcmp").change(function(){
    		var idx = this.selectedIndex;
    		console.log(idx);
    		$("#tocmp").empty();
    		for (i = 0; i < tagdata.length; ++i) {
    			if(option==1) {
    			if(tagdata[i].pageID != $( "#frmcmp" ).val() ){
    				$("#tocmp").append("<option value="+tagdata[i].pageID+">"+tagdata[i].pageName+"</option>");
    			}
    			} else if(option==2) {
    				if(tagdata[i] != $( "#frmcmp" ).val() ){
    				$("#tocmp").append("<option value="+tagdata[i]+">"+tagdata[i]+"</option>");
    				}
    			}
    		}
    	});
        
        
    });
    function plotchartsTwitter (pageid1, pageid2) {
    	$.getJSON( "toperation?choice=monthusage&pagename="+pageid1, function( data ) {
    		plottopKUsersChart('chart1',data.values1,data.values2,data.xticks);
    	});
    	
		$.getJSON( "toperation?choice=monthusage&pagename="+pageid2, function( data ) {
			plottopKUsersChart('chart2',data.values1,data.values2,data.xticks);
    	});
		
		// end of 6 months usage plot
		
		// line chart 24 hours usage 
    	$.getJSON( "toperation?choice=hoursusage&pagename="+pageid1, function( data ) {
    		var arrayfinal = new Array();
    		for(i =0 ; i <data.xticks.length; i++) {
    			var arrayinner = new Array();
    			arrayinner[0] = i+1;
    			arrayinner[1] = data.xticks[i];
    			arrayfinal[i] = arrayinner;
    		}
    		console.log(arrayfinal);
    		plotLineChart('chart3',data.values,arrayfinal);
    	});
    	
		$.getJSON( "toperation?choice=hoursusage&pagename="+pageid2, function( data ) {
			var arrayfinal = new Array();
    		for(i =0 ; i <data.xticks.length; i++) {
    			var arrayinner = new Array();
    			arrayinner[0] = i+1;
    			arrayinner[1] = data.xticks[i];
    			arrayfinal[i] = arrayinner;
    		}
    		console.log(arrayfinal);
    		plotLineChart('chart4',data.values,arrayfinal);
    	});
    
    	
    	// end of line chart
    
    	// pie chart for location
		$.getJSON( "toperation?choice=location&pagename="+pageid1, function( data ) {
        	var pieticks = new Array(); 
        	for(i=0;i<data.xticks.length;i++) {
        		var pieinnerticks = new Array();
        		pieinnerticks[0] =data.xticks[i];
        		pieinnerticks[1] = data.values[i];
        		pieticks[i] = pieinnerticks;
        	}
        	console.log([pieticks]);
        	plotPieChart('chart7',[pieticks]);
        });
        
        $.getJSON( "toperation?choice=location&pagename="+pageid2, function( data ) {
        	var pieticks = new Array(); 
        	for(i=0;i<data.xticks.length;i++) {
        		var pieinnerticks = new Array();
        		pieinnerticks[0] =data.xticks[i];
        		pieinnerticks[1] = data.values[i];
        		pieticks[i] = pieinnerticks;
        	}
        	console.log([pieticks]);
        	plotPieChart('chart8',[pieticks]);
        });
    	// end of pie chart location  
    
    	
    	// pie chart for sentiments 
    	$.getJSON( "toperation?choice=sentiments&pagename="+pageid1, function( data ) {
    		 var sentticks = [[['postive',data[0]],['negative',data[1]]]];
    	     plotPieChart('chart9', sentticks);
    	     
    	});
    	
		$.getJSON( "toperation?choice=sentiments&pagename="+pageid2, function( data ) {
			var sentticks = [[['postive',data[0]],['negative',data[1]]]];
   	     	plotPieChart('chart10', sentticks);
    	});
    	// end of pie chart for sentiments
    	
    	// gauge 
    	 $.getJSON( "toperation?choice=score&pagename="+pageid1, function( data ) {
        	var gauge = new FlexGauge({
            	appendTo: '#chartleft',
            	dialValue: true,
            	arcFillInt: data,
                arcFillTotal: 100
            });
            
        });
        
        $.getJSON( "toperation?choice=score&pagename="+pageid2, function( data ) {
        	var gauge = new FlexGauge({
            	appendTo: '#chartright',
            	dialValue: true,
            	arcFillInt: data,
                arcFillTotal: 100
            });
            
        });
    	
    	// end of gauge
    	
    	
     // plot top k user charts
    	$.getJSON( "toperation?choice=topkusers&pagename="+pageid1, function( data ) {
    		//plottopKUsersChart('chart5',data.values1,data.values2,data.xticks);
    		plotBarChart('chart5',data.xticks,data.values);
    	});
    	
		$.getJSON( "toperation?choice=topkusers&pagename="+pageid2, function( data ) {
			//plottopKUsersChart('chart6',data.values1,data.values2,data.xticks);
			plotBarChart('chart6',data.xticks,data.values);
    	});
		
    }
   		
    function plotchartsFacebook(pageid1, pageid2) {
    	// plot 6 months stats 
    	
        $.getJSON( "operation?choice=score&pageid="+pageid1, function( data ) {
        	var gauge = new FlexGauge({
            	appendTo: '#chartleft',
            	dialValue: true,
            	arcFillInt: data,
                arcFillTotal: 100
            });
            
        });
        
        $.getJSON( "operation?choice=score&pageid="+pageid2, function( data ) {
        	var gauge = new FlexGauge({
            	appendTo: '#chartright',
            	dialValue: true,
            	arcFillInt: data,
                arcFillTotal: 100
            });
            
        });
    	
    	$.getJSON( "operation?choice=monthusage&pageid="+pageid1, function( data ) {
    		plottopKUsersChart('chart1',data.values1,data.values2,data.xticks);
    	});
    	
		$.getJSON( "operation?choice=monthusage&pageid="+pageid2, function( data ) {
			plottopKUsersChart('chart2',data.values1,data.values2,data.xticks);
    	});
    	
    	//  end of plot 6 months stats
    
    	// plot top k user charts
    	$.getJSON( "operation?choice=topkusers&pageid="+pageid1, function( data ) {
    		plottopKUsersChart('chart5',data.values1,data.values2,data.xticks);
    	});
    	
		$.getJSON( "operation?choice=topkusers&pageid="+pageid2, function( data ) {
			plottopKUsersChart('chart6',data.values1,data.values2,data.xticks);
    	});
    	
    	// end of top k users charts
    	
    	// pie chart for sentiments 
    	$.getJSON( "operation?choice=sentiments&pageid="+pageid1, function( data ) {
    		 var sentticks = [[['postive',data[0]],['negative',data[1]]]];
    	     plotPieChart('chart9', sentticks);
    	     
    	});
    	
		$.getJSON( "operation?choice=sentiments&pageid="+pageid2, function( data ) {
			var sentticks = [[['postive',data[0]],['negative',data[1]]]];
   	     	plotPieChart('chart10', sentticks);
    	});
    	// end of pie chart for sentiments
    	
    	// line chart 24 hours usage 
    	$.getJSON( "operation?choice=hoursusage&pageid="+pageid1, function( data ) {
    		//var ticks1 = [[1,'Dec 10'], [2,'Jan 11'], [3,'Feb 11'], [4,'Mar 11'], [5,'Apr 11'], [6,'May 11'], [7,'Jun 11'], [8,'Jul 11'], [9,'Aug 11'], [10,'Sep 11'], [11,'Oct 11'], [12,'Nov 11'], [13,'Dec 11']];
    		//var ticks1 = "[";
    		var arrayfinal = new Array();
    		for(i =0 ; i <data.xticks.length; i++) {
    			var arrayinner = new Array();
    			/*if(i==data.xticks.length-1) {
    				ticks1 += "["+(i+1)+",'"+data.xticks[i]+"']";
    				break;
    			}*/
    			//ticks1 += "["+(i+1)+",'"+data.xticks[i]+"'],";
    			arrayinner[0] = i+1;
    			arrayinner[1] = data.xticks[i];
    			arrayfinal[i] = arrayinner;
    		}
    		//ticks1+= "]";
    		//console.log(ticks1);
    		console.log(arrayfinal);
    		//var ticks1 =[[1,'3 AM'],[2,'4 AM'],[3,'4 PM'],[4,'10 PM']];
    		plotLineChart('chart3',data.values,arrayfinal);
    	});
    	
		$.getJSON( "operation?choice=hoursusage&pageid="+pageid2, function( data ) {
			var arrayfinal = new Array();
    		for(i =0 ; i <data.xticks.length; i++) {
    			var arrayinner = new Array();
    			/*if(i==data.xticks.length-1) {
    				ticks1 += "["+(i+1)+",'"+data.xticks[i]+"']";
    				break;
    			}*/
    			//ticks1 += "["+(i+1)+",'"+data.xticks[i]+"'],";
    			arrayinner[0] = i+1;
    			arrayinner[1] = data.xticks[i];
    			arrayfinal[i] = arrayinner;
    		}
    		//ticks1+= "]";
    		//console.log(ticks1);
    		console.log(arrayfinal);
    		//var ticks1 =[[1,'3 AM'],[2,'4 AM'],[3,'4 PM'],[4,'10 PM']];
    		plotLineChart('chart4',data.values,arrayfinal);
    	});
    
    	
    	// end of line chart
    	
    	// pie chart for location 
    	//var pieticks =[[['Verwerkende industrie', 9],['Retail', 8], ['Primaire producent', 7], 
          //      	    ['Out of home', 6],['Groothandel', 5], ['Grondstof', 4], ['Consument', 3], ['Bewerkende industrie', 2]]];
        
        
        //plotPieChart('chart8',pieticks);
    	
        $.getJSON( "operation?choice=location&pageid="+pageid1, function( data ) {
        	var pieticks = new Array(); 
        	for(i=0;i<data.xticks.length;i++) {
        		var pieinnerticks = new Array();
        		pieinnerticks[0] =data.xticks[i];
        		pieinnerticks[1] = data.values[i];
        		pieticks[i] = pieinnerticks;
        	}
        	console.log([pieticks]);
        	plotPieChart('chart7',[pieticks]);
        });
        
        $.getJSON( "operation?choice=location&pageid="+pageid2, function( data ) {
        	var pieticks = new Array(); 
        	for(i=0;i<data.xticks.length;i++) {
        		var pieinnerticks = new Array();
        		pieinnerticks[0] =data.xticks[i];
        		pieinnerticks[1] = data.values[i];
        		pieticks[i] = pieinnerticks;
        	}
        	console.log([pieticks]);
        	plotPieChart('chart8',[pieticks]);
        });
    	// end of pie chart location  
    }
    
    
    
    
    function plottopKUsersChart(chart , u1 , u2,ticks) {
    	plot3 = $.jqplot(chart, [u1, u2], {
    		stackSeries: true,
            captureRightClick: true,
            seriesDefaults:{
                renderer:$.jqplot.BarRenderer,
                shadowAngle: 135,
                rendererOptions: {
                    barDirection: 'vertical',
                    highlightMouseDown: true   
                },
                pointLabels: {show: true, formatString: '%d'}
            },
            series: [
         	        {label: 'likes'}
         	       ],
            legend: {
                show: true,
                location: 'e',
                placement: 'inside'
            },
            axesDefaults: {
            	        tickRenderer: $.jqplot.CanvasAxisTickRenderer ,
            	        tickOptions: {
            	          fontFamily: 'Georgia',
            	          fontSize: '10pt',
            	          angle: -30
            	        }
           	},
            axes: {
                xaxis: {
                	ticks: ticks,
                    renderer: $.jqplot.CategoryAxisRenderer,
                    tickOptions: {
    	                angle: -30 
    	            }
                }
            }
        });
     
        
    }
    
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
    	            var left = ev.pageX - w - 10 +800;
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
            axesDefaults: {
            	        tickRenderer: $.jqplot.CanvasAxisTickRenderer ,
            	        tickOptions: {
            	          fontFamily: 'Georgia',
            	          fontSize: '10pt',
            	          angle: -30
            	        }
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
    
    
    function plotPieChart(chart,pieticks) {
    	
    	jQuery.jqplot.config.enablePlugins = true;
    	  plot7 = jQuery.jqplot(chart,pieticks , 
    	    {
    	      title: ' ', 
    	      seriesDefaults: {shadow: true, renderer: jQuery.jqplot.PieRenderer, rendererOptions: { showDataLabels: true } }, 
    	      legend: { show:true }
    	    }
    	  );
    	
    }
    
    </script>
</head>
<body>
	<div class="navbar-wrapper" style="height: 50px;">
		<div class="container" style="height: 50px;">

			<nav class="navbar navbar-inverse navbar-static-top"
				style="height: 50px;">
			<div class="container">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle collapsed"
						data-toggle="collapse" data-target="#navbar" aria-expanded="false"
						aria-controls="navbar">
						<span class="sr-only">Toggle navigation</span> <span
							class="icon-bar"></span> <span class="icon-bar"></span> <span
							class="icon-bar"></span>
					</button>
					<a class="navbar-brand" href="#">Rival Roosters.</a>
				</div>
				<div id="navbar" class="navbar-collapse collapse">
					<ul class="nav navbar-nav">
						<li class="active"><a href="#">Home</a></li>
						<li><a href="#about">About</a></li>
						<li><a href="#contact">Contact</a></li>
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-expanded="false">Dropdown
								<span class="caret"></span>
						</a>
							<ul class="dropdown-menu" role="menu">
								<li><a href="#">Action</a></li>
								<li><a href="#">Another action</a></li>
								<li><a href="#">Something else here</a></li>
								<li class="divider"></li>
								<li class="dropdown-header">Nav header</li>
								<li><a href="#">Separated link</a></li>
								<li><a href="#">One more separated link</a></li>
							</ul></li>
					</ul>
				</div>
			</div>
			</nav>

		</div>
	</div>
	<div id="wrapper" style="padding-left: 0px;">
		<div id="page-wrapper" style="padding-left: 10%; padding-right: 10%;min-height:95vh;">
			<div id="myCarousel" class="carousel slide" data-ride="carousel"
				style="margin-bottom: 20px;">
				<!-- Indicators -->
				<ol class="carousel-indicators">
					<li data-target="#myCarousel" data-slide-to="0" class=""></li>
					<li data-target="#myCarousel" data-slide-to="1" class=""></li>
					<li data-target="#myCarousel" data-slide-to="2" class="active"></li>
					<li data-target="#myCarousel" data-slide-to="3" class=""></li>
					<li data-target="#myCarousel" data-slide-to="4" class=""></li>
				</ol>
				<div class="carousel-inner" role="listbox">
					<div class="item">
						<img style="width: 100%; height: 250px" class="first-slide"
							src="http://ak.picdn.net/shutterstock/videos/3378923/preview/stock-footage-green-blue-abstract-tech-background-loopable.jpg"
							alt="First slide">
						<div class="container">
							<div class="carousel-caption">
								<h1>Rival Roosters</h1>
								<p>
									Hello !!!! We are  
									<code>Rival Roosters://</code>
									We help companies to check their over all score on different
									social media web sites. Isn't it cool :). Just one click and 
									you can comapare your company to others.
								</p>
								<p>
									<a class="btn btn-lg btn-primary" href="#" role="button">Sign
										up today</a>
								</p>
							</div>
						</div>
					</div>
					<div class="item active">
						<img style="width: 100%; height: 250px" class="second-slide"
							src="http://fc02.deviantart.net/fs70/i/2010/337/d/7/aurora_borealis_green_and_blue_by_titusboy25-d1mnee6.jpg"
							alt="Second slide">
						<div class="container">
							<div class="carousel-caption">
								<h1>Facebook</h1>
								<p>You have a page on facebook? you want to see what's your page 
									score on facebook. DO you want to see what's the score of other pages 
									on facebook similar to yours? Its only one click away</p>
								<p>
									<a class="btn btn-lg btn-primary" href="#" role="button">Learn
										more</a>
								</p>
							</div>
						</div>
					</div>
					<div class="item">
						<img style="width: 100%; height: 250px" class="third-slide"
							src="http://lafozi.com/files/images/green_fireworks_2-wide.jpg"
							alt="Third slide">
						<div class="container">
							<div class="carousel-caption">
								<h1>Twitter</h1>
								<p>You have a page on Twitter? you want to see what's your page 
									score on Twitter. DO you want to see what's the score of other pages 
									on Twitter similar to yours? Its only one click away</p>
								<p>
									<a class="btn btn-lg btn-primary" href="#" role="button">Browse
										gallery</a>
								</p>
							</div>
						</div>
					</div>
					<div class="item">
						<img style="width: 100%; height: 250px" class="forth-slide"
							src="http://2.bp.blogspot.com/-9FdUrn0g6JQ/Th9UPjg8PqI/AAAAAAAALK8/S5RO_h-aBlQ/s1600/Best-top-desktop-abstract-pattern-wallpapers-hd-wallpaper-pattern-pictures-and-images-25.jpg"
							alt="Forth slide">
						<div class="container">
							<div class="carousel-caption">
								<h1>Facebook</h1>
								<p>You have a page on facebook? you want to see what's your page 
									score on facebook. DO you want to see what's the score of other pages 
									on facebook similar to yours? Its only one click away</p>
								<p>
									<a class="btn btn-lg btn-primary" href="#" role="button">Learn
										more</a>
								</p>
							</div>
						</div>
					</div>
					<div class="item">
						<img style="width: 100%; height: 250px" class="fifth-slide"
							src="http://3.bp.blogspot.com/-Wth9o5wVrN0/Th9VOdIzuJI/AAAAAAAALLw/fVTsQJgPyfM/s640/Best-top-desktop-abstract-pattern-wallpapers-hd-wallpaper-pattern-pictures-and-images-38.jpg"
							alt="Fifth slide">
						<div class="container">
							<div class="carousel-caption">
								<h1>Twitter</h1>
								<p>You have a page on Twitter? you want to see what's your page 
									score on Twitter. DO you want to see what's the score of other pages 
									on Twitter similar to yours? Its only one click away</p>
								<p>
									<a class="btn btn-lg btn-primary" href="#" role="button">Browse
										gallery</a>
								</p>
							</div>
						</div>
					</div>
				</div>
				<a class="left carousel-control" href="#myCarousel" role="button"
					data-slide="prev"> <span
					class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
					<span class="sr-only">Previous</span>
				</a> <a class="right carousel-control" href="#myCarousel" role="button"
					data-slide="next"> <span
					class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
					<span class="sr-only">Next</span>
				</a>
			</div>
			
			<div class="container-fluid" style="padding-bottom: 15px">
				<div class="row">
					<div class="col-xs-4"
						style="padding-left: 0px; padding-right: 0px;">
						<span>Social Media :</span> <span><select id="smedia" class="form-control"
							style="display: inline; width: 50%;">
								<option value="select">-Select-</option>
								<option value="fb">Facebook</option>
								<option value="twt">Twitter</option>
						</select> </span>
					</div>
					
					<div class="col-xs-3"
						style="padding-left: 0px; padding-right: 0px;">
						<span>Compare Fr:</span> <span><select id="frmcmp" class="form-control"
							style="display: inline; width: 50%;">
								<!--  <option>1</option>
								<option>2</option>
								<option>3</option>
								<option>4</option>
								<option>5</option>-->
								
						</select> </span>
					</div>
					<div class="col-xs-3"
						style="padding-left: 0px; padding-right: 0px;">
						<span>Compare To :</span> <span><select id="tocmp" class="form-control"
							style="display: inline; width: 50%;">
								<!--  <option>1</option>
								<option>2</option>
								<option>3</option>
								<option>4</option>
								<option>5</option>-->
								
						</select> </span>
					</div>
					
					
					<div class="col-xs-2"
						style="padding-left: 20px; padding-right: 0px;">
						<button id="submitcompare" style="width: 100%;" type="submit" class="btn btn-primary">Compare</button>
					</div>
				</div>
			</div>
			<div id="customTooltipDiv">
			</div>
			<div class="container-fluid">
				<div class="row">
					<div class="col-xs-6">
						<div class="panel panel-green">
							<div class="panel-heading">
								<h3 class="panel-title">
									<i class="fa fa-clock-o fa-fw"></i> Overall Score
								</h3>
							</div>
							<div class="panel-body">
								<div id="chartleft" style="margin-left:24%;"></div>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="panel panel-green">
							<div class="panel-heading">
								<h3 class="panel-title">
									<i class="fa fa-clock-o fa-fw"></i> Overall Score
								</h3>
							</div>
							<div class="panel-body">
								<div id="chartright" style="margin-left:24%;"></div>
							</div>
						</div>
					</div>

				</div> <!-- end of gauge row -->
								
				
				
				
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
				
				<div class="row">
					<div class="col-xs-6">
						<div class="panel panel-green">
							<div class="panel-heading">
								<h3 class="panel-title">
									<i class="fa fa-clock-o fa-fw"></i> top 10 users
								</h3>
							</div>
							<div class="panel-body">
								<div id="chart5"></div>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="panel panel-green">
							<div class="panel-heading">
								<h3 class="panel-title">
									<i class="fa fa-clock-o fa-fw"></i> top 10 users
								</h3>
							</div>
							<div class="panel-body">
								<div id="chart6"></div>
							</div>
						</div>
					</div>

				</div> <!-- end of row3 -->
				
				<div class="row">
					<div class="col-xs-6">
						<div class="panel panel-green">
							<div class="panel-heading">
								<h3 class="panel-title">
									<i class="fa fa-clock-o fa-fw"></i> User Sentiments
								</h3>
							</div>
							<div class="panel-body">
								<div id="chart9"></div>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="panel panel-green">
							<div class="panel-heading">
								<h3 class="panel-title">
									<i class="fa fa-clock-o fa-fw"></i> User Sentiments
								</h3>
							</div>
							<div class="panel-body">
								<div id="chart10"></div>
							</div>
						</div>
					</div>

				</div> <!-- end of row 4 -->
				<div class="row">
					<div class="col-xs-6">
						<div class="panel panel-green">
							<div class="panel-heading">
								<h3 class="panel-title">
									<i class="fa fa-clock-o fa-fw"></i> Top 5 states distribution
								</h3>
							</div>
							<div class="panel-body">
								<div id="chart7"></div>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="panel panel-green">
							<div class="panel-heading">
								<h3 class="panel-title">
									<i class="fa fa-clock-o fa-fw"></i> Top 5 states distribution
								</h3>
							</div>
							<div class="panel-body">
								<div id="chart8"></div>
							</div>
						</div>
					</div>

				</div> <!-- end of row 5 -->

			</div>
			<!-- end of container -->

		</div>
		<!-- end of page-wrapper -->

	</div>
	<!-- end of wrapper -->
	<div class="footer" style="min-height:5vh;">
      <div class="container">
		<p style="color: white;" class="copyright">Copyright © 2015 Big Data Project- Rival Rooster 2015</p>
      </div>
    </div>
</body>
</html>