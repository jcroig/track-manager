<%@ page import="com.trackmanager.Project" %>



<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="project.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${projectInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'customer', 'error')} ">
	<label for="customer">
		<g:message code="project.customer.label" default="Customer" />
		
	</label>
	<g:select id="customer" name="customer.id" from="${com.trackmanager.Customer.list()}" optionKey="id" value="${projectInstance?.customer?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'mantisProject', 'error')} ">
	<label for="mantisProject">
		<g:message code="project.mantisProject.label" default="Mantis Project" />
		
	</label>
	
</div>

