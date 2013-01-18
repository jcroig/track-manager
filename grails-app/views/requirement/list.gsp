
<%@ page import="com.trackmanager.Requirement" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'requirement.label', default: 'Requirement')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-requirement" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-requirement" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="mantis" title="${message(code: 'requirement.mantis.label', default: 'Mantis')}" />
					
						<g:sortableColumn property="title" title="${message(code: 'requirement.title.label', default: 'Title')}" />
					
						<g:sortableColumn property="description" title="${message(code: 'requirement.description.label', default: 'Description')}" />
					
						<g:sortableColumn property="status" title="${message(code: 'requirement.status.label', default: 'Status')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${requirementInstanceList}" status="i" var="requirementInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${requirementInstance.id}">${fieldValue(bean: requirementInstance, field: "mantis")}</g:link></td>
					
						<td>${fieldValue(bean: requirementInstance, field: "title")}</td>
					
						<td>${fieldValue(bean: requirementInstance, field: "description")}</td>
					
						<td>${fieldValue(bean: requirementInstance, field: "status")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${requirementInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
