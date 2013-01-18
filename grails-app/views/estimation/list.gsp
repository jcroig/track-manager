
<%@ page import="com.trackmanager.Estimation" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'estimation.label', default: 'Estimation')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-estimation" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-estimation" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th><g:message code="estimation.user.label" default="User" /></th>
					
						<th><g:message code="estimation.task.label" default="Task" /></th>
					
						<g:sortableColumn property="date" title="${message(code: 'estimation.date.label', default: 'Date')}" />
					
						<g:sortableColumn property="minutes" title="${message(code: 'estimation.minutes.label', default: 'Minutes')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${estimationInstanceList}" status="i" var="estimationInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${estimationInstance.id}">${fieldValue(bean: estimationInstance, field: "user")}</g:link></td>
					
						<td>${fieldValue(bean: estimationInstance, field: "task")}</td>
					
						<td><g:formatDate date="${estimationInstance.date}" /></td>
					
						<td>${fieldValue(bean: estimationInstance, field: "minutes")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${estimationInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
