package com.trackmanager


class FlowController {
	
	MantisService mantisService

    def createRequirementProcessFlow = {
		ini {
			action {
				
				[issues: [],projects:Project.list()]
			}
			on("success").to "selectMantis"
			on(Exception).to "skip"
		}
		selectMantis {
			on("continue"){
				def issue = mantisService.getIssue(Long.valueOf(params.mantis))
				[mantis: issue.id, title: issue.summary, description: issue.description]
			}.to "enterRequirementDetails"
			on("skip").to "skip"
			on("cancel").to "cancel"
		}
		enterRequirementDetails { 
			redirect(controller:"requirement", action:"create", params: [mantis: flow.mantis, title: flow.title, description: flow.description])
		}
		skip {
			redirect(controller:"requirement", action:"create")
		}
		cancel {
			redirect(controller:"requirement", action:"list")
		}
	}
		
	def createTaskProcessFlow = {
		ini {
			action  {[requirementInstanceList: Requirement.list(sort: "id", order: "desc"), requirementInstanceTotal: Requirement.count()]}
			on("success").to "selectRequirement"
		}
		selectRequirement {
			on("continue") {
				[requirement: params.requirement]
				
			}.to "enterTaskDetails"
			on("cancel").to "cancel"
		}
		enterTaskDetails {
			redirect(controller: "task", action: "create", params: ["requirement.id": flow.requirement, lastFlowStep: true])
		}
		cancel {
			redirect(controller:"task", action:"list")
		}
	}
	
	def createEstimationProcessFlow = {
		ini {
			action {[requirementInstanceList: Requirement.list(sort: "id", order: "desc"), requirementInstanceTotal: Requirement.count()]}
			on("success").to "selectRequirement"
		}
		selectRequirement {
			on("continue") {
				[requirement: params.requirement]
				
			}.to "getRequirementTasks"
			on("cancel").to "cancel"
		}
		getRequirementTasks {
			action {
				[taskInstanceList: Requirement.get(flow.requirement).tasks]
			}
			on("success").to "selectTask"
		}
		selectTask {
			on("continue"){
				[task: params.task]
			}.to "enterEstimationDetails"
			on("cancel").to "cancel"
		}
		enterEstimationDetails {
			redirect(controller: "estimation", action: "create", params: ["task.id": flow.task, lastFlowStep: true])
		}
		cancel {
			redirect(controller:"estimation")
		}
	}

	def createActivityProcessFlow = {
		ini {
			action {[requirementInstanceList: Requirement.list(sort: "id", order: "desc"), requirementInstanceTotal: Requirement.count()]}
			on("success").to "selectRequirement"
		}
		selectRequirement {
			on("continue") {
				[requirement: params.requirement]
				
			}.to "getRequirementTasks"
			on("cancel").to "cancel"
		}
		getRequirementTasks {
			action {
				[taskInstanceList: Requirement.get(flow.requirement).tasks]
			}
			on("success").to "selectTask"
		}
		selectTask {
			on("continue"){
				[task: params.task]
			}.to "enterActivityDetails"
			on("cancel").to "cancel"
		}
		enterActivityDetails {
			redirect(controller: "activity", action: "create", params: ["task.id": flow.task, lastFlowStep: true])
		}
		cancel {
			redirect(controller:"estimation")
		}
	}
	
}
