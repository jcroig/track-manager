<%@ page import="com.trackmanager.Estimation" %>



<div class="fieldcontain ${hasErrors(bean: estimationInstance, field: 'user', 'error')} required">
	<label for="user">
		<g:message code="estimation.user.label" default="User" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="user" name="user.id" from="${com.trackmanager.User.list()}" optionKey="id" required="" value="${estimationInstance?.user?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: estimationInstance, field: 'task', 'error')} required">
	<label for="task">
		<g:message code="estimation.task.label" default="Task" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="task" name="task.id" from="${com.trackmanager.Task.list()}" optionKey="id" required="" value="${estimationInstance?.task?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: estimationInstance, field: 'date', 'error')} required">
	<label for="date">
		<g:message code="estimation.date.label" default="Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="date" precision="day"  value="${estimationInstance?.date}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: estimationInstance, field: 'minutes', 'error')} required">
	<label for="minutes">
		<g:message code="estimation.minutes.label" default="Minutes" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="minutes" type="number" min="0" value="${estimationInstance.minutes}" required=""/>
</div>

