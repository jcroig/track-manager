
<%@ page import="com.trackmanager.Requirement"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main">
<g:set var="entityName"
	value="${message(code: 'requirement.label', default: 'Requirement')}" />
<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>
<body>
	<div class="row">
		<div class="container-fluid">
			<div class="row-fluid">
				<div class="span2">
					<div class="row-fluid">
						<div class="span12">&nbsp;</div>
					</div>
					<div class="row-fluid">
						<div class="span12">&nbsp;</div>
					</div>
					<div class="row-fluid">
						<div class="span12">
							<a class="btn btn-inverse" href="${createLink(uri: '/')}">
								<i class="icon-home icon-white"></i> <g:message
									code="default.home.label" />
							</a>
						</div>
					</div>
					<div class="row-fluid">
						<div class="span12">
							<g:link class="btn btn-primary" action="create">
								<i class="icon-plus-sign icon-white"></i>
								<g:message code="default.new.label" args="['']" />
							</g:link>
						</div>
					</div>
					<div class="row-fluid">
						<div class="span12">
							<g:link class="btn btn-info" action="create">
								<i class="icon-search icon-white"></i>
								<g:message code="default.search.label" default="Search"/>
							</g:link>
						</div>
					</div>
				</div>
				<div class="span10">
					<div class="row-fluid">
						<div class="span12">
							<h2>
								<g:message code="default.list.label" args="[entityName]" />
							</h2>
						</div>
					</div>
					<g:if test="${flash.message}">
						<div class="row-fluid">
							<div class="span12">
								<div class="message" role="status">
									${flash.message}
								</div>
							</div>
						</div>
					</g:if>
					<div class="row-fluid">
						<div class="span12">
							<table class="table table-bordered table-striped table-hover">
								<thead>
									<tr>
										<g:sortableColumn property="mantis"
											title="${message(code: 'requirement.mantis.label', default: 'Mantis')}" />

										<g:sortableColumn property="title"
											title="${message(code: 'requirement.title.label', default: 'Title')}" />

										<g:sortableColumn property="description"
											title="${message(code: 'requirement.description.label', default: 'Description')}" />

										<g:sortableColumn property="status"
											title="${message(code: 'requirement.status.label', default: 'Status')}" />
									</tr>
								</thead>
								<tbody>
									<g:each in="${requirementInstanceList}" status="i"
										var="requirementInstance">
										<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

											<td><g:link action="show" id="${requirementInstance.id}">
													${fieldValue(bean: requirementInstance, field: "mantis")}
												</g:link></td>

											<td>
												${fieldValue(bean: requirementInstance, field: "title")}
											</td>

											<td>
												${fieldValue(bean: requirementInstance, field: "description")}
											</td>

											<td>
												${fieldValue(bean: requirementInstance, field: "status")}
											</td>

										</tr>
									</g:each>
								</tbody>
							</table>
							<div class="pagination">
								<g:paginate total="${requirementInstanceTotal}" />
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
