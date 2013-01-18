package com.trackmanager

import java.util.Date;
import org.codehaus.groovy.grails.validation.exceptions.ConstraintException


class ActivityService {

    static transactional = true
	
	def createNewActivity(command) {	
		Activity activity = new Activity(command.properties)		
		activity.estimationToFinishTask.save(failOnError: true)
		activity.task.addToActivities(activity)
		activity.task.refreshStatus()
		activity.save(flush:true, failOnError:true)
		
		return activity
	}
	
	
	def updateActivity(activity, command) throws ConstraintException {
		activity.date = command.date
		activity.minutes = command.minutes
		activity.observations = command.observations
		
		def estimation = activity.estimationToFinishTask
		if(estimation.minutes != command.expectedMinutesToFinishTask) {
			if(!estimation.lastTaskEstimation) {
				throw new ConstraintException("Only last task's estimation can be changed")
			}
			estimation.minutes = command.expectedMinutesToFinishTask
			estimation.save(failOnError:true)

		}
		activity.task.refreshStatus()
		activity.save(flush:true, failOnError:true)
		
		return activity
	}
}
