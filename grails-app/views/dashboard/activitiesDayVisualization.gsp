<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'activity.label', default: 'Activity')}" />
        <link rel="stylesheet"  href="${resource(dir:'css/charts',file:'base.css')}" type="text/css"/>
        <link rel="stylesheet"  href="${resource(dir:'css/charts',file:'BarChart.css')}" type="text/css" />
        <title><g:message code="activity.daily.label" default="Actividad diaria" /></title>
        <!--[if IE]><script language="javascript" type="text/javascript" src="${resource(dir:'js/jit/extras',file:'excanvas.js')}"></script><![endif]-->
        <script src="${resource(dir:'js/jit',file:'jit.js')}" type="text/javascript"></script>
        <script src="${resource(dir:'js/jit',file:'jit-yc.js')}" type="text/javascript"></script>
        <script type="text/javascript">
	        var labelType, useGradients, nativeTextSupport, animate;
	    	
	        (function() {
	          var ua = navigator.userAgent,
	              iStuff = ua.match(/iPhone/i) || ua.match(/iPad/i),
	              typeOfCanvas = typeof HTMLCanvasElement,
	              nativeCanvasSupport = (typeOfCanvas == 'object' || typeOfCanvas == 'function'),
	              textSupport = nativeCanvasSupport 
	                && (typeof document.createElement('canvas').getContext('2d').fillText == 'function');
	          //I'm setting this based on the fact that ExCanvas provides text support for IE
	          //and that as of today iPhone/iPad current text support is lame
	          labelType = (!nativeCanvasSupport || (textSupport && !iStuff))? 'Native' : 'HTML';
	          nativeTextSupport = labelType == 'Native';
	          useGradients = nativeCanvasSupport;
	          animate = !(iStuff || !nativeCanvasSupport);
	        })();
        </script>
        <jq:jquery>		        
	        function iniChart(){
	          //init data
	          var json = { 
	              'label': [<g:join in="${activities*.task.id}"/>],
	              'values': [
	              {
	                'label': '<g:formatDate date="${date}" format="dd/MM/yyyy"/>',
	                'values': [<g:join in="${activities*.minutes}"/>]
	              }]
	          };
	          //end

	            //init BarChart
	         var barChart = new $jit.BarChart({
	              //id of the visualization container
	              injectInto: 'infovis',
	              //whether to add animations
	              animate: true,
	              //horizontal or vertical barcharts
	              orientation: 'vertical',
	              //bars separation
	              barsOffset: 20,
	              //visualization offset
	              Margin: {
	                top:5,
	                left: 5,
	                right: 5,
	                bottom:5
	              },
	              //labels offset position
	              labelOffset: 5,
	              //bars style
	              type: useGradients? 'stacked:gradient' : 'stacked',
	              //whether to show the aggregation of the values
	              showAggregates:true,
	              //whether to show the labels for the bars
	              showLabels:true,
	              //labels style
	              Label: {
	                type: labelType, //Native or HTML
	                size: 13,
	                family: 'Arial',
	                color: 'white'
	              },
	              //add tooltips
	              Tips: {
	                enable: true,
	                onShow: function(tip, elem) {
	                  tip.innerHTML = "<b>" + elem.name + "</b>: " + elem.value;
	                }
	              },
	              Events: {
		              enable: true,
		              onClick: function(elem, eventInfo, evt) {
		              	document.location = '${request.contextPath}' + '/task/show/'+ elem.name
		              }		
	              }
	            });
	            //load JSON data.
	            barChart.loadJSON(json);
	            //end
	        }        	
        	iniChart();
        </jq:jquery>
    </head>
    <body>
    	<div id="center-container">
    		<div id="infovis"></div>
    	</div>		
    </body>
</html>