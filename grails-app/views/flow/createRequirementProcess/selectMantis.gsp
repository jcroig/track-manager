<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="layout" content="main" />
<g:set var="entityName"
	value="${message(code: 'requirement.label', default: 'Requirement')}" />
<title><g:message code="default.list.label" args="[entityName]" /></title>

<!-- Individual YUI CSS files -->
<link rel="stylesheet"  href="${resource(dir:'css/yui',file:'datatable.css')}" type="text/css" media="screen" title="default" /> 
<link rel="stylesheet"  href="${resource(dir:'css/yui',file:'datatable_custom.css')}" type="text/css" media="screen" title="default" /> 

<!-- jyui plugin -->
<jq:plugin name="jyui"></jq:plugin>

<!-- Individual YUI JS files -->
<script type="text/javascript" src="http://yui.yahooapis.com/2.9.0/build/yahoo/yahoo-min.js"></script> 
<script type="text/javascript" src="http://yui.yahooapis.com/2.9.0/build/dom/dom-min.js"></script> 
<script type="text/javascript" src="http://yui.yahooapis.com/2.9.0/build/event/event-min.js"></script> 
<script type="text/javascript" src="http://yui.yahooapis.com/2.9.0/build/element/element-min.js"></script> 
<script type="text/javascript" src="http://yui.yahooapis.com/2.9.0/build/datasource/datasource-min.js"></script>
<script type="text/javascript" src="http://yui.yahooapis.com/2.9.0/build/paginator/paginator-min.js"></script> 
<script type="text/javascript" src="http://yui.yahooapis.com/2.9.0/build/datatable/datatable-min.js"></script> 


<style type="text/css">
* custom styles for this example */
.yui-skin-sam .yui-dt-body { cursor:pointer;  } /* when rows are selectable */
td, th, .yui-skin-sam .yui-dt-liner {
    padding: 0px;
}
#single { margin-top:2em; }
</style>
<g:javascript>

var myDataTable;

$(window).jyui({
			
}, function() {
YAHOO.util.Event.addListener(window, "load", function() {
	YAHOO.example.Basic = function() {
	        var myColumnDefs = [
	                	        {key:"codigo",sortable:true, resizeable:true},
	                	        {key:"descripcion",sortable:true, resizeable:true}
	                	        
	        ];

	        var myDataSource = new YAHOO.util.FunctionDataSource(projectChange);
	        myDataSource.responseType = YAHOO.util.DataSource.TYPE_JSON;
	        myDataSource.responseSchema = {
	        	resultsList: "list",
	            fields:[
						"codigo"
						,
						"descripcion"
	    	            ],
	            metaFields: {
	            	totalRecords: "numResults" // Access to value in the server response
	           	}
	        };


	        var myConfigs= {
	        		dynamicData: true, // Enables dynamic server-driven data
					sortedBy : {key:"codigo", dir:YAHOO.widget.DataTable.CLASS_ASC}, // Sets UI initial sort arrow
					initialLoad     : false, // cancel the default send
					paginator: new YAHOO.widget.Paginator({ rowsPerPage:25 }), // Enables pagination
					selectionMode:"single" 
			};

	        myDataTable = new YAHOO.widget.DataTable("basic",
	                myColumnDefs, myDataSource, myConfigs);
	        // Set up editing flow
        	myDataTable.subscribe("rowMouseoverEvent",myDataTable.onEventHighlightRow); 
        	myDataTable.subscribe("rowMouseoutEvent", myDataTable.onEventUnhighlightRow); 
	        myDataTable.subscribe("rowClickEvent", eventClick ); 
	        YAHOO.example.Event     

	        return {
	            oDS: myDataSource,
	            oDT: myDataTable
	        };
	    }();
	});

});
var lastSelectedRow;


function eventClick (oArgs) {
	var elTarget = oArgs.target;
	var oRecord = this.getRecord(elTarget);
//	alert("Codigo is:" + oRecord.getData("codigo"));
	$('#mantis').val(oRecord.getData("codigo"));
	myDataTable.onEventSelectRow (oArgs);
}

function refreshTable (){
	myDataTable.getDataSource().sendRequest(
        		myDataTable.get('generateRequest')(myDataTable.getState()), // this is important
    {
        success  : myDataTable.onDataReturnInitializeTable,
        scope    : myDataTable,
        argument : myDataTable.getState()
    });

}

function projectChange (){
	var projectId=$('#project').val();
//	alert (projectId);
	$.ajaxSetup( { "async": false } ); 
	var ret;
	var lis= $.getJSON("${createLink(controller:'project',action:'projectChange')}",{project:projectId},function (mantisList){ret=mantisList;});
	 $.ajaxSetup( { "async": true } ); 
	return ret;
}
</g:javascript>
</head>
<body >
<div class="nav"><span class="menuButton"><a class="home"
	href="${createLink(uri: '/')}"><g:message code="default.home.label" /></a></span>
</div>
<div>
	<g:select noSelection="${['null':'Select One...']}" from="${projects}" optionKey="id" optionValue="name"  onchange="refreshTable()" id="project" name="project" ></g:select>

</div>
<div id="basic" class="yui-skin-sam"></div>
<div class="body">
	<g:form action="createRequirementProcess">
		<g:hiddenField name="mantis" id="mantis"/>
		<g:submitButton name="continue" value="Import data"></g:submitButton>
		<g:submitButton name="skip" value="Skip"></g:submitButton>
		<g:submitButton name="cancel" value="Cancel"></g:submitButton>
	</g:form>
</div>
</body>
</html>