package com.trackmanager

import java.io.Serializable;

import com.trackmanager.Requirement.RequirementStatus;

class Task implements TimetableEntity, Serializable {

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

	Estimation getFirstEstimation () {
		if(!estimations || estimations.size() == 0) return null
		return estimations.sort {a, b -> a.dateCreated.compareTo b.dateCreated}[0]
	}
	
	Estimation getLastEstimation () {
		if(!estimations || estimations.size() == 0) return null
		return estimations.sort {a, b -> a.dateCreated.compareTo b.dateCreated}[estimations.size()-1]
	}
	
	Long getReportedMinutes () {
		if (!activities) return 0
		else return (activities*.minutes).sum()
	}
	
	Long getEstimatedMinutesToFinish () {
		def estimation = lastEstimation
		
		if(estimation) return estimation.minutes
		else return 0
	}

	boolean isReadyToReport () {
		if (status == TaskStatus.FINISHED || !estimations) return false

		def result = true
		requirement.tasks.each {
			if(it.type.id < type.id && it.status != TaskStatus.FINISHED) result = false
		}
		return result
	}

	void refreshStatus () {
		if (!estimations) {
			status = TaskStatus.NOT_STARTED
		} else if (!activities) {
			status = TaskStatus.ESTIMATED
		} else if (estimatedMinutesToFinish > 0) {
			status = TaskStatus.ONGOING
		} else {
			status = TaskStatus.FINISHED
		}

		requirement.refreshStatus()
	}

	String toString() {
		"id: $id, requirement: [$requirement], description: $description, responsible: $responsible, type: $type, status: $status";
	}
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((description == null) ? 0 : description.hashCode());
		result = prime * result
				+ ((requirement == null) ? 0 : requirement.hashCode());
		result = prime * result
				+ ((responsible == null) ? 0 : responsible.hashCode());
		result = prime * result + ((status == null) ? 0 : status.hashCode());
		result = prime * result + ((type == null) ? 0 : type.hashCode());
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
		Task other = (Task) obj;
		if (description == null) {
			if (other.description != null)
				return false;
		} else if (!description.equals(other.description))
			return false;
		if (requirement == null) {
			if (other.requirement != null)
				return false;
		} else if (!requirement.equals(other.requirement))
			return false;
		if (responsible == null) {
			if (other.responsible != null)
				return false;
		} else if (!responsible.equals(other.responsible))
			return false;
		if (status != other.status)
			return false;
		if (type != other.type)
			return false;
		return true;
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
