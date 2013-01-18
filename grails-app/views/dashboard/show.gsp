<%@page import="com.trackmanager.Requirement.RequirementStatus"%>
<%@page import="grails.converters.JSON"%>
<%@page import="com.trackmanager.Task.TaskStatus"%>
<%@ page import="java.util.Date %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'activity.label', default: 'Activity')}" />
        <title><g:message code="default.dashboard.label" default="Dashboard" /></title>
        <script type="text/javascript">
		var init_states = function(states_input) {
		    var states = {}
			var states_order = []
			for ( var i=0, len=states_input.length; i<len; i++ ) {
				var state = states_input[i].name;
				states[state] = state;
				states_order.push(state);
			}
		    return {states: states, states_order: states_order};
		}
		
		var init_board = function(tasks) {
			var board = {};
			for ( var i=0, len=tasks.length; i<len; i++ ) {
				var task = tasks[i];
				if (! board[task.status.name]) board[task.status.name] = [];
				board[task.status.name].push(task);
			}
			return board;
		}
		
		var create_list = function(board, state) {
			   var list = $("<ul id=\"" + state + "\"></ul>");
		       if (board[state]) {
		         for (var i=0, len=board[state].length; i<len; i++) {
			        var task = board[state][i];
		            var task_element = $("<li>")
			        task_element.append(task.paint());
		            //task_element.data("story",  board[state][i]);
					list.append(task_element);
		     	 }
			   }
			   return list
		}
		
		var create_column = function(board, state, headline) {
			   var queueStatus = state.indexOf("READY") === 0
			   var state_column = $("<div class=\"dp10"+ (queueStatus ? " queue_column " : "") +"\"></div>")
			   var totalElements = board[state] != null ? board[state].length : 0;
			   state_column.append($("<div class=\"headline\">" + headline + "</div>"));
			   state_column.append(create_list(board, state));
			   state_column.data("state", state);
			   return state_column;
		}
		
		var create_board = function(app_data) {
			var table = $("<div id=\"board\"></div>");
			var ids = "";
			for (j=0; j< app_data.states_order.length; j++) {
				var state = app_data.states_order[j]		
				ids += "#" + state + ","
				var state_column = create_column(app_data.board, state, app_data.states[state])
				table.append(state_column)
			}
			//$(ids, table).dragsort({ dragBetween: true });
			return table;
		} 

		$(document).ready(function() {
        	$('.group').click(function() {
				$(this).next().toggle();
				return false;
			}).next().hide();
			$('.group').css('clear','left')
			
			// Paint Task Board
			var tasksList = []
			Array.prototype.push.apply(tasksList, ${tasks as JSON});
			for (var i=0, len=tasksList.length; i<len; i++) {
				var task = tasksList[i];
				task.paint = function() {
					var container = $("<div class=\"box box_" + this.status.name  + "\">");
					var requirement = $("<div>Requirement "+ this.requirement.id +"</div>");
					var task = $("<div> Task " + this.id + ": " + this.type.name + " "+ this.description + "</div>");
					container.append(requirement);
					container.append(task);
					
					return container;
				}
			} 
			var status_data = init_states(${(TaskStatus.values() as List) as JSON});
			var app_data = { board: init_board(tasksList), states: status_data.states, states_order: status_data.states_order}
			$("#taskPanelDiv").empty();
			$("#taskPanelDiv").append(create_board(app_data));

			// Paint Requirement Board
			var requirementsList = []
			Array.prototype.push.apply(requirementsList, ${requirements as JSON});
			for (var i=0, len=requirementsList.length; i<len; i++) {
				var requirement = requirementsList[i];
				requirement.paint = function() {
					return $("<div class=\"box box_" + this.status.name  + "\">" + this.id + " " + this.title + "</div>");
				}
			} 
			var status_data = init_states(${(RequirementStatus.values() as List) as JSON});
			var app_data = { board: init_board(requirementsList), states: status_data.states, states_order: status_data.states_order}
			$("#requirementPanelDiv").empty();
			$("#requirementPanelDiv").append(create_board(app_data));
		})       
        </script>
    </head>
    <body>
		<div id="accordion">
			<sec:ifAllGranted roles="ROLE_ADMIN">
		    <h2 class="group"><a href="#"><g:message code="task.plural.unassigned.label" default="Unassigned Tasks"/> (${unassignedTasks.size()})</a></h2>
			<div>
				<ul>
				<g:each var="task" in="${unassignedTasks}">
					<li>
						<g:link controller="task" action="show" id="${task.id}">${task}</g:link>
						<g:link controller="activity" action="create" params="${['task.id': task.id]}">
							<img src="${resource(dir:'images/forms',file:'icon_plus.gif')}" alt="" title="${message(code: 'default.add.label', args: [message(code: 'activity.label', default: 'Activity')])}"/>
						</g:link>
					</li>
				</g:each>
				</ul>
			</div>
			</sec:ifAllGranted>
		    <h2 class="group"><a href="#"><g:message code="task.plural.my.label" default="My Tasks"/> (${myTasks.size()})</a></h2>
			<div>
				<ul>
				<g:each var="task" in="${myTasks}">
					<li>
						<g:link controller="task" action="show" id="${task.id}">${task}</g:link>
						<g:link controller="activity" action="create" params="${['task.id': task.id]}">
							<img src="${resource(dir:'images/forms',file:'icon_plus.gif')}" alt="" title="${message(code: 'default.add.label', args: [message(code: 'activity.label', default: 'Activity')])}"/>
						</g:link>
					</li>
				</g:each>
				</ul>
			</div>
		    <h2 class="group"><a href="#"><g:message code="activity.plural.my.label" default="My activities"/> (${totalMyActivities})</a></h2>
		    <div>
		    	<g:each var="activitiesDay" in="${myActivities}">
		    		<h3><g:formatDate date="${activitiesDay.date}" format="dd/MM/yyyy"/> (${activitiesDay.totalMinutes} Minutes)</h3>
		    		<g:link action="visualizeDayActivities" params="${['date': activitiesDay.date.format('dd/MM/yyyy')]}">
						<img src="${resource(dir:'images/icons',file:'magnifier.png')}" alt="" title="${message(code: 'activity.show.daily.activity.label', default: 'Activity')}"/>
					</g:link>
		    		<ul>
					<g:each var="activity" in="${activitiesDay.activities}">
						<li><g:link controller="activity" action="show" id="${activity.id}">${activity}</g:link></li>
					</g:each>
					</ul>
		    	</g:each>
			</div>
		    <h2 class="group"><a href="#"><g:message code="task.plural.dashboard.text" default="Tasks dashboard"/></a></h2>
			<div id="taskPanelDiv"></div>
		    <h2 class="group"><a href="#"><g:message code="requirement.plural.dashboard.text" default="Requirements dashboard"/></a></h2>
			<div id="requirementPanelDiv"></div>
			<h2 class="group"><a href="#"><g:message code="changeEvent.plural.last.label" default="Last changes"/></a></h2>
		    <div>
				<ul>
				<g:each var="event" in="${events}">
					<li>
						<g:if test="${event.details.size()}">
							<a href="#" class="group">${event}</a>
							<div>
								<ul>
									<g:each var="detail" in="${event.details}">
										<li>${detail.propertyName}: ${detail.oldValue} => ${detail.newValue}</li>
									</g:each>
								</ul>
							</div>
						</g:if>
						<g:else>
							${event}
						</g:else>
					</li>
				</g:each>
				</ul>
			</div>
		</div>		
    </body>
</html>
