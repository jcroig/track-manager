
<%@ page import="com.trackmanager.Requirement" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'requirement.label', default: 'Requirement')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	<r:require module="list-view"/>
	</head>
	<body>
	<div id="show-requirement" class="container" role="main">
		<div class="row">
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
		<div class="row">
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
				<div class="span11 offset1">
					<g:form>
						<div>
							<g:hiddenField name="id" value="${requirementInstance?.id}" />
							<g:link class="btn btn-primary" action="edit"
								id="${requirementInstance?.id}">
								<i class="icon-edit icon-white"></i>
								<g:message code="default.button.edit.label" default="Edit" />
							</g:link>
							<g:actionSubmit class="btn" action="delete"
								value="${message(code: 'default.button.delete.label', default: 'Delete')}"
								onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
						</div>
					</g:form>
				</div>
			</div>
		</div>
		<g:if test="${requirementInstance?.tasks}">
			<div class="row"><div class="span12">&nbsp;</div></div>
			<div class="row">
				<div class="span12">
					<h2>
						<g:message code="default.list.label" args="['Tasks']" />
					</h2>
					<hr />
				</div>
				<div class="row">
					<div class="span12">

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

									<th><g:message code="default.actions.label"
											default="Actions" /></th>
								</tr>
							</thead>
							<tbody>
								<g:each in="${requirementInstance?.tasks}" status="i" var="taskInstance">
									<tr>
										<td><g:link controller="task" action="show" id="${taskInstance.id}">
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
												<a class="btn btn-warning dropdown-toggle" data-toggle="dropdown" href="#">
													<g:message code="default.actions.label" default="Actions" />
													<span class="caret"></span> 
												</a>
												<ul class="dropdown-menu">
													<li>
														<g:link controller="task", action="edit" id="${taskInstance.id}">
															<i class="icon-edit"></i>
															<g:message code="default.edit.label" args="['']" />
														</g:link>
													</li>
													<li>
														<a class="delete-item" data-url="${createLink(controller: 'task', action: 'delete')}" data-id="${taskInstance?.id}" href="#">
															<i class="icon-trash"></i> 
															<g:message code="default.button.delete.label" default="Delete" />
														</a>
													</li>
												</ul>
											</div>
										</td>
									</tr>
								</g:each>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</g:if>
	</div>
</body>
</html>
