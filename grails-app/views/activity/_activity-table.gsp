<table class="table table-bordered table-striped table-hover">
	<thead>
		<tr>
			<th><g:message code="activity.user.label" default="User" /></th>

			<th><g:message code="activity.task.label" default="Task" /></th>

			<g:sortableColumn property="date"
				title="${message(code: 'activity.date.label', default: 'Date')}" />

			<g:sortableColumn property="minutes"
				title="${message(code: 'activity.minutes.label', default: 'Minutes')}" />

			<g:sortableColumn property="observations"
				title="${message(code: 'activity.observations.label', default: 'Observations')}" />

			<th><g:message code="activity.estimationToFinishTask.label"
					default="Estimation to finish task" /></th>

			<th><g:message code="default.actions.label" default="Actions" /></th>
		</tr>
	</thead>
	<tbody>
		<g:each in="${activities}" status="i" var="activityInstance">
			<tr>
				<td><g:link controller="activity" action="show" id="${activityInstance.id}">
						${fieldValue(bean: activityInstance, field: "user")}
					</g:link></td>

				<td>
					${fieldValue(bean: activityInstance, field: "task")}
				</td>

				<td><g:formatDate date="${activityInstance.date}" /></td>

				<td>
					${fieldValue(bean: activityInstance, field: "minutes")}
				</td>

				<td>
					${fieldValue(bean: activityInstance, field: "observations")}
				</td>

				<td>
					${fieldValue(bean: activityInstance, field: "estimationToFinishTask")}
				</td>

				<td>
					<div class="btn-group">
						<a class="btn btn-warning dropdown-toggle" data-toggle="dropdown"
							href="#"> <g:message code="default.actions.label"
								default="Actions" /> <span class="caret"></span>
						</a>
						<ul class="dropdown-menu">
							<li><g:link controller="task" action="edit"
									id="${activityInstance?.id}">
									<i class="icon-edit"></i>
									<g:message code="default.edit.label" args="['']" />
								</g:link></li>
							<li><a class="delete-item"
								data-url="${createLink(controller: 'task', action: 'delete')}"
								data-id="${activityInstance?.id}" href="#"> <i
									class="icon-trash"></i> <g:message
										code="default.button.delete.label" default="Delete" />
							</a></li>
						</ul>
					</div>
				</td>
			</tr>
		</g:each>
	</tbody>
</table>