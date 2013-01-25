package com.trackmanager

import java.io.Serializable;

import com.trackmanager.Requirement.RequirementStatus;

class Task implements Serializable{

	static searchable = true
	static auditable = true
	static transients = [ "firstEstimation", "lastEstimation", "reportedMinutes", "readyToReport", "finished"]
	static hasMany = [estimations: Estimation, activities: Activity]

	static belongsTo = [Requirement]

	Requirement requirement
	String description
	User responsible
	TaskType type
	TaskStatus status

	static constraints = {
		description(nullable: true)
		requirement(nullable: false)
		responsible(nullable: true)
	}
	
	boolean isFinished () {
		return status == TaskStatus.FINISHED
	}

	Estimation getFirstEstimation() {
		if(!estimations || estimations.size() == 0) return null
		return estimations.sort {a, b -> a.dateCreated.compareTo b.dateCreated}[0]
	}
	
	long getReportedMinutes() {
		if (!activities) return 0
		else return (activities*.minutes).sum()
	}

	boolean isReadyToReport() {
		if (status == TaskStatus.FINISHED || !estimations) return false

		def result = true
		requirement.tasks.each {
			if(it.type.id < type.id && it.status != TaskStatus.FINISHED) result = false
		}
		return result
	}

	Estimation getLastEstimation() {
		if(!estimations || estimations.size() == 0) return null
		return estimations.sort {a, b -> a.dateCreated.compareTo b.dateCreated}[estimations.size()-1]
	}

	void refreshStatus () {
		if (!estimations) {
			status = TaskStatus.NOT_STARTED
		} else if (!activities) {
			status = TaskStatus.ESTIMATED
		} else if (lastEstimation.minutes > 0) {
			status = TaskStatus.ONGOING
		} else {
			status = TaskStatus.FINISHED
		}

		requirement.refreshStatus()
	}

	String toString() {
		"id: $id, requirement: [$requirement], description: $description, responsible: $responsible, type: $type, status: $status";
	}

	public static enum TaskType {
		ANALYSIS(0), DEVELOPMENT(1), TEST(2), FIX(3), DEPLOY(4);
		final Integer id
		TaskType(Integer id) {
			this.id = id
		}

		static TaskType valueOf(Integer id) {
			return TaskType.values().find {it.id == id}
		}
	}

	public static enum TaskStatus {
		NOT_STARTED(0), ESTIMATED(1), ONGOING(2), FINISHED(3);
		final Integer id

		TaskStatus(Integer id) {
			this.id = id
		}
	}
}
