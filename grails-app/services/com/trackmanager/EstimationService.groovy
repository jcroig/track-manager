package com.trackmanager

class EstimationService {
	
	static transactional = true
	
	Estimation createEstimation (command) {
		def estimation = new Estimation(command.properties)		
		estimation.save(flush: true, failOnError: true)
		
		estimation.task.refreshStatus()
		estimation.task.save(flush: true, failOnError: true)

		return estimation;
	}

	Requirement updateEstimation (estimation, command) {
		estimation.properties = command.properties
		estimation.save(flush:true, failOnError:true)
		
		estimation.task.refreshStatus()
		estimation.task.save(flush: true, failOnError: true)

		return estimation
	}
}
