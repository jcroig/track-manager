package com.trackmanager

class User extends UserSecurity {

	static hasMany = [estimations: Estimation, activities: Activity]
	
	String name
	String firstSurname
	String secondSurname
	Date   birthDate
	String email
    
	static constraints = {
		name(blank:false)
		firstSurname()
		secondSurname(nullable:true)
		birthDate(nullable:true)
		email(blank:false, email:true)
    }
	
	String toString() {
		"$username"
	}
}
