package com.trackmanager

class Estimation {

	static auditable = true
	static transients = [ "lastTaskEstimation"]
	static belongsTo = [User, Task]
	
	User user
	Task task
	Date dateCreated
	Long minutes
	
    static constraints = {
		user(nullable: false)
		task(nullable: false)
		minutes(min: Long.valueOf(0))
    }
	
	boolean isLastTaskEstimation() {
		def lastEstimation =  task.lastEstimation
		return lastEstimation == this
	}
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Estimation other = (Estimation) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		return true;
	}

	String toString() {
		"id: $id, user: [${user}], task: [${task}], date: $dateCreated, minutes: $minutes"
	}
}
