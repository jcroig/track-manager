<%@ page import="com.trackmanager.Task" %>



<div class="fieldcontain ${hasErrors(bean: taskInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="task.description.label" default="Description" />
		
	</label>
	<g:textField name="description" value="${taskInstance?.description}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: taskInstance, field: 'requirement', 'error')} required">
	<label for="requirement">
		<g:message code="task.requirement.label" default="Requirement" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="requirement" name="requirement.id" from="${com.trackmanager.Requirement.list()}" optionKey="id" required="" value="${taskInstance?.requirement?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: taskInstance, field: 'responsible', 'error')} ">
	<label for="responsible">
		<g:message code="task.responsible.label" default="Responsible" />
		
	</label>
	<g:select id="responsible" name="responsible.id" from="${com.trackmanager.User.list()}" optionKey="id" value="${taskInstance?.responsible?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: taskInstance, field: 'activities', 'error')} ">
	<label for="activities">
		<g:message code="task.activities.label" default="Activities" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${taskInstance?.activities?}" var="a">
    <li><g:link controller="activity" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="activity" action="create" params="['task.id': taskInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'activity.label', default: 'Activity')])}</g:link>
</li>
</ul>

</div>

<div class="fieldcontain ${hasErrors(bean: taskInstance, field: 'estimations', 'error')} ">
	<label for="estimations">
		<g:message code="task.estimations.label" default="Estimations" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${taskInstance?.estimations?}" var="e">
    <li><g:link controller="estimation" action="show" id="${e.id}">${e?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="estimation" action="create" params="['task.id': taskInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'estimation.label', default: 'Estimation')])}</g:link>
</li>
</ul>

</div>
<g:if test="${taskInstance?.id}">
	<div class="fieldcontain ${hasErrors(bean: taskInstance, field: 'status', 'error')} required">
		<label for="status">
			<g:message code="task.status.label" default="Status" />
			<span class="required-indicator">*</span>
		</label>
		<g:select name="status" from="${com.trackmanager.Task$TaskStatus?.values()}" keys="${com.trackmanager.Task$TaskStatus.values()*.name()}" required="" value="${taskInstance?.status?.name()}"/>
	</div>
</g:if>

<div class="fieldcontain ${hasErrors(bean: taskInstance, field: 'type', 'error')} required">
	<label for="type">
		<g:message code="task.type.label" default="Type" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="type" from="${com.trackmanager.Task$TaskType?.values()}" keys="${com.trackmanager.Task$TaskType.values()*.name()}" required="" value="${taskInstance?.type?.name()}"/>
</div>

