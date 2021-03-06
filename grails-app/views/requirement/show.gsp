
<%@ page import="com.trackmanager.Requirement" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'requirement.label', default: 'Requirement')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	<r:require module="show-view"/>
	</head>
	<body>
		<div id="show-requirement" class="container" role="main">
			<div class="row-fluid">
				<div class="span12">
					<g:render template="show-requirement-section" model="['entityName': entityName, 'requirementInstance': requirementInstance]" />
				</div>
			</div>
			<g:if test="${requirementInstance?.tasks}">
			<div class="row-fluid">
				<div class="span12">
					<g:render template="show-tasks-section" model="['requirementInstance': requirementInstance]" />
				</div>
			</div>
			</g:if>
			<g:if test="${requirementInstance?.activities}">
			<div class="row-fluid">
				<div class="span12">
					<g:render template="/template/show-activities-section" model="['activities': requirementInstance.activities]" />
				</div>
			</div>
			</g:if>
			<g:if test="${requirementInstance?.activities}">
			<div class="row-fluid">
				<div class="span12">
					<g:render template="/template/show-statistics-section" model="['timetableEntityInstance': requirementInstance, 'timeDistributionGraphData': timeDistributionGraphData]" />
				</div>
			</div>
			</g:if>
		</div>
	</body>
</html>
