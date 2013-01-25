package com.trackmanager

import org.codehaus.groovy.grails.validation.exceptions.ConstraintException;

import com.trackmanager.Requirement.RequirementStatus;
import com.trackmanager.Task.TaskStatus;

class TaskService {

    static transactional = true
	
	RequirementService requirementService
	
	def createNewTask(command) {
		Task task = new Task(command)
		task.status = TaskStatus.NOT_STARTED
		task.requirement.addToTasks(task)
		task.requirement.refreshStatus()
		task.save(flush:true, failOnError:true)
		
		return task
	}
		
	def refreshTaskStatus(Task task) {
		if(task.activities) {
			def lastEstimation = task.lastEstimation
			if(lastEstimation && lastEstimation.minutes > 0) task.status = TaskStatus.ONGOING
			else task.status = TaskStatus.FINISHED
		}
		else {
			task.status = TaskStatus.NOT_STARTED
		}
		
		requirementService.refreshRequirementStatus(task.requirement)
		task.save(flush:true, failOnError:true)
	}
	
	def getUserPendentTasks(User user) {
		def userPendentTasks = []
		def unfinishedUserTasks = Task.findAllByResponsibleAndStatusNotEqual(user, TaskStatus.FINISHED)
		
		unfinishedUserTasks.each {
			if(this.isTaskReadyToReport(it)) userPendentTasks << it
		}
		return userPendentTasks
	}
}
