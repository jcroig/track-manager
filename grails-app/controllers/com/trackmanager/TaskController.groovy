package com.trackmanager

import org.springframework.dao.DataIntegrityViolationException

class TaskController {

	static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

	TaskService taskService

	def index() {
		redirect(action: "list", params: params)
	}

	def list(Integer max) {
		params.max = Math.min(max ?: 10, 100)
		[taskInstanceList: Task.list(params), taskInstanceTotal: Task.count()]
	}

	def create() {
		[taskInstance: new Task(params)]
	}

	def save() {
		def taskInstance
		try {
			taskInstance = taskService.createNewTask(params)
			flash.message = message(code: 'default.created.message', args: [message(code: 'task.label', default: 'Task'), taskInstance.id])
			redirect(action: "show", id: taskInstance.id)
		} catch (RuntimeException e) {
			render(view: "create", model: [taskInstance: taskInstance])
		}
	}

	def show(Long id) {
		def taskInstance = Task.get(id)
		if (!taskInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'task.label', default: 'Task'), id])
			redirect(action: "list")
			return
		}

		def estimations = taskInstance.estimations?.sort{it.dateCreated}
		def hoursActivities = []

		estimations.each {
			def activity = Activity.findByEstimationToFinishTask(it)
			if (activity) {
				hoursActivities << (activity.minutes + hoursActivities[-1] ?: 0) 
			} else if (hoursActivities.size() > 0) {
				hoursActivities << hoursActivities[-1]
			} else {
				hoursActivities << 0
			}
		}

		[taskInstance: taskInstance, hoursEstimated: estimations*.minutes, hoursActivities: hoursActivities]
	}

	def edit(Long id) {
		def taskInstance = Task.get(id)
		if (!taskInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'task.label', default: 'Task'), id])
			redirect(action: "list")
			return
		}

		[taskInstance: taskInstance]
	}

	def update(Long id, Long version) {
		def taskInstance = Task.get(id)
		if (!taskInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'task.label', default: 'Task'), id])
			redirect(action: "list")
			return
		}

		if (version != null) {
			if (taskInstance.version > version) {
				taskInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
						[message(code: 'task.label', default: 'Task')] as Object[],
						"Another user has updated this Task while you were editing")
				render(view: "edit", model: [taskInstance: taskInstance])
				return
			}
		}

		taskInstance.properties = params

		if (!taskInstance.save(flush: true)) {
			render(view: "edit", model: [taskInstance: taskInstance])
			return
		}

		flash.message = message(code: 'default.updated.message', args: [message(code: 'task.label', default: 'Task'), taskInstance.id])
		redirect(action: "show", id: taskInstance.id)
	}

	def delete(Long id) {
		def taskInstance = Task.get(id)
		if (!taskInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'task.label', default: 'Task'), id])
			redirect(action: "list")
			return
		}

		try {
			taskInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'task.label', default: 'Task'), id])
			redirect(action: "list")
		}
		catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'task.label', default: 'Task'), id])
			redirect(action: "show", id: id)
		}
	}
}
