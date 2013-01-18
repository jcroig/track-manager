<div>
	<table border="0" cellpadding="0" cellspacing="0" id="paging-table">
		<tr>
			<td>
				<g:if test="${showBackwardLinks}">
					<g:link class="page-far-left" params="${sort ? [offset: offsetFirstPage, max: max, sort: sort, order: order] : [offset: offsetFirstPage, max: max]}"></g:link>
					<g:link class="page-left"
						params="${sort ? [offset: offsetPreviousPage, max: max, sort: sort, order: order] : [offset: offsetPreviousPage, max: max]}"></g:link>
				</g:if>

				<div id="page-info">
					<g:message code='default.paginate.page'></g:message>
					<strong>
						${actualPage}
					</strong> /
					${totalResultPages}
				</div> 
				<g:if test="${showForwardLinks}">
					<g:link class="page-right"
						params="${sort ? [offset: offsetNextPage, max: max, sort: sort, order: order] : [offset: offsetNextPage, max: max]}"></g:link>
					<g:link class="page-far-right"
						params="${sort ? [offset: offsetLastPage, max: max, sort: sort, order: order] : [offset: offsetLastPage, max: max]}"></g:link>
				</g:if></td>
			<td>
				<select id="select-page" class="styledselect_pages">
					<option value=""><g:message code="default.paginate.message" default="Number of rows"></g:message></option>
					<option value="${createLink(params:[max: 5])}">5</option>
					<option value="${createLink(params:[max: 10])}">10</option>
					<option value="${createLink(params:[max: 25])}">25</option>
				</select>
			</td>
		</tr>
	</table>
</div>