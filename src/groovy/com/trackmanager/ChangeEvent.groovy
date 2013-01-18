package com.trackmanager

import java.util.Date;
import org.codehaus.groovy.grails.plugins.orm.auditable.AuditLogEvent

class ChangeEvent {
	private AuditLogEvent event
	Set<AuditLogEvent> details = []
	
	public ChangeEvent(AuditLogEvent auditLogEvent) {
		this.event = auditLogEvent
	}
	
	public Date getDateCreated() {
		return event?.dateCreated
	}
	
	public Date getLastUpdated() {
		return event?.lastUpdated
	}
	
	public String getActor() {
		return event?.actor
	}

	public String getClassName() {
		return event?.className
	}
	
	public String getPersistedObjectId() {
		return event?.persistedObjectId
	}
	
	public Set<AuditLogEvent> getDetails() {
		if(!details && event?.eventName == "UPDATE") {
			this.details = AuditLogEvent.findAllWhere(eventName: "UPDATE", dateCreated: event?.dateCreated, className: event?.className, persistedObjectId: event?.persistedObjectId)
		}
		return details
	}
	
	public EventType getEventType() {
		if("INSERT" == event?.eventName) return EventType.CREATED
		if("UPDATE" == event?.eventName) return EventType.MODIFIED
		if("DELETE" == event?.eventName) return EventType.DELETED
		
		return null  
	}
	
	public String toString(){
		return "$dateCreated $className $persistedObjectId $eventType $actor"
	}
	
	@Override
	public boolean equals(Object that) {
		if (this.is(that)) return true
		if (that == null) return false;
		if (getClass() != that.getClass()) return false;
		if (dateCreated ? !(dateCreated == that.dateCreated) : that.dateCreated) return false
		if (className ? !(className == that.className) : that.className) return false
		if (persistedObjectId ? !(persistedObjectId == that.persistedObjectId) : that.persistedObjectId) return false
		if (eventType ? !(eventType == that.eventType) : that.eventType) return false
		
		return true
	}
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ (dateCreated ? 0 : dateCreated.hashCode());
		result = prime * result + (className ? 0 : className.hashCode());
		result = prime * result + (persistedObjectId ? 0 : persistedObjectId.hashCode());
		result = prime * result + (eventType ? 0 : eventType.hashCode());
		
		return result;
	}	
	
	public static enum EventType {
		CREATED("eventType.create.label"), MODIFIED("eventType.modified.label"), DELETED("eventType.deleted.label");
		String messageCode
		
		public EventType(String messageCode) {
			this.messageCode = messageCode
		}
	}

}
