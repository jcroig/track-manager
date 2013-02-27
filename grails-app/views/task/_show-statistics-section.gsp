<r:require module="highcharts"/>
<h2>
	<g:message code="statistics.label" default="Statistics" />
</h2>
<hr />
<div class="row-fluid">
	<div class="span3">
		<p><g:message code="reported.minutes.label" default="Reported minutes" />:</p>
	</div>
	<div class="span9">
		<p>${taskInstance?.reportedMinutes}</p>
	</div>
</div>
<div class="row-fluid">
	<div class="span3">
		<p><g:message code="estimated.minutes.to.finish.label" default="Estimated minutes to finish" />:</p>
	</div>
	<div class="span9">
		<p>${taskInstance?.lastEstimation?.minutes}</p>
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
                data: ${hoursActivities.encodeAsJSON()}
            }, {
                name: 'Estimations',
                data: ${hoursEstimated.encodeAsJSON()}
            }]
        });
    });
    
});
</r:script>
