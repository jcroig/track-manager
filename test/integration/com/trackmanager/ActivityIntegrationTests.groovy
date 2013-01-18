package com.trackmanager

import grails.test.*

class ActivityIntegrationTests extends GroovyTestCase {
	
	User user
	Requirement requirement
	Task task
    
	protected void setUp() {
        super.setUp()
		user = new User(name:'Juan Carlos', firstSurname:'Roig', secondSurname:'C‡rdenas', userName:'jcroig', password:'prova', email:'jcroig@gmail.com').save()
		requirement = new Requirement(description:'Requerimiento prova', mantis:Long.valueOf(1212)).save()
		task = new Task(description:'An‡lisis', requirement:requirement).save()
    }

    protected void tearDown() {
        super.tearDown()
    }
	
	void testCRUDOperations() {
		def activity = new Activity(user:user, task:task, date:new Date(), minutes:Long.valueOf(15))
		activity.validate()
		println activity.errors
		activity.save()
		
		def activityId = activity.id
		activity.minutes = Long.valueOf(30)
		activity = Activity.get(activityId)
		
		assert Long.valueOf(30) == activity.minutes
		assert task == activity.task
		
		activity.delete()
		assert null == Activity.get(activityId) 
	}

    void testSomething() {

    }
}
