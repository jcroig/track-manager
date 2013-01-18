package com.trackmanager

import java.util.Date;

import org.springframework.dao.DataIntegrityViolationException

import com.trackmanager.Activity;
import com.trackmanager.Estimation;
import com.trackmanager.Task;
import com.trackmanager.User;


class ActivityController {

	static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

	def springSecurityService
	ActivityService activityService

	def index() {
		redirect(action: "list", params: params)
	}

	def list(Integer max) {
		params.max = Math.min(max ?: 10, 100)
		[activityInstanceList: Activity.list(params), activityInstanceTotal: Activity.count()]
	}

	def create() {
		[activityInstance: new Activity(params)]
	}

	def save (ActivityCommand command) {
		if(command.hasErrors()) {
			render(view: "create", model: [activityInstance: command])
		} else {
			try {
				command.user = user
				def activityInstance = activityService.createNewActivity(command)
				flash.message = message(code: 'default.created.message', args: [message(code: 'activity.label', default: 'Activity'), activityInstance.id])
				redirect(action: "show", id: activityInstance.id)
			}
			catch (RuntimeException e){
				render(view: "create", model: [activityInstance: command])
			}
		}
	}

	def show(Long id) {
		def activityInstance = Activity.get(id)
		if (!activityInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'activity.label', default: 'Activity'), id])
			redirect(action: "list")
			return
		}

		[activityInstance: activityInstance]
	}

	def edit(Long id) {
		def activityInstance = Activity.get(id)
		if (!activityInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'activity.label', default: 'Activity'), id])
			redirect(action: "list")
			return
		}

		[activityInstance: activityInstance]
	}

	def update (ActivityCommand command) {
		def activityInstance = Activity.get(params.id)
		if (!activityInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'activity.label', default: 'Activity'), params.id])
			redirect(action: "list")
		} else if (command.version != null && activityInstance.version > params.version) {
			activityInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
					[message(code: 'activity.label', default: 'Activity')] as Object[],
					"Another user has updated this Activity while you were editing")
			render(view: "edit", model: [activityInstance: activityInstance])
		} else {
			try {
				activityService.updateActivity(activityInstance, command);
				flash.message = message(code: 'default.updated.message', args: [message(code: 'activity.label', default: 'Activity'), activityInstance.id])
				redirect(action: "show", id: activityInstance.id)
			} catch (RuntimeException e) {
				render(view: "edit", model: [activityInstance: activityInstance])
			}
		}
	}

	def delete(Long id) {
		def activityInstance = Activity.get(id)
		if (!activityInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'activity.label', default: 'Activity'), id])
			redirect(action: "list")
			return
		}

		try {
			activityInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'activity.label', default: 'Activity'), id])
			redirect(action: "list")
		}
		catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'activity.label', default: 'Activity'), id])
			redirect(action: "show", id: id)
		}
	}

	def getUser() {
		return User.get(springSecurityService.principal.id)
	}

	class ActivityCommand {
		Long id
		Long version
		Date date
		Long minutes
		Task task
		String observations
		Long expectedMinutesToFinishTask
		User user

		static constraints = {
			date(nullable: false)
			minutes(nullable: false, min: Long.valueOf(1))
			expectedMinutesToFinishTask(min: Long.valueOf(0))
		}

		Estimation getEstimationToFinishTask () {
			return new Estimation(minutes: expectedMinutesToFinishTask, task: task, date: new Date(), user: user)
		}
	}
}
