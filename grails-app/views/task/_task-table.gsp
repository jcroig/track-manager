<table class="table table-bordered table-striped table-hover">
	<thead>
		<tr>
			<g:sortableColumn property="description"
				title="${message(code: 'task.description.label', default: 'Description')}" />

			<th><g:message code="task.requirement.label"
					default="Requirement" /></th>

			<th><g:message code="task.responsible.label"
					default="Responsible" /></th>

			<g:sortableColumn property="status"
				title="${message(code: 'task.status.label', default: 'Status')}" />

			<g:sortableColumn property="type"
				title="${message(code: 'task.type.label', default: 'Type')}" />

			<th><g:message code="default.actions.label" default="Actions" /></th>
		</tr>
	</thead>
	<tbody>
		<g:each in="${tasks}" status="i"
			var="taskInstance">
			<tr>
				<td><g:link controller="task" action="show"
						id="${taskInstance.id}">
						${fieldValue(bean: taskInstance, field: "description")}
					</g:link></td>

				<td>
					${fieldValue(bean: taskInstance, field: "requirement")}
				</td>

				<td>
					${fieldValue(bean: taskInstance, field: "responsible")}
				</td>

				<td>
					${fieldValue(bean: taskInstance, field: "status")}
				</td>

				<td>
					${fieldValue(bean: taskInstance, field: "type")}
				</td>

				<td>
					<div class="btn-group">
						<a class="btn btn-warning dropdown-toggle" data-toggle="dropdown"
							href="#"> <g:message code="default.actions.label"
								default="Actions" /> <span class="caret"></span>
						</a>
						<ul class="dropdown-menu">
							<li><g:link controller="task" action="edit"
									id="${taskInstance.id}">
									<i class="icon-edit"></i>
									<g:message code="default.edit.label" args="['']" />
								</g:link></li>
							<li><a class="delete-item"
								data-url="${createLink(controller: 'task', action: 'delete')}"
								data-id="${taskInstance?.id}" href="#"> <i
									class="icon-trash"></i> <g:message
										code="default.button.delete.label" default="Delete" />
							</a></li>
							<li><g:link controller="activity" action="create" params="['task.id': taskInstance.id]">
								<i class="icon-time"></i>
								<g:message code="default.create.label" args="['Activity']"/>
							</g:link>
						</ul>
					</div>
				</td>
			</tr>
		</g:each>
	</tbody>
</table>
<div class="pagination">
	<g:paginate total="${tasks?.size()}" />
</div>