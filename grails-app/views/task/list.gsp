
<%@ page import="com.trackmanager.Task"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main">
<g:set var="entityName" value="${message(code: 'task.label', default: 'Task')}" />
<title><g:message code="default.list.label" args="[entityName]" /></title>
<r:require module="list-view"/>
</head>
<body>
	<div class="row">
		<div class="container-fluid">
			<div class="row-fluid">
				<div class="span2">
					<div class="row-fluid"><div class="span12">&nbsp;</div></div>
					<div class="row-fluid"><div class="span12">&nbsp;</div></div>
					<div class="row-fluid"><div class="span12">&nbsp;</div></div>
					<div class="row-fluid">
						<div class="span12">
							<div class="row-fluid">
								<div class="span12">
									<a class="btn-large btn-inverse span12" href="${createLink(uri: '/')}">
										<i class="icon-home icon-white"></i><g:message code="default.home.label" />
									</a>
								</div>
							</div>
							<div class="row-fluid">
								<div class="span12">
									<g:link class="btn-large btn-primary span12" action="create">
										<i class="icon-plus-sign icon-white"></i><g:message code="default.new.label" args="['']" />
									</g:link>
								</div>
							</div>	
							<div class="row-fluid">
								<div class="span12">
									<g:link class="btn-large btn-info span12">
										<i class="icon-search icon-white"></i><g:message code="default.search.label" default="Search"/>
									</g:link>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="span10">
					<div class="row-fluid">
						<div class="span12">
							<h1>
								<g:message code="default.list.label" args="[entityName]" />
							</h1>
							<hr/>
						</div>
					</div>
					<g:if test="${flash.message}">
						<div class="row-fluid">
							<div class="span12">
								<div class="alert alert-info" role="status">
									${flash.message}
								</div>
							</div>
						</div>
					</g:if>
					<g:if test="${taskInstanceList}">
						<div class="row-fluid">
							<div class="span12">
								<g:render template="task-table" model="['tasks': taskInstanceList]" />
							</div>
						</div>
					</g:if>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
