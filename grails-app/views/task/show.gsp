
<%@ page import="com.trackmanager.Task" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'task.label', default: 'Task')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
		<r:require module="show-view"/>
	</head>
	<body>
		<div id="show-task" class="container" role="main">
			<div class="row-fluid">
				<div class="span12">
					<g:render template="show-task-section" model="['entityName': entityName, 'taskInstance': taskInstance]" />
				</div>
			</div>
		
			<g:if test="${taskInstance?.activities}">
				<div class="row-fluid">
					<div class="span12">
						<g:render template="/template/show-activities-section" model="['activities': taskInstance.activities]" />
					</div>
				</div>
				
				<div class="row-fluid">
					<div class="span12">
						<g:render template="/template/show-statistics-section" model="['timetableEntityInstance': taskInstance, 'timeDistributionGraphData': timeDistributionGraphData]" />
					</div>
				</div>
			</g:if>
		</div>
	</body>
</html>
