package com.trackmanager

import org.mantisbt.connect.axis.MCSession
import org.mantisbt.connect.model.IProject

class MantisService {

	static transactional = false
	
	String url
	String user
	String password
	MCSession mcSession
	
	MantisService(url, user, password) {
		mcSession = new MCSession(new URL(url), user, password)
	}
	
	def getFilters(long project) {
		return mcSession.getFilters(project)
	}

    IProject[] getProjects() {		
		return mcSession.getAccessibleProjects()
    }
	
	def getIssueHeaders(long project) {
		return mcSession.getProjectIssueHeaders(project)
	}
	
	def getIssueHeaders(long project, int limit) {
		return mcSession.getProjectIssueHeaders(project, limit)
	}
	
	def getIssueHeaders(long project, int page, int pageSize) {
		int begin = page * pageSize
		int end = begin + pageSize
		return mcSession.getProjectIssueHeaders(project, page, pageSize)
	}
	
	def getIssues(long project, long filter) {
		return mcSession.getIssues(project, filter)
	}
	
	def getIssue(long issue) {
		return mcSession.getIssue(issue)
	}
	
	IProject [] subProjects (IProject project, epigrafe){
		def ret=[]
		project.getSubProjects().each{IProject pr->
			pr.setName (epigrafe+pr.getName())
			ret.add (pr)
			ret.addAll (subProjects (pr,epigrafe+"\t>> "))
		}
		return ret
	}
	
	IProject [] recoverProjects (){
		def projects = getProjects()
		def ret = []
		projects.each { IProject pr->
			ret.add (pr)
			ret.addAll (subProjects (pr,"\t>> "))
		}
		return ret;
	}
	
	def updateIssue(issue) {
		mcSession.updateIssue issue
	}
}
