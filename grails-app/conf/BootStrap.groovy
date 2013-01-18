import com.trackmanager.Project
import com.trackmanager.RoleSecurity
import com.trackmanager.User
import com.trackmanager.UserSecurityRoleSecurity;

class BootStrap {
	def springSecurityService
	
	def init = { servletContext ->
	
		def devRole = RoleSecurity.findByAuthority('ROLE_DEVELOPER') ?: new RoleSecurity(authority: 'ROLE_DEVELOPER').save(failOnError: true)
		def adminRole = RoleSecurity.findByAuthority('ROLE_ADMIN') ?: new RoleSecurity(authority: 'ROLE_ADMIN').save(failOnError: true)
   
		def admin = User.findByUsername('admin') ?: new User(
			username: 'admin',
			password: 'admin',
			enabled: true,
			name: 'admin',
			firstSurname: 'admin',
			birthDate: new Date(),
			email:'admin@admin.com').save(failOnError: true)
			
		def developer1 = User.findByUsername('developer1') ?: new User(
			username: 'developer1',
			password: 'developer1',
			enabled: true,
			name: 'developer1',
			firstSurname: 'developer1',
			birthDate: new Date(),
			email:'dev1@dev1.com').save(failOnError: true)
		
		def developer2 = User.findByUsername('developer2') ?: new User(
			username: 'developer2',
			password: 'developer2',
			enabled: true,
			name: 'developer2',
			firstSurname: 'developer2',
			birthDate: new Date(),
			email:'dev2@dev2.com').save(failOnError: true)

		if (!admin.authorities.contains(adminRole)) UserSecurityRoleSecurity.create admin, adminRole
		if (!developer1.authorities.contains(devRole)) UserSecurityRoleSecurity.create developer1, devRole
		if (!developer2.authorities.contains(devRole)) UserSecurityRoleSecurity.create developer2, devRole
		
		def project = new Project(name:"PSSJD", mantisProject:["2", "40"]).save(failOnError: true)
	}
	
	def destroy = {
	}
}
