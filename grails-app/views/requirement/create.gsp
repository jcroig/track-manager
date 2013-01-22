<%@ page import="com.trackmanager.Requirement" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'requirement.label', default: 'Requirement')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>
		<div id="create-requirement" class="container" role="main">
			<g:if test="${flash.message}">
			<div class="alert alert-info" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${requirementInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${requirementInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form action="save" class="form-horizontal well">
				<fieldset>
					<legend><g:message code="default.create.label" args="[entityName]" /></legend>
					<g:render template="form"/>
				</fieldset>
				<div class="form-actions">
					<g:submitButton name="create" class="btn btn-primary" value="${message(code: 'default.button.create.label', default: 'Create')}" />
				</div>
			</g:form>
		</div>
	</body>
</html>
