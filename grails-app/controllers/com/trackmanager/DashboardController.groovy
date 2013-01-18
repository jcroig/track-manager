package com.trackmanager

import org.codehaus.groovy.grails.plugins.orm.auditable.AuditLogEvent
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils;

import com.trackmanager.Task.TaskStatus;


class DashboardController {
	def springSecurityService
	def changeEventService
	def taskService

	def index = {
		def totalMyActivities = myActivities.size() > 0 ? myActivities.sum {it.activities.size()} : 0
		def model = [:]
		model['myTasks'] = taskService.getUserPendentTasks(user)
		model['myActivities'] = myActivities
		model['totalMyActivities'] = totalMyActivities
		model['events'] = events
		model['tasks'] = Task.list()
		model['requirements'] = Requirement.list()
		if(SpringSecurityUtils.ifAllGranted("ROLE_ADMIN")) model['unassignedTasks'] = getUnassignedTasks()
		
		render(view:"show", model: model)
	}

	def visualizeDayActivities = {
		if(!params.date || !(params.date ==~ /\d\d\/\d\d\/\d\d\d\d/)) {
			render(view:"error")
			return
		}
		def date = Date.parse("dd/MM/yyyy", params.date)
		def activities = Activity.findAllByDateAndUser(date, getUser())

		render(view:"activitiesDayVisualization", model: [activities: activities, date: date])
	}

	def getUser() {
		User.get(springSecurityService.principal.id)
	}

	def getUnassignedTasks() {
		return Task.findAllByResponsibleIsNull()
	}

	def getMyTasks() {
		def unfinishedUserTasks = Task.findAllByResponsibleAndStatusNotEqual(getUser(), TaskStatus.FINISHED)
		
	}

	def getMyActivities() {
		def activities = Activity.findAllByUser(getUser())
		if (activities) {
			def groupedActivities = []
			activities = activities.sort ({a, b -> b.date <=> a.date} as Comparator)
			activities.groupBy {it.date}.each {key, value ->
				def activitiesDay = new Expando()
				activitiesDay.date = key
				activitiesDay.activities = value
				activitiesDay.totalMinutes = value.sum { it.minutes }
				groupedActivities << activitiesDay
			}

			activities = groupedActivities
		}
		return activities
	}

	def getEvents() {
		return changeEventService.getLastChangeEvents(50)
	}
}
