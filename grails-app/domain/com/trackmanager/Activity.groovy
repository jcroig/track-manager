package com.trackmanager

class Activity {
	static auditable = true
	static transients = ["expectedMinutesToFinishTask"]
	static belongsTo = [User, Task]

	User user
	Task task
	Date date
	Long minutes
	String observations
	Estimation estimationToFinishTask;

	static constraints = {
		user(nullable: false)
		task(nullable: false)
		minutes(min: Long.valueOf(1))
		observations(nullable:true, blank:true)
		estimationToFinishTask(nullable: false)
	}


	Long getExpectedMinutesToFinishTask() {
		if(estimationToFinishTask) return estimationToFinishTask.minutes
		else return null
	}


	String toString() {
		"user: [$user], task: [$task], date: $date, minutes: $minutes"
	}
}
