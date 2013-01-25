
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
			<g:render template="show-requirement-section" model="['entityName': entityName, 'requirementInstance': requirementInstance]" />
		</div>
		<g:if test="${requirementInstance?.tasks}">
		<div class="row">
			<g:render template="show-tasks-section" model="['requirementInstance': requirementInstance]" />
		</div>
		</g:if>
		<g:if test="${requirementInstance?.activities}">
		<div class="row">
			<g:render template="show-activities-section" model="['requirementInstance': requirementInstance]" />
		</div>
		</g:if>
		<div class="row">
			<g:render template="show-statistics-section" model="['requirementInstance': requirementInstance]" />
		</div>
	</body>
</html>
