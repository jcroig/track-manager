
<%@ page import="com.trackmanager.Activity" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'activity.label', default: 'Activity')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-activity" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-activity" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th><g:message code="activity.user.label" default="User" /></th>
					
						<th><g:message code="activity.task.label" default="Task" /></th>
					
						<g:sortableColumn property="date" title="${message(code: 'activity.date.label', default: 'Date')}" />
					
						<g:sortableColumn property="minutes" title="${message(code: 'activity.minutes.label', default: 'Minutes')}" />
					
						<g:sortableColumn property="observations" title="${message(code: 'activity.observations.label', default: 'Observations')}" />
					
						<th><g:message code="activity.estimationToFinishTask.label" default="Estimation To Finish Task" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${activityInstanceList}" status="i" var="activityInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${activityInstance.id}">${fieldValue(bean: activityInstance, field: "user")}</g:link></td>
					
						<td>${fieldValue(bean: activityInstance, field: "task")}</td>
					
						<td><g:formatDate date="${activityInstance.date}" /></td>
					
						<td>${fieldValue(bean: activityInstance, field: "minutes")}</td>
					
						<td>${fieldValue(bean: activityInstance, field: "observations")}</td>
					
						<td>${fieldValue(bean: activityInstance, field: "estimationToFinishTask")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${activityInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
