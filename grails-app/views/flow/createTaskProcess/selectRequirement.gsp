<%@ page import="com.trackmanager.Requirement" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'requirement.label', default: 'Requirement')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
        <script type="text/javascript">
        	$(document).ready(function() {
            	var checkBoxes = $('#mainform :checkbox')
        		checkBoxes.click(function(){
        			$('#mainform :checkbox').each(function() {
            			if(this.checked) $(this).checkBox('toggle');
                	});
                	$(this).checkBox('toggle');
                	$('#requirement').val($(this).val())
        		});
            });
            
            function next() {
            	if($('#requirement').val() == "") {
					alert("${message(code:"default.button.next.error.message", default:"An element must be selected")}");
					return false;
                }
                $('#requirement').after('<input type="hidden" name="_eventId_continue" value="_eventId_continue" id="_eventId_continue" style="display:none"/>');
                $('form')[1].submit();
            }

            function cancel() {
            	$('#requirement').after('<input type="hidden " name="_eventId_cancel" value="_eventId_cancel" id="_eventId_cancel" style="display:none"/>');
                $('form')[1].submit();
            }
        </script>
    </head>
    <body>		
		<div id="step-holder">
			<div class="step-no">1</div>
			<div class="step-dark-left"><g:message code="requirement.select.label" default="Select requirement"/></div>
			<div class="step-dark-right">&nbsp;</div>
			<div class="step-no-off">2</div>
			<div class="step-light-left"><g:message code="task.enter.details.label" default="Enter task details"/></div>
			<div class="step-light-round">&nbsp;</div>
			<div class="clear"></div>
		</div>
		
		<table border="0" width="100%" cellpadding="0" cellspacing="0" id="content-table">
			<tr>
				<th rowspan="${(flash.message) ? '4' : '3'}" class="sized"><img src="${resource(dir:'images/shared',file:'side_shadowleft.jpg')}" width="20" height="300" alt="" /></th>
				<th class="topleft"></th>
				<td class="tbl-border-top">&nbsp;</td>
				<th class="topright"></th>
				<th rowspan="${(flash.message) ? '4' : '3'}" class="sized"><img src="${resource(dir:'images/shared',file:'side_shadowright.jpg')}" width="20" height="300" alt="" /></th>
			</tr>
			<tr>
				<td class="tbl-border-left"></td>
				<td>
				<!--  start content-table-inner ...................................................................... START -->
				<div id="content-table-inner">
				
					<!--  start table-content  -->
					<div id="table-content">
						<g:if test="${flash.message}">
							<!--  start message-green -->
							<div id="message-green">
							<table border="0" width="100%" cellpadding="0" cellspacing="0">
							<tr>
								<td class="green-left">${flash.message}</td>
								<td class="green-right"><a class="close-green"><img src="${resource(dir:'images/table',file:'icon_close_green.gif')}" alt="" /></a></td>
							</tr>
							</table>
							</div>
						</g:if>
						<!--  end message-green -->
						<!--  start product-table ..................................................................................... -->
						<form id="mainform" action="">
						<table border="0" width="100%" cellpadding="0" cellspacing="0" id="result-table">
						<tr>
							<th class="table-header-repeat line-left"></th>
                            <g:sortableColumn class="table-header-repeat line-left" property="mantis" title="${message(code: 'requirement.mantis.label', default: 'Mantis')}" />
                            <g:sortableColumn class="table-header-repeat line-left" property="title" title="${message(code: 'requirement.title.label', default: 'Title')}" />
						</tr>
	                    <g:each in="${requirementInstanceList}" status="i" var="requirementInstance">
	                        <tr class="${(i % 2) == 0 ? '' : 'alternate-row'}">
	                        	<td><input  type="checkbox" value="${requirementInstance?.id}"/></td>
								<td>${requirementInstance?.mantis}</td>
	                        	<td>${requirementInstance?.title}</td>
	                        </tr>
	                    </g:each>
					</table>
						<!--  end product-table................................... --> 
						</form>
					</div>
					<!--  end content-table  -->
				
					<!--  start actions-box ............................................... -->
					<g:form action="createEstimationProcess">
						<g:hiddenField name="requirement" id="requirement"></g:hiddenField>
						<div id="actions-box">
							<a href="" class="action-slider"></a>
							<div id="actions-box-slider">
								<a href="javascript:next()" id="next-link" class="action-edit"><g:message code="default.next.label" default="Next"></g:message></a>
								<a href="javascript:cancel()" id="cancel-link" class="action-delete"><g:message code="default.cancel.label" default="Cancel"></g:message></a>
							</div>
							<div class="clear"></div>
						</div>
					</g:form>
					<!-- end actions-box........... -->

					<div class="clear"></div>
				 
				</div>
				<!--  end content-table-inner ............................................END  -->
				</td>
				<td class="tbl-border-right"></td>
			</tr>
			<tr>
				<th class="sized bottomleft"></th>
				<td class="tbl-border-bottom">&nbsp;</td>
				<th class="sized bottomright"></th>
			</tr>
			</table>
			<div class="clear">&nbsp;</div>
		<div class="clear">&nbsp;</div>
    </body>
</html>
