
<%@ page import="com.trackmanager.Estimation" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'estimation.label', default: 'Estimation')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-estimation" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-estimation" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list estimation">
			
				<g:if test="${estimationInstance?.user}">
				<li class="fieldcontain">
					<span id="user-label" class="property-label"><g:message code="estimation.user.label" default="User" /></span>
					
						<span class="property-value" aria-labelledby="user-label"><g:link controller="user" action="show" id="${estimationInstance?.user?.id}">${estimationInstance?.user?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${estimationInstance?.task}">
				<li class="fieldcontain">
					<span id="task-label" class="property-label"><g:message code="estimation.task.label" default="Task" /></span>
					
						<span class="property-value" aria-labelledby="task-label"><g:link controller="task" action="show" id="${estimationInstance?.task?.id}">${estimationInstance?.task?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${estimationInstance?.dateCreated}">
				<li class="fieldcontain">
					<span id="date-label" class="property-label"><g:message code="estimation.date.label" default="Date" /></span>
					
						<span class="property-value" aria-labelledby="date-label"><g:formatDate date="${estimationInstance?.dateCreated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${estimationInstance?.minutes}">
				<li class="fieldcontain">
					<span id="minutes-label" class="property-label"><g:message code="estimation.minutes.label" default="Minutes" /></span>
					
						<span class="property-value" aria-labelledby="minutes-label"><g:fieldValue bean="${estimationInstance}" field="minutes"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${estimationInstance?.id}" />
					<g:link class="edit" action="edit" id="${estimationInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
