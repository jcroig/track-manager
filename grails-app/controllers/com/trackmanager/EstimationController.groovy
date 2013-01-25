package com.trackmanager

import grails.plugins.springsecurity.SpringSecurityService;

import java.util.Date;

import org.springframework.dao.DataIntegrityViolationException

import com.trackmanager.Requirement.RequirementStatus;

class EstimationController {

	static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

	EstimationService estimationService
	SpringSecurityService springSecurityService

	def index() {
		redirect(action: "list", params: params)
	}

	def list(Integer max) {
		params.max = Math.min(max ?: 10, 100)
		[estimationInstanceList: Estimation.list(params), estimationInstanceTotal: Estimation.count()]
	}

	def create() {
		[estimationInstance: new Estimation(params)]
	}

	def save(EstimationCommand command) {
		def estimationInstance
		command.user = user
		
		if (command.hasErrors()) {
			render(view: "create", model: [estimationInstance: command])
		} else {
			estimationInstance = estimationService.createEstimation(command)
			flash.message = message(code: 'default.created.message', args: [message(code: 'estimation.label', default: 'Estimation'), estimationInstance.id])
			redirect(action: "show", id: estimationInstance.id)
		}
	}

	def show(Long id) {
		def estimationInstance = Estimation.get(id)
		if (!estimationInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'estimation.label', default: 'Estimation'), id])
			redirect(action: "list")
			return
		}

		[estimationInstance: estimationInstance]
	}

	def edit(Long id) {
		def estimationInstance = Estimation.get(id)
		if (!estimationInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'estimation.label', default: 'Estimation'), id])
			redirect(action: "list")
			return
		}

		[estimationInstance: estimationInstance]
	}

	def update(EstimationCommand command) {
		def estimationInstance = Estimation.get(params.id)

		if (!estimationInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'estimation.label', default: 'Estimation'), params.id])
			redirect(action: "list")
		} else if (params.version != null && estimationInstance.version > params.version) {
			estimationInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
					[message(code: 'requirement.label', default: 'Requirement')] as Object[],
					"Another user has updated this Requirement while you were editing")
			render(view: "edit", model: [estimationInstance: estimationInstance])
		} else if (command.hasErrors()) {
			render(view: "edit", model: [estimationInstance: command])
		} else {
			estimationService.updateEstimation(estimationInstance, command);
			flash.message = message(code: 'default.updated.message', args: [message(code: 'estimation.label', default: 'Estimation'), estimationInstance.id])
			redirect(action: "show", id: estimationInstance.id)
		}
	}

	def delete(Long id) {
		def estimationInstance = Estimation.get(id)
		if (!estimationInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'estimation.label', default: 'Estimation'), id])
			redirect(action: "list")
			return
		}

		try {
			estimationInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'estimation.label', default: 'Estimation'), id])
			redirect(action: "list")
		}
		catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'estimation.label', default: 'Estimation'), id])
			redirect(action: "show", id: id)
		}
	}
	
	def getUser() {
		User.get(springSecurityService.principal.id)
	}

	class EstimationCommand {
		User user
		Task task
		Long minutes

		static constraints = {
			task(nullable: false)
			minutes(min: Long.valueOf(0))
		}
	}
}
