<%@ page import="org.codehaus.groovy.grails.web.servlet.GrailsApplicationAttributes" %>
<!doctype html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<title><g:layoutTitle default="${meta(name: 'app.name')}"/></title>
		<meta name="description" content="">
		<meta name="author" content="">

		<meta name="viewport" content="initial-scale = 1.0">

		<!-- Le HTML5 shim, for IE6-8 support of HTML elements -->
		<!--[if lt IE 9]>
			<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
		<![endif]-->

		<r:require modules="bootstrap"/>

		<g:layoutHead/>
		<r:layoutResources/>
	</head>

	<body>

		<nav class="navbar navbar-fixed-top">
			<div class="navbar-inner">
				<div class="container-fluid">
					
					<a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</a>
					
					<a class="brand" href="${createLink(uri: '/')}">Track-manager</a>

					<div class="nav-collapse">
						<ul class="nav">							
							<li><g:link controller="Requirement"><g:message code="requirement.label" default="Requirement"/></g:link></li>
							<li><g:link controller="Task"><g:message code="requirement.Task" default="Task"/></g:link></li>
							<li><g:link controller="Estimation"><g:message code="requirement.Estimation" default="Estimation"/></g:link></li>
							<li><g:link controller="Activity"><g:message code="requirement.Activity" default="Activity"/></g:link></li>
						</ul>
					</div>
				</div>
			</div>
		</nav>

		<div class="container-fluid">
			<g:layoutBody/>

			<!-- <hr> -->

			<footer>
			</footer>
		</div>

		<r:layoutResources/>

	</body>
</html>