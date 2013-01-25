<div class="span12">
	<h2>
		<g:message code="default.show.label" args="[entityName]" />
	</h2>
	<hr />
</div>
</div>
<g:if test="${flash.message}">
	<div class="row">
		<div class="span12">
			<div class="alert alert-success" role="status">
				${flash.message}
			</div>
		</div>
	</div>
</g:if>
<div class="row well">
	<div class="span12">
		<dl class="dl-horizontal">

			<g:if test="${requirementInstance?.mantis}">
				<dt>
					<g:message code="requirement.mantis.label" default="Mantis" />
				</dt>
				<dd>
					<g:fieldValue bean="${requirementInstance}" field="mantis" />
				</dd>
			</g:if>

			<g:if test="${requirementInstance?.title}">
				<dt>
					<g:message code="requirement.title.label" default="Title" />
				</dt>
				<dd>
					<g:fieldValue bean="${requirementInstance}" field="title" />
				</dd>
			</g:if>

			<g:if test="${requirementInstance?.description}">
				<dt>
					<g:message code="requirement.description.label"
						default="Description" />
				</dt>
				<dd>
					<g:fieldValue bean="${requirementInstance}" field="description" />
				</dd>
			</g:if>

			<g:if test="${requirementInstance?.status}">
				<dt>
					<g:message code="requirement.status.label" default="Status" />
				</dt>
				<dd>
					<g:fieldValue bean="${requirementInstance}" field="status" />
				</dd>
			</g:if>
		</dl>
	</div>
	<div class="row">
		<div class="span1 offset10">
			<div class="btn-group">
				<a class="btn btn-warning dropdown-toggle" data-toggle="dropdown"
					href="#"> <g:message code="default.actions.label"
						default="Actions" /> <span class="caret"></span>
				</a>
				<ul class="dropdown-menu">
					<li><g:link action="edit"
							id="${requirementInstance?.id}">
							<i class="icon-edit"></i>
							<g:message code="default.edit.label" args="['']" />
						</g:link></li>
					<li><a class="delete-item"
						data-url="${createLink(action: 'delete')}"
						data-id="${requirementInstance?.id}" href="#"> <i class="icon-trash"></i>
							<g:message code="default.button.delete.label" default="Delete" />
					</a></li>
					<li><g:link controller="task" action="create"
							params="['requirement.id': requirementInstance?.id]">
							<i class="icon-tasks"></i>
							<g:message code="default.create.label" args="['Task']" />
						</g:link></li>
				</ul>
			</div>
		</div>
	</div>