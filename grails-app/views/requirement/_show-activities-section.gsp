<div class="span12">
	<h2>
		<g:message code="activities.label" default="Activities" />
	</h2>
	<hr />
</div>
<div class="row">
	<div class="span12">
		<table class="table table-bordered table-striped table-hover">
			<thead>
				<tr>
					<th><g:message code="activity.user.label" default="User" /></th>

					<th><g:message code="activity.task.label" default="Task" /></th>

					<th><g:message code="activity.date.label" default="Date" /></th>

					<th><g:message code="activity.minutes.label" default="Minutes" /></th>

					<th><g:message code="activity.estimationToFinishTask.label"
							default="Estimation to finish task" /></th>

					<th><g:message code="default.actions.label" default="Actions" /></th>
				</tr>
			</thead>
			<tbody>
				<g:each in="${requirementInstance?.activities}" status="i"
					var="activityInstance">
					<tr>
						<td>
							${activityInstance?.user.username}
						</td>

						<td>
							${activityInstance?.task.description}
						</td>

						<td><g:formatDate date="${activityInstance?.date}" /></td>

						<td>
							${fieldValue(bean: activityInstance, field: "minutes")}
						</td>

						<td>
							${activityInstance?.estimationToFinishTask.minutes}
						</td>

						<td>
							<div class="btn-group">
								<a class="btn btn-warning dropdown-toggle"
									data-toggle="dropdown" href="#"> <g:message
										code="default.actions.label" default="Actions" /> <span
									class="caret"></span>
								</a>
								<ul class="dropdown-menu">
									<li><g:link controller="activity" action="show"
											id="${activityInstance?.id}">
											<i class="icon-eye-open"></i>
											<g:message code="default.show.label" args="['']" />
										</g:link></li>
									<li><g:link controller="activity" action="edit"
											id="${activityInstance?.id}">
											<i class="icon-edit"></i>
											<g:message code="default.edit.label" args="['']" />
										</g:link></li>
									<li><a class="delete-item"
										data-url="${createLink(controller: 'activity', action: 'delete')}"
										data-id="${activityInstance?.id}"
										data-question="${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}"
										href="#"> <i class="icon-trash"></i> <g:message
												code="default.button.delete.label" default="Delete" />
									</a></li>
								</ul>
							</div>
						</td>
					</tr>
				</g:each>
			</tbody>
		</table>
	</div>
</div>