<ul>
	<li>
	<h3><a href="#" class="house"><a class="house"
		href="${createLink(uri: '/')}"><g:message
		code="default.home.label" default="Home" /></a>
	</li>
	</a>
	</h3>
	<ul>
		<li><a href="#" class="report">Daily statistics</a></li>
		<li><a href="#" class="report_seo">Monthly statistics</a></li>
		<li><a href="#" class="search">User statistics</a></li>
	</ul>
	</li>
	<li>
	<h3><g:link controller="requirement" class="folder_table">
		<g:message code="requirement.label.plural" default="Requirements" />
	</g:link></h3>
	<ul>
		<li><g:link controller="flow" action="createRequirementProcess"
			class="addorder">
			<g:message code="requirement.action.new" default="New requirement" />
		</g:link></li>
		<li><a href="#" class="search">Find Requirement</a></li>
	</ul>
	</li>
	<li>
	<h3><g:link controller="task" class="manage">
		<g:message code="task.label.plural" default="Tasks" />
	</g:link></h3>
	<ul>
		<li><g:link controller="flow" action="createTaskProcess"
			class="manage_page">
			<g:message code="task.action.new" default="New Task" />
		</g:link></li>
		<li><a href="#" class="search">Find task</a></li>
	</ul>
	</li>
	<li>
	<h3><g:link controller="estimation" class="promotions">
		<g:message code="estimation.label.plural" default="Estimations" />
	</g:link></h3>
	<ul>
		<li><g:link controller="estimation" action="create"
			class="invoices">
			<g:message code="estimation.action.new" default="New Estimation" />
		</g:link></li>
		<li><a href="#" class="search">Find estimation</a></li>
	</ul>
	</li>
	<li>
	<h3><g:link controller="user" class="user">
		<g:message code="user.label.plural" default="Users" />
	</g:link></h3>
	<ul>
		<li><g:link controller="user" action="create" class="useradd"><g:message code="user.action.new" default="Create User" /></g:link></li>
		<li><a href="#" class="group">User groups</a></li>
		<li><a href="#" class="search">Find user</a></li>
		<li><a href="#" class="online">Users online</a></li>
	</ul>
	</li>
</ul>
