<!DOCTYPE html>
<html lang="en">
  <head>
    <meta name='layout' content='main'/>
	<meta charset="utf-8">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Le styles -->
    <style type="text/css">
      /* Override some defaults */
      html, body {
        background-color: #eee;
      }
      body {
        padding-top: 40px; 
      }
      .container {
        width: 300px;
      }

      /* The white background content wrapper */
      .container > .content {
        background-color: #fff;
        padding: 20px;
        margin: 0 -20px; 
        -webkit-border-radius: 10px 10px 10px 10px;
           -moz-border-radius: 10px 10px 10px 10px;
                border-radius: 10px 10px 10px 10px;
        -webkit-box-shadow: 0 1px 2px rgba(0,0,0,.15);
           -moz-box-shadow: 0 1px 2px rgba(0,0,0,.15);
                box-shadow: 0 1px 2px rgba(0,0,0,.15);
      }

	  .login-form {
		margin-left: 65px;
	  }
	
	  legend {
		margin-right: -50px;
		font-weight: bold;
	  	color: #404040;
	  }

    </style>

</head>
<body>
	<div class="container">
		<div class="content">
			<div class="row">
				<div class="login-form span6 offset3"">
					<h2><g:message code="springSecurity.login.header"/></h2>
					
					<g:if test='${flash.message}'>
						<div class='alert alert-error'>${flash.message}</div>
					</g:if>
					
					<form action='${postUrl}' method='POST' id='loginForm'>
						<fieldset>
							<div class="clearfix">
								<input type="text" name='j_username' id='username' placeholder="<g:message code="springSecurity.login.username.label"/>">
							</div>
							<div class="clearfix">
								<input type="password" name='j_password' id='password' placeholder="<g:message code="springSecurity.login.password.label"/>">
							</div>
							<button class="btn btn-primary" type="submit" id="submit"><g:message code="springSecurity.login.button" default="Sign in"/></button>
						</fieldset>
					</form>
				</div>
			</div>
		</div>
	</div> <!-- /container -->
<script type='text/javascript'>
	<!--
	(function() {
		document.forms['loginForm'].elements['j_username'].focus();
	})();
	// -->
</script>
</body>
</html>
