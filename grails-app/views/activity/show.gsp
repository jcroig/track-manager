
<%@ page import="com.trackmanager.Activity" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'activity.label', default: 'Activity')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-activity" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-activity" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list activity">
			
				<g:if test="${activityInstance?.user}">
				<li class="fieldcontain">
					<span id="user-label" class="property-label"><g:message code="activity.user.label" default="User" /></span>
					
						<span class="property-value" aria-labelledby="user-label"><g:link controller="user" action="show" id="${activityInstance?.user?.id}">${activityInstance?.user?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${activityInstance?.task}">
				<li class="fieldcontain">
					<span id="task-label" class="property-label"><g:message code="activity.task.label" default="Task" /></span>
					
						<span class="property-value" aria-labelledby="task-label"><g:link controller="task" action="show" id="${activityInstance?.task?.id}">${activityInstance?.task?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${activityInstance?.date}">
				<li class="fieldcontain">
					<span id="date-label" class="property-label"><g:message code="activity.date.label" default="Date" /></span>
					
						<span class="property-value" aria-labelledby="date-label"><g:formatDate date="${activityInstance?.date}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${activityInstance?.minutes}">
				<li class="fieldcontain">
					<span id="minutes-label" class="property-label"><g:message code="activity.minutes.label" default="Minutes" /></span>
					
						<span class="property-value" aria-labelledby="minutes-label"><g:fieldValue bean="${activityInstance}" field="minutes"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${activityInstance?.observations}">
				<li class="fieldcontain">
					<span id="observations-label" class="property-label"><g:message code="activity.observations.label" default="Observations" /></span>
					
						<span class="property-value" aria-labelledby="observations-label"><g:fieldValue bean="${activityInstance}" field="observations"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${activityInstance?.estimationToFinishTask}">
				<li class="fieldcontain">
					<span id="estimationToFinishTask-label" class="property-label"><g:message code="activity.estimationToFinishTask.label" default="Estimation To Finish Task" /></span>
					
						<span class="property-value" aria-labelledby="estimationToFinishTask-label"><g:link controller="estimation" action="show" id="${activityInstance?.estimationToFinishTask?.id}">${activityInstance?.estimationToFinishTask?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${activityInstance?.id}" />
					<g:link class="edit" action="edit" id="${activityInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
