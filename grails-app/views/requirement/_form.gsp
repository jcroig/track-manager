<%@ page import="com.trackmanager.Requirement" %>

<div class="control-group ${hasErrors(bean: requirementInstance, field: 'mantis', 'error')}">
	<label class="control-label" for="mantis">
		<g:message code="requirement.mantis.label" default="Mantis" />
		<span class="required-indicator">*</span>
	</label>
	<div class="controls">
		<g:field name="mantis" type="number" value="${requirementInstance.mantis}" required=""/>
	</div>
</div>

<div class="control-group ${hasErrors(bean: requirementInstance, field: 'title', 'error')}">
	<label class="control-label" for="title">
		<g:message code="requirement.title.label" default="Title" />
		<span class="required-indicator">*</span>
	</label>
	<div class="controls">
		<g:textField name="title" required="" value="${requirementInstance?.title}"/>
	</div>
</div>

<div class="control-group ${hasErrors(bean: requirementInstance, field: 'description', 'error')}">
	<label class="control-label" for="description">
		<g:message code="requirement.description.label" default="Description" />
		<span class="required-indicator">*</span>
	</label>
	<div class="controls">
		<g:textArea rows="5" name="description" required="" value="${requirementInstance?.description}"/>
	</div>
</div>

<g:if test="${requirementInstance?.id}">
	<div class="control-group ${hasErrors(bean: requirementInstance, field: 'status', 'error')}">
		<label class="control-label" for="status">
			<g:message code="requirement.status.label" default="Status" />
			<span class="required-indicator">*</span>
		</label>
		<div class="controls">
			<g:select name="status" from="${com.trackmanager.Requirement$RequirementStatus?.values()}" keys="${com.trackmanager.Requirement$RequirementStatus.values()*.name()}" required="" value="${requirementInstance?.status?.name()}"/>
		</div>
	</div>
</g:if>

