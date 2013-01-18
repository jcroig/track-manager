package com.trackmanager

class Project implements Serializable{
	
	static hasMany = [mantisProject : String] ;
	String name;
	Customer customer;

    static constraints = {
		name()
		customer(nullable:true)
		mantisProject()
    }

	@Override
	public String toString() {
		return "Project [mantisProject=" + mantisProject + ", name=" + name
				+ ", customer=" + customer + "]";
    }

}
	
	

