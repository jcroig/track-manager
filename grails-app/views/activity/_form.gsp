<%@ page import="com.trackmanager.Activity" %>



<div class="fieldcontain ${hasErrors(bean: activityInstance, field: 'user', 'error')} required">
	<label for="user">
		<g:message code="activity.user.label" default="User" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="user" name="user.id" from="${com.trackmanager.User.list()}" optionKey="id" required="" value="${activityInstance?.user?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: activityInstance, field: 'task', 'error')} required">
	<label for="task">
		<g:message code="activity.task.label" default="Task" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="task" name="task.id" from="${com.trackmanager.Task.list()}" optionKey="id" required="" value="${activityInstance?.task?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: activityInstance, field: 'date', 'error')} required">
	<label for="date">
		<g:message code="activity.date.label" default="Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="date" precision="day"  value="${activityInstance?.date}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: activityInstance, field: 'minutes', 'error')} required">
	<label for="minutes">
		<g:message code="activity.minutes.label" default="Minutes" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="minutes" type="number" min="1" value="${activityInstance.minutes}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: activityInstance, field: 'observations', 'error')} ">
	<label for="observations">
		<g:message code="activity.observations.label" default="Observations" />
		
	</label>
	<g:textField name="observations" value="${activityInstance?.observations}"/>
</div>
<!-- 
<div class="fieldcontain ${hasErrors(bean: activityInstance, field: 'estimationToFinishTask', 'error')} required">
	<label for="estimationToFinishTask">
		<g:message code="activity.estimationToFinishTask.label" default="Estimation To Finish Task" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="estimationToFinishTask" name="estimationToFinishTask.id" from="${com.trackmanager.Estimation.list()}" optionKey="id" required="" value="${activityInstance?.estimationToFinishTask?.id}" class="many-to-one"/>
</div>
-->
<div class="fieldcontain ${hasErrors(bean: activityInstance, field: 'estimationToFinishTask', 'error')} required">
	<label for="expectedMinutesToFinishTask">
		<g:message code="activity.expectedMinutesToFinishTask.label" default="Expected minutes to finish the task" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="expectedMinutesToFinishTask" value="${activityInstance?.expectedMinutesToFinishTask}"/>
</div>

