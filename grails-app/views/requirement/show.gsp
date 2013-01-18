
<%@ page import="com.trackmanager.Requirement" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'requirement.label', default: 'Requirement')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-requirement" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-requirement" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list requirement">
			
				<g:if test="${requirementInstance?.mantis}">
				<li class="fieldcontain">
					<span id="mantis-label" class="property-label"><g:message code="requirement.mantis.label" default="Mantis" /></span>
					
						<span class="property-value" aria-labelledby="mantis-label"><g:fieldValue bean="${requirementInstance}" field="mantis"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${requirementInstance?.title}">
				<li class="fieldcontain">
					<span id="title-label" class="property-label"><g:message code="requirement.title.label" default="Title" /></span>
					
						<span class="property-value" aria-labelledby="title-label"><g:fieldValue bean="${requirementInstance}" field="title"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${requirementInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="requirement.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${requirementInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${requirementInstance?.status}">
				<li class="fieldcontain">
					<span id="status-label" class="property-label"><g:message code="requirement.status.label" default="Status" /></span>
					
						<span class="property-value" aria-labelledby="status-label"><g:fieldValue bean="${requirementInstance}" field="status"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${requirementInstance?.tasks}">
				<li class="fieldcontain">
					<span id="tasks-label" class="property-label"><g:message code="requirement.tasks.label" default="Tasks" /></span>
					
						<g:each in="${requirementInstance.tasks}" var="t">
						<span class="property-value" aria-labelledby="tasks-label"><g:link controller="task" action="show" id="${t.id}">${t?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${requirementInstance?.id}" />
					<g:link class="edit" action="edit" id="${requirementInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
