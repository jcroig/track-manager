package com.trackmanager

import org.codehaus.groovy.grails.plugins.orm.auditable.AuditLogEvent

class ChangeEventService {

    static transactional = true

    def serviceMethod() {

    }
	
	public List<ChangeEvent> getLastChangeEvents(int n) {
		def events = [] as Set
		def offset = 0

		while(events.size() < n) {
			def auditLogEvents = AuditLogEvent.list(sort: 'dateCreated', order:'desc', max: n, offset: offset)
			auditLogEvents.each {
				if(events.size() >= n) return
					events << new ChangeEvent(it)
			}
			if(auditLogEvents.size() < n) break
				offset += n
		}
		return events.sort {a, b -> b.dateCreated <=> a.dateCreated}.asList()
	}
	
	public List<ChangeEvent> findAllChangeEventsByClassNameAndPersistedObjectId(String className, String PersistedObjectId) {
		def events = [] as Set
		AuditLogEvent.findAllByClassNameAndPersistedObjectId(className, PersistedObjectId).each {
			events << new ChangeEvent(it)
		}
		return events.sort {a, b -> b.dateCreated <=> a.dateCreated}.asList()	
	}	
	
	public List<ChangeEvent> getTaskChangeEvents(Task task) {
		def events = findAllChangeEventsByClassNameAndPersistedObjectId(Task.class.name, task.id.toString());
		task.estimations.each {events.addAll(findAllChangeEventsByClassNameAndPersistedObjectId(Estimation.class.name, it.id.toString()))}
		task.activities.each {events.addAll(findAllChangeEventsByClassNameAndPersistedObjectId(Activity.class.name, it.id.toString()))}
		
		return events.sort {a, b -> b.dateCreated <=> a.dateCreated}.asList()
	}
	
	public List<ChangeEvent> getRequirementChangeEvents(Requirement requirement) {
		def events = findAllChangeEventsByClassNameAndPersistedObjectId(Requirement.class.name, requirement.id.toString());
		requirement.tasks.each {events.addAll(getTaskChangeEvents(it))}
		
		return events.sort {a, b -> b.dateCreated <=> a.dateCreated}.asList()
	}
}
