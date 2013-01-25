package com.trackmanager

import com.trackmanager.Requirement.RequirementStatus;
import com.trackmanager.Task.TaskStatus;
import com.trackmanager.Task.TaskType;

class RequirementService {

	static transactional = true

	Requirement createNewRequirement (command) {
		def requirement = new Requirement(command.properties)
		requirement.status = RequirementStatus.NEW
		def initialTask = new Task(type: TaskType.ANALYSIS, status: TaskStatus.NOT_STARTED, description: "Analysis")

		requirement.addToTasks(initialTask)
		requirement.save(flush: true, failOnError: true)

		return requirement;
	}

	Requirement updateRequirement(requirement, command) {
		requirement.properties = command.properties
		requirement.save(flush: true, failOnError: true)

		return requirement
	}

	long getInitialEstimationMinutesFromTasksByType(requirement, type) {
		long totalMinutes = 0;
		if(requirement.tasks){
			requirement.tasks.findAll{it.type.equals type}.each {Task task->
				totalMinutes += task.firstEstimation?.minutes ?: 0
			}
		}
		return totalMinutes
	}

	long getLastEstimationMinutesFromTasksByType(requirement, type) {
		long totalMinutes = 0;
		if(requirement.tasks) {
			requirement.tasks.findAll{it.type.equals type}.each {Task task->
				totalMinutes += task.lastEstimation?.minutes ?: 0
			}
		}
		return totalMinutes
	}

	long getTotalReportedMinutesFromTasksByType(requirement, type) {
		long totalMinutes = 0
		if(requirement.tasks) {
			requirement.tasks.findAll{it.type.equals type}.each {Task task ->
				totalMinutes += task.reportedMinutes
			}
		}
		return totalMinutes
	}
}
