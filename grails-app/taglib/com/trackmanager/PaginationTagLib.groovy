package com.trackmanager

class PaginationTagLib {
	
	def pagination = { attrs, body ->
		def model = ['controllerName': controllerName]
		def totalResults = attrs.total
		def max = params.max ? params.max.toInteger() : 10
		def offset = params.offset? params.offset.toInteger() : 1

		model['totalResultPages'] =  Math.floor(totalResults / max) < totalResults / max ? (int) Math.floor(totalResults / max) + 1 : (int) Math.floor(totalResults / max)
		model['actualPage'] = (int) Math.floor(offset / max) + 1 
		model['showForwardLinks'] = model['actualPage'] < model['totalResultPages']
		model['showBackwardLinks'] = model['actualPage'] > 1
		model['max'] = max
		
		if(model['showForwardLinks']) {
			model['offsetNextPage'] = offset + max
			model['offsetLastPage'] = (int) Math.floor(totalResults / max) * max
		}
		
		if(model['showBackwardLinks']) {
			model['offsetPreviousPage'] = offset - max
			model['offsetFirstPage'] = 0
		}
		
		model['sort'] = params.sort
		model['order'] = params.order
		
		out << render(template: "/common/pagination", model: model)
	}

}
