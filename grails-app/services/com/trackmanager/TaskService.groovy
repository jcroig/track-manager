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
	
	def modifyTask(taskInstance, taskCommand) {
		taskInstance.description = taskCommand.description
		taskInstance.responsible = taskCommand.responsible
		taskInstance.type = taskCommand.type
		
		def initialEstimation = taskInstance.firstEstimation
		if(initialEstimation.minutes != taskCommand.estimation.minutes) {
			if(!initialEstimation.lastTaskEstimation) {
				throw new ConstraintException("Only last task's estimation can be changed")
			}
			initialEstimation.minutes = taskCommand.estimation.minutes
			initialEstimation.save(flush:true, failOnError:true)
		}
		
		refreshTaskStatus(taskInstance)
		taskInstance.save(flush:true, failOnError:true)
		
		return taskInstance
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
	
	def isTaskReadyToReport(Task task) {
		if(task.status == TaskStatus.FINISHED || task.requirement.status == RequirementStatus.ESTIMATED) return false
		def result = true
		task.requirement.tasks.each {
			if(it.type.id < task.type.id && it.status != TaskStatus.FINISHED) result = false
		}
		return result
	}
}
