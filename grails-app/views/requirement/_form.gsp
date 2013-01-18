<%@ page import="com.trackmanager.Requirement" %>



<div class="fieldcontain ${hasErrors(bean: requirementInstance, field: 'mantis', 'error')} required">
	<label for="mantis">
		<g:message code="requirement.mantis.label" default="Mantis" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="mantis" type="number" value="${requirementInstance.mantis}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: requirementInstance, field: 'title', 'error')} required">
	<label for="title">
		<g:message code="requirement.title.label" default="Title" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="title" required="" value="${requirementInstance?.title}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: requirementInstance, field: 'description', 'error')} required">
	<label for="description">
		<g:message code="requirement.description.label" default="Description" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="description" required="" value="${requirementInstance?.description}"/>
</div>

<g:if test="${requirementInstance?.id}">
	<div class="fieldcontain ${hasErrors(bean: requirementInstance, field: 'status', 'error')} required">
		<label for="status">
			<g:message code="requirement.status.label" default="Status" />
			<span class="required-indicator">*</span>
		</label>
		<g:select name="status" from="${com.trackmanager.Requirement$RequirementStatus?.values()}" keys="${com.trackmanager.Requirement$RequirementStatus.values()*.name()}" required="" value="${requirementInstance?.status?.name()}"/>
	</div>
</g:if>

<div class="fieldcontain ${hasErrors(bean: requirementInstance, field: 'tasks', 'error')} ">
	<label for="tasks">
		<g:message code="requirement.tasks.label" default="Tasks" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${requirementInstance?.tasks?}" var="t">
    <li><g:link controller="task" action="show" id="${t.id}">${t?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="task" action="create" params="['requirement.id': requirementInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'task.label', default: 'Task')])}</g:link>
</li>
</ul>

</div>

