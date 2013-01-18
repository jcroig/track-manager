package com.trackmanager

import grails.test.*

class UserIntegrationTests extends GroovyTestCase {
    protected void setUp() {
        super.setUp()
    }

    protected void tearDown() {
        super.tearDown()
    }

	void testCRUDOperations() {
		def user =  new User(name:'Juan Carlos', firstSurname:'Roig', secondSurname:'C‡rdenas', userName:'jcroig', password:'prova', email:'jcroig@gmail.com')		
		user.save()
		
		def userId = user.id
		user.password = 'New password'
		user = User.get(userId)
		
		assert 'New password' == user.password
		assert 'Juan Carlos' == user.name
		
		user.delete()
		assert null == User.get(userId)

		
	}
	
    void testSomething() {

    }
}
