package com.trackmanager


class MantisController {

	MantisService mantisService
	
    def index = { 
		render view: 'index', model: [projects: mantisService.projects, issues: mantisService.getIssues(40, 759)]
	}
}
