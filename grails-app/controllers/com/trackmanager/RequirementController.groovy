package com.trackmanager

import grails.plugins.springsecurity.SpringSecurityService

import org.springframework.dao.DataIntegrityViolationException

import com.trackmanager.Requirement.RequirementStatus


class RequirementController {

	static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

	RequirementService requirementService
	ChangeEventService changeEventService
	SpringSecurityService springSecurityService

	def index() {
		redirect(action: "list", params: params)
	}

	def list(Integer max) {
		params.max = Math.min(max ?: 10, 100)
		[requirementInstanceList: Requirement.list(params), requirementInstanceTotal: Requirement.count()]
	}

	def create() {
		[requirementInstance: new Requirement(params)]
	}

	def save (RequirementCommand command) {
		if (command.hasErrors()) {
			render(view: "create", model: [requirementInstance: command])
		} else {
			try{
				command.creator = user
				def requirementInstance = requirementService.createNewRequirement(command);
				flash.message = message(code: 'default.created.message', args: [message(code: 'requirement.label', default: 'Requirement'), command.id])
				redirect(action: "show", id: requirementInstance.id)
			}catch (RuntimeException){
				render(view: "create", model: [requirementInstance: command])
			}
		}
	}

	def show (Long id) {
		def requirementInstance = Requirement.get(id)
		if (!requirementInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'requirement.label', default: 'Requirement'), id])
			redirect(action: "list")
			return
		}

		[requirementInstance: requirementInstance]
	}

	def edit (Long id) {
		def requirementInstance = Requirement.get(id)
		if (!requirementInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'requirement.label', default: 'Requirement'), id])
			redirect(action: "list")
			return
		}

		[requirementInstance: requirementInstance]
	}

	def update(RequirementCommand command) {
		def requirementInstance = Requirement.get(params.id)

		if (!requirementInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'requirement.label', default: 'Requirement'), params.id])
			redirect(action: "list")
		} else if (params.version != null && requirementInstance.version > params.version) {
			requirementInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
					[message(code: 'requirement.label', default: 'Requirement')] as Object[],
					"Another user has updated this Requirement while you were editing")
			render(view: "edit", model: [requirementInstance: requirementInstance])
		} else if (command.hasErrors()) {
			render(view: "edit", model: [requirementInstance: command])
		} else {
			requirementService.updateRequirement(requirementInstance, command);
			flash.message = message(code: 'default.updated.message', args: [message(code: 'requirement.label', default: 'Requirement'), requirementInstance.id])
			redirect(action: "show", id: requirementInstance.id)
		}
	}

	def delete(Long id) {
		def requirementInstance = Requirement.get(id)
		if (!requirementInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'requirement.label', default: 'Requirement'), command.id])
			redirect(action: "list")
			return
		}

		try {
			requirementInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'requirement.label', default: 'Requirement'), id])
			redirect(action: "list")
		}
		catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'requirement.label', default: 'Requirement'), id])
			redirect(action: "show", id: id)
		}
	}


	def getUser() {
		User.get(springSecurityService.principal.id)
	}

	class RequirementCommand {
		Long id
		Long version
		String title
		String description
		Long mantis
		RequirementStatus status
		User creator


		static constraints = {
			title(blank: false)
			mantis(nullable: false)
		}
	}
}
