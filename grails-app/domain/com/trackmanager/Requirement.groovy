package com.trackmanager

import java.io.Serializable;

import com.trackmanager.Task.TaskStatus;
import com.trackmanager.Task.TaskType;

class Requirement implements Serializable{
	static mapping = {
			description type: 'text'
		}
	
	static searchable = true
	static auditable = true
	static transients = ["reportedMinutes", "estimatedMinutesToFinish", "activities"]
	static hasMany = [tasks : Task]
	
	Long mantis
	String title
	String description
	RequirementStatus status

    static constraints = {
		mantis(unique:true)
		title(blank:false)
		description(blank:false)
		status(nullable: false)
		tasks()
    }
	
	long getReportedMinutes() {
		if(!tasks) return 0
		else (tasks*.totalReportedMinutes).sum()
	}
	
	long getEstimatedMinutesToFinish() {
		if(status == RequirementSt>atus.FINISHED) return 0
		else return (tasks.findAll {it.status != TaskStatus.FINISHED}*.lastEstimation*.minutes).sum()
	}
	
	def getActivities () {
		def result = []
		
		tasks.each { task ->
			result.addAll(task.activities)
		}
		
		return result
	}
	
	void refreshStatus () {
		if(status != RequirementStatus.ESTIMATED) {
			status = RequirementStatus.FINISHED

			if(tasks) {
				def statusTasks = [:]
				TaskType.values().each {
					statusTasks[it] = []
				}

				tasks.each {
					if(!TaskStatus.FINISHED.equals(it.status)) statusTasks[it.type] << it
				}

				if(statusTasks[TaskType.ANALYSIS]) {
					status = statusTasks[TaskType.ANALYSIS].find {TaskStatus.ONGOING == it.status} ? RequirementStatus.ANALYZING : RequirementStatus.NEW
				} else if(statusTasks[TaskType.DEVELOPMENT]) {
					status = statusTasks[TaskType.DEVELOPMENT].find {TaskStatus.ONGOING == it.status} ? RequirementStatus.DEVELOPING : RequirementStatus.ESTIMATED
				} else if(statusTasks[TaskType.FIX]) {
					status = statusTasks[TaskType.FIX].find {TaskStatus.ONGOING == it.status} ? RequirementStatus.FIXING : RequirementStatus.READY_FIX
				} else if(statusTasks[TaskType.TEST]) {
					status = statusTasks[TaskType.TEST].find {TaskStatus.ONGOING == it.status} ? RequirementStatus.TESTING : RequirementStatus.READY_TEST
				} else if(statusTasks[TaskType.DEPLOY]) {
					status = statusTasks[TaskType.DEPLOY].find {TaskStatus.ONGOING == it.status} ? RequirementStatus.DEPLOYING : RequirementStatus.READY_DEPLOY
				}
			}
		}
	}
	
	String toString() {
		return "id: $id, mantis: $mantis, title: $title"
	}
	
	public static enum RequirementStatus {
		NEW(0), 
		ANALYZING(1), 
		ESTIMATED(2),
		READY_DEVELOP(3), 
		DEVELOPING(4), 
		READY_FIX(5),
		FIXING(6),
		READY_TEST(7), 
		TESTING(8),
		READY_DEPLOY(9),
		DEPLOYING(10),
		FINISHED(11);
		
		final Integer id
		final boolean manualTransition
		
		RequirementStatus (Integer id) {
			this.id = id
		}
	}
}
