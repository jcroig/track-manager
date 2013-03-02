<h2>
	<g:message code="default.show.label" args="[entityName]" />
</h2>
<hr />
<g:if test="${flash.message}">
	<div class="row-fluid">
		<div class="span12">
			<div class="alert alert-success" role="status">
				${flash.message}
			</div>
		</div>
	</div>
</g:if>
<div class="row-fluid">
	<div class="span12 well">
		<dl class="dl-horizontal">
			<g:if test="${taskInstance?.description}">
				<dt>
					<g:message code="task.description.label" default="Description" />
				</dt>
				<dd>
					<g:fieldValue bean="${taskInstance}" field="description"/>
				</dd>					
			</g:if>
			
			<g:if test="${taskInstance?.requirement}">
				<dt>
					<g:message code="task.requirement.label" default="Requirement" />
				</dt>
				<dd>
					<g:link controller="requirement" action="show" id="${taskInstance?.requirement?.id}">${taskInstance?.requirement?.title}</g:link>
				</dd>
			</g:if>
			
			<g:if test="${taskInstance?.responsible}">
				<dt>
					<g:message code="task.responsible.label" default="Responsible" />
				</dt>
				<dd>
					<g:link controller="user" action="show" id="${taskInstance?.responsible?.id}">${taskInstance?.responsible?.encodeAsHTML()}</g:link>
				</dd>
			</g:if>
			
			<g:if test="${taskInstance?.type}">
				<dt>
					<g:message code="task.type.label" default="Type" />
				</dt>
				<dd>
					<g:fieldValue bean="${taskInstance}" field="type"/>
				</dd>
			</g:if>
			
			<g:if test="${taskInstance?.status}">
				<dt>
					<g:message code="task.status.label" default="Status" />
				</dt>
				<dd>
					<g:fieldValue bean="${taskInstance}" field="status"/>
				</dd>
			</g:if>
		</dl>
		<div class="row-fluid">
			<div class="span1 offset10">
				<div class="btn-group">
					<a class="btn btn-warning dropdown-toggle" data-toggle="dropdown"
						href="#"> <g:message code="default.actions.label"
							default="Actions" /> <span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li><g:link action="edit"
								id="${taskInstance?.id}">
								<i class="icon-edit"></i>
								<g:message code="default.edit.label" args="['']" />
							</g:link></li>
						<li><a class="delete-item"
							data-url="${createLink(action: 'delete')}"
							data-question="${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}"
							data-id="${taskInstance?.id}" href="#"> <i class="icon-trash"></i>
								<g:message code="default.button.delete.label" default="Delete" />
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
			</div>
		</div>
	</div>
</div>
