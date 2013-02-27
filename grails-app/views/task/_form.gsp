<%@ page import="com.trackmanager.Task" %>

<g:hiddenField id="requirement"  name="requirement.id" value="${taskInstance?.requirement?.id}"/>

<div class="control-group ${hasErrors(bean: taskInstance, field: 'description', 'error')} ">
	<label class="control-label" for="description">
		<g:message code="task.description.label" default="Description" />
	</label>
	<div class="controls">
		<g:textField name="description" value="${taskInstance?.description}"/>
	</div>
</div>

<div class="control-group ${hasErrors(bean: taskInstance, field: 'type', 'error')} required">
	<label class="control-label" for="type">
		<g:message code="task.type.label" default="Type" />
		<span class="required-indicator">*</span>
	</label>
	<div class="controls">
		<g:select name="type" from="${com.trackmanager.Task$TaskType?.values()}" keys="${com.trackmanager.Task$TaskType.values()*.name()}" required="" value="${taskInstance?.type?.name()}"/>
	</div>
</div>

<div class="control-group ${hasErrors(bean: taskInstance, field: 'responsible', 'error')} ">
	<label class="control-label" for="responsible">
		<g:message code="task.responsible.label" default="Responsible" />
	</label>
	<div class="controls">
		<g:select id="responsible" name="responsible.id" from="${com.trackmanager.User.list()}" optionKey="id" value="${taskInstance?.responsible?.id}" class="many-to-one" noSelection="['null': '']"/>
	</div>
</div>

<g:if test="${taskInstance?.id}">
	<div class="control-group ${hasErrors(bean: taskInstance, field: 'status', 'error')} required">
		<label class="control-label" for="status">
			<g:message code="task.status.label" default="Status" />
			<span class="required-indicator">*</span>
		</label>
		<div class="controls">
			<g:select name="status" from="${com.trackmanager.Task$TaskStatus?.values()}" keys="${com.trackmanager.Task$TaskStatus.values()*.name()}" required="" value="${taskInstance?.status?.name()}"/>
		</div>
	</div>
</g:if>

