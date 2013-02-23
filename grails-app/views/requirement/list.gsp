
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
				<div class="span3">
					<div class="row-fluid">
						<div class="span12">
							<g:link class="btn-large btn-primary span12" action="create">
								<i class="icon-plus-sign icon-white"></i><g:message code="default.new.label" args="['']" />
							</g:link>
						</div>
					</div>
					<div class="row-fluid">
						<div class="span12">&nbsp;</div>
					</div>
					<div class="row-fluid">
						<div class="span12">
							<div class="row-fluid">
								<div class="span12">
									<g:form method="post" class="form-horizontal well">
										<fieldset>
											<legend><g:message code="default.filter.label" default="Filter" /></legend>
											<div class="row-fluid">
												<div class="span12">
													<label><g:message code="requirement.mantis.label" default="Mantis" />:</label>
												</div>
											</div>
											<div class="row-fluid">
												<div class="span12">
													<input type="number" name="mantis" value="${mantis}"/>
												</div>
											</div>
											<div class="row-fluid">
												<div class="span12">
													&nbsp;
												</div>
											</div>
											<div class="row-fluid">
												<div class="span12">
													<p><g:message code="requirement.status.label" default="Status" />:</p>
												</div>
											</div>
											<div class="row-fluid">
												<div class="span12">
													<g:select name="status" from="${[' '] + (com.trackmanager.Requirement$RequirementStatus.values() as List)}" keys="${[' '] + (com.trackmanager.Requirement$RequirementStatus.values()*.name() as List)}" required="" value="${status}"/>
												</div>
											</div>
											<div class="row-fluid">
												<div class="span12">
													&nbsp;
													<div class="row-fluid">
														<div class="span12">
															<g:actionSubmit class="btn-info btn-primary" action="list" value="${message(code: 'default.button.search.label', default: 'Search')}" />
														</div>
													</div>
												</div>
											</div>
										</fieldset>
									</g:form>
								</div>
							</div>		
						</div>
					</div>
				</div>
				<div class="span9">
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
												<td>
													${fieldValue(bean: requirementInstance, field: "mantis")}
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
																<g:link action="show" id="${requirementInstance.id}">
																	<i class="icon-eye-open"></i>
																	<g:message code="default.show.label" args="['']" />
																</g:link>
															</li>
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
