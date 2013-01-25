
<div class="span12">
	<h2>
		<g:message code="tasks.label" default="Tasks" />
	</h2>
	<hr />
</div>
<div class="row">
	<div class="span12">
		<table class="table table-bordered table-striped table-hover">
			<thead>
				<tr>
					<th><g:message code="task.description.label"
							default="Description" /></th>

					<th><g:message code="task.responsible.label"
							default="Responsible" /></th>

					<th><g:message code="task.type.label" default="Type" /></th>

					<th><g:message code="task.status.label" default="Status" /></th>
					
					<th><g:message code="default.reported.minutes.label" default="Reported Minutes" /></th>
					
					<th><g:message code="default.minutes.to.finish.label" default="Minutes to finish" /></th>

					<th><g:message code="default.actions.label" default="Actions" /></th>
				</tr>
			</thead>
			<tbody>
				<g:each in="${requirementInstance?.tasks}" status="i"
					var="taskInstance">
					<tr>
						<td>
							${fieldValue(bean: taskInstance, field: "description")}
						</td>

						<td>
							${fieldValue(bean: taskInstance, field: "responsible")}
						</td>

						<td>
							${fieldValue(bean: taskInstance, field: "type")}
						</td>

						<td>
							${fieldValue(bean: taskInstance, field: "status")}
						</td>

						<td>
							${taskInstance?.reportedMinutes}
						</td>

						<td>
							${taskInstance?.lastEstimation?.minutes ?: ""}
						</td>

						<td>
							<div class="btn-group">
								<a class="btn btn-warning dropdown-toggle"
									data-toggle="dropdown" href="#"> <g:message
										code="default.actions.label" default="Actions" /> <span
									class="caret"></span>
								</a>
								<ul class="dropdown-menu">
									<li><g:link controller="task" action="show"
											id="${taskInstance?.id}">
											<i class="icon-eye-open"></i>
											<g:message code="default.show.label" args="['']" />
										</g:link></li>
									<li><g:link controller="task" action="edit"
											id="${taskInstance?.id}">
											<i class="icon-edit"></i>
											<g:message code="default.edit.label" args="['']" />
										</g:link></li>
									<li><a class="delete-item"
										data-url="${createLink(controller: 'task', action: 'delete')}"
										data-id="${taskInstance?.id}"
										data-question="${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}"
										href="#"> <i class="icon-trash"></i> <g:message
												code="default.button.delete.label" default="Delete" />
									</a></li>
									<g:if test="${!taskInstance?.isFinished()}">
										<li><g:link controller="estimation" action="create"
												params="['task.id': taskInstance?.id]">
												<i class="icon-calendar"></i>
												<g:message code="default.create.label" args="['Estimation']" />
											</g:link></li>
									</g:if>
									<g:if test="${taskInstance?.isReadyToReport()}">
										<li><g:link controller="activity" action="create"
												params="['task.id': taskInstance?.id]">
												<i class="icon-time"></i>
												<g:message code="default.create.label" args="['Activity']" />
											</g:link></li>
									</g:if>
								</ul>
							</div>
						</td>
					</tr>
				</g:each>
			</tbody>
		</table>
	</div>
</div>