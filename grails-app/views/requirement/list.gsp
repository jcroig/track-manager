
<%@ page import="com.trackmanager.Requirement"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main">
<g:set var="entityName" value="${message(code: 'requirement.label', default: 'Requirement')}" />
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
					<g:if test="${requirementInstanceList}">
						<div class="row-fluid">
							<div class="span12">
								<table class="table table-bordered table-striped table-hover">
									<thead>
										<tr>
											<g:sortableColumn property="mantis"
												title="${message(code: 'requirement.mantis.label', default: 'Mantis')}" />
	
											<g:sortableColumn property="title"
												title="${message(code: 'requirement.title.label', default: 'Title')}" />
	
											<g:sortableColumn property="status"
												title="${message(code: 'requirement.status.label', default: 'Status')}" />
											
											<th><g:message code="default.actions.label" default="Actions"/></th>
										</tr>
									</thead>
									<tbody>
										<g:each in="${requirementInstanceList}" status="i"
											var="requirementInstance">
											<tr>
	
												<td><g:link action="show" id="${requirementInstance.id}">
														${fieldValue(bean: requirementInstance, field: "mantis")}
													</g:link>
												</td>
	
												<td>
													${fieldValue(bean: requirementInstance, field: "title")}
												</td>
	
												<td>
													${fieldValue(bean: requirementInstance, field: "status")}
												</td>
												
												<td>
													<div class="btn-group">
														<a class="btn btn-warning dropdown-toggle" data-toggle="dropdown"
															href="#"><g:message code="default.actions.label" default="Actions"/><span class="caret"></span>
														</a>
														<ul class="dropdown-menu">
															<li>
																<g:link action="edit" id="${requirementInstance.id}">
																	<i class="icon-edit"></i>
																	<g:message code="default.edit.label" args="['']" />
																</g:link>
															</li>
															<li>
																<a class="delete-item" data-url="${createLink(action: 'delete')}" data-id="${requirementInstance.id}" href="#">
																<i class="icon-trash"></i>
																<g:message code="default.button.delete.label" default="Delete" />
																</a>
															</li>
															<li>
																<g:link controller="task" action="create" params="['requiriment.id': requirementInstance.id]">
																	<i class="icon-tasks"></i>
																	<g:message code="default.create.label" args="['Task']" />
																</g:link>
															</li>
														</ul>
													</div>
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
					</g:if>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
