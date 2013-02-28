<r:require module="highcharts"/>
<h2>
	<g:message code="statistics.label" default="Statistics" />
</h2>
<hr />
<div class="row-fluid">
	<div class="span3">
		<blockquote>
			<p><g:message code="reported.time.label" default="Reported time" />:</p>
			<small><g:message code="minutes.label" default="Minutes" /></small>
		</blockquote>
	</div>
	<div class="span9">
		<p class="lead">${taskInstance?.reportedMinutes}</p>
	</div>
</div>
<div class="row-fluid">
	<div class="span3">
		<blockquote>
			<p><g:message code="estimated.time.to.finish.label" default="Estimated time to finish" />:</p>
			<small><g:message code="minutes.label" default="Minutes" /></small>
		</blockquote>
	</div>
	<div class="span9">
		<p class="lead">${taskInstance?.lastEstimation?.minutes}</p>
	</div>
</div>
<div class="row-fluid">
	<div class="span12">
		<div id="chart"></div>
	</div>
</div>
<r:script>
$(function () {
    var chart;
    $(document).ready(function() {
        chart = new Highcharts.Chart({
            chart: {
                renderTo: 'chart',
                type: 'line'
            },
            title: {
                text: 'Activities and estimations'
            },
            subtitle: {
                text: 'Distribution'
            },
            xAxis: {
                minTickInterval: 1
            },
            yAxis: {
                title: {
                    text: 'Time (Min)'
                },
                min: 0
            },
            tooltip: {
                enabled: false,
                formatter: function() {
                    return '<b>'+ this.series.name +'</b><br/>'+
                        this.x +': '+ this.y +'°C';
                }
            },
            plotOptions: {
                line: {
                    dataLabels: {
                        enabled: true
                    },
                    enableMouseTracking: false
                }
            },
            series: [{
                name: 'Activities',
                data: ${timeDistributionGraphData.activities.encodeAsJSON()}
            }, {
                name: 'Estimations',
                data: ${timeDistributionGraphData.estimations.encodeAsJSON()}
            }]
        });
    });
    
});
</r:script>
