<h2>
	<g:message code="statistics.label" default="Statistics" />
</h2>
<hr />
<div class="row-fluid">
	<div class="span12">
		<dl class="dl-horizontal">
			<dt>
				<g:message code="reported.minutes.label" default="Reported minutes" />:
			</dt>
			<dd>
				${requirementInstance?.reportedMinutes}
			</dd>
			<dt>
				<g:message code="estimated.minutes.to.finish.label" default="Estimated minutes to finish" />:
			</dt>
			<dd>
				${requirementInstance?.estimatedMinutesToFinish}
			</dd>
		</dl>
	</div>
</div>