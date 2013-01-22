
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
				<div class="span2 offset10">
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
						<g:render template="/task/task-table" model="['tasks':requirementInstance?.tasks]" />
					</div>
				</div>
			</div>
		</g:if>
	</div>
</body>
</html>
