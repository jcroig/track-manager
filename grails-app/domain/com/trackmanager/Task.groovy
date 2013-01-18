package com.trackmanager

import java.io.Serializable;

import com.trackmanager.Requirement.RequirementStatus;

class Task implements Serializable{
	
	static searchable = true
	static auditable = true
	static transients = [ "firstEstimation", "lastEstimation", "totalReportedMinutes", "readyToReport"]
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
	
	Estimation getFirstEstimation() {
		if(!estimations || estimations.size() == 0) return null
		return estimations.sort {a, b -> a.date.compareTo b.date}[0]
	}
	
	Estimation getLastEstimation() {
		if(!estimations || estimations.size() == 0) return null
		return estimations.sort {a, b -> a.date.compareTo b.date}[estimations.size()-1]
	}
	
	long getTotalReportedMinutes() {
		if (!activities) return 0
		else return (activities*.minutes).sum()
	}	

	void refreshStatus () {
		status = (!activities) ? TaskStatus.NOT_STARTED : (lastEstimation && lastEstimation.minutes > 0) ? TaskStatus.ONGOING : TaskStatus.FINISHED
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
		NOT_STARTED(0), ONGOING(1), FINISHED(2);
		final Integer id
		
		TaskStatus(Integer id) {
			this.id = id
		}
	}
}
