package com.trackmanager

import grails.plugins.springsecurity.SpringSecurityService

import org.springframework.dao.DataIntegrityViolationException

import com.trackmanager.Requirement.RequirementStatus


class RequirementController {

	static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

	RequirementService requirementService
	ChangeEventService changeEventService
	SpringSecurityService springSecurityService

	def index () {
		redirect(action: "list", params: params)
	}

	def list (Integer max) {
		params.max = Math.min(max ?: 10, 100)
		def queryWithOrder = {
			if (params.mantis) eq('mantis', Long.valueOf(params.mantis))
			if (params.status && params.status != ' ') eq('status', RequirementStatus.values().find {it.name() == params.status})
			maxResults(params.max)
			if (params.sort && params.order) order(params.sort, params.order)
		}
		
		def queryWithoutOrder = {
			if (params.mantis) eq('mantis', Long.valueOf(params.mantis))
			if (params.status && params.status != ' ') eq('status', RequirementStatus.values().find {it.name() == params.status})
		}
		
		[requirementInstanceList: Requirement.createCriteria().list(queryWithOrder), requirementInstanceTotal: Requirement.createCriteria().count(queryWithoutOrder), status: params.status, mantis: params.mantis]
	}

	def create () {
		[requirementInstance: new Requirement(params)]
	}

	def save (RequirementCommand command) {
		def requirementInstance
		command.creator = user
		
		if (command.hasErrors()) {
			render(view: "create", model: [requirementInstance: command])
		} else {
			requirementInstance = requirementService.createNewRequirement(command);
			flash.message = message(code: 'default.created.message', args: [message(code: 'requirement.label', default: 'Requirement'), requirementInstance.id])
			redirect(action: "show", id: requirementInstance.id)
		}
	}

	def show (Long id) {
		def requirementInstance = Requirement.get(id)
		if (!requirementInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'requirement.label', default: 'Requirement'), id])
			redirect(action: "list")
			return
		}

		[requirementInstance: requirementInstance, timeDistributionGraphData: getTimeDistributionGraphData(requirementInstance)]
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

	def update (RequirementCommand command) {
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

	def delete (Long id) {
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

	def getUser () {
		User.get(springSecurityService.principal.id)
	}
		
	def getTimeDistributionGraphData(Requirement requirement) {
		def result = new Expando()
		def estimations = requirement.tasks.inject([]) {total, item -> total + item.estimations}?.sort{it.dateCreated}
		def lastTaskEstimation = [:]
		
		result.activities = []
		result.estimations = []
		
		estimations.each { Estimation estimation ->
			lastTaskEstimation[estimation.task] = estimation.minutes
			result.estimations << lastTaskEstimation.values().collect {it.value}.sum()
		}

		estimations.each {
			def activity = Activity.findByEstimationToFinishTask(it)
			if (activity) {
				result.activities << (activity.minutes + (result.activities ? result.activities[-1] : 0))
			} else {
				result.activities << (result.activities ? result.activities[-1] : 0)
			}
		}
		return result
	}

	class RequirementCommand {
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
