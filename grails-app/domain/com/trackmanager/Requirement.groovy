package com.trackmanager

import java.io.Serializable;

import com.trackmanager.Task.TaskStatus;
import com.trackmanager.Task.TaskType;

class Requirement implements TimetableEntity, Serializable{
	static mapping = {
			description type: 'text'
		}
	
	static searchable = true
	static auditable = true
	static transients = ["reportedMinutes", "estimatedMinutesToFinish", "activities", "estimations"]
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
    }
	
	def getActivities () {
		def result = []
		tasks.each { task ->
			result.addAll(task.activities)
		}
		
		return result
	}
	
	Long getReportedMinutes () {
		if(!tasks) return 0
		else (tasks*.reportedMinutes).sum()
	}
	
	Long getEstimatedMinutesToFinish () {
		if(status == RequirementStatus.FINISHED) return 0
		else {
			def expectedTasksminutes = [0]
			expectedTasksminutes.addAll(tasks.findAll {it.status != TaskStatus.FINISHED}*.lastEstimation?.minutes)
			return expectedTasksminutes.sum()
		}
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
					status = statusTasks[TaskType.ANALYSIS].find {TaskStatus.ONGOING == it.status || TaskStatus.ESTIMATED == it.status} ? RequirementStatus.ANALYZING : RequirementStatus.NEW
				} else if(statusTasks[TaskType.DEVELOPMENT]) {
					status = statusTasks[TaskType.DEVELOPMENT].find {TaskStatus.ONGOING == it.status || TaskStatus.ESTIMATED == it.status} ? RequirementStatus.DEVELOPING : RequirementStatus.ESTIMATED
				} else if(statusTasks[TaskType.FIX]) {
					status = statusTasks[TaskType.FIX].find {TaskStatus.ONGOING == it.status || TaskStatus.ESTIMATED == it.status} ? RequirementStatus.FIXING : RequirementStatus.READY_FIX
				} else if(statusTasks[TaskType.TEST]) {
					status = statusTasks[TaskType.TEST].find {TaskStatus.ONGOING == it.status || TaskStatus.ESTIMATED == it.status} ? RequirementStatus.TESTING : RequirementStatus.READY_TEST
				} else if(statusTasks[TaskType.DEPLOY]) {
					status = statusTasks[TaskType.DEPLOY].find {TaskStatus.ONGOING == it.status || TaskStatus.ESTIMATED == it.status} ? RequirementStatus.DEPLOYING : RequirementStatus.READY_DEPLOY
				}
			}
		}
	}
	
	String toString() {
		return "Id: $id, Mantis: $mantis, Title: $title"
	}
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((description == null) ? 0 : description.hashCode());
		result = prime * result + ((mantis == null) ? 0 : mantis.hashCode());
		result = prime * result + ((status == null) ? 0 : status.hashCode());
		result = prime * result + ((title == null) ? 0 : title.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Requirement other = (Requirement) obj;
		if (description == null) {
			if (other.description != null)
				return false;
		} else if (!description.equals(other.description))
			return false;
		if (mantis == null) {
			if (other.mantis != null)
				return false;
		} else if (!mantis.equals(other.mantis))
			return false;
		if (status != other.status)
			return false;
		if (title == null) {
			if (other.title != null)
				return false;
		} else if (!title.equals(other.title))
			return false;
		return true;
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
