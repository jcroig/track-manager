package com.trackmanager

import org.apache.commons.lang.builder.HashCodeBuilder

class UserSecurityRoleSecurity implements Serializable {

	UserSecurity userSecurity
	RoleSecurity roleSecurity

	boolean equals(other) {
		if (!(other instanceof UserSecurityRoleSecurity)) {
			return false
		}

		other.userSecurity?.id == userSecurity?.id &&
			other.roleSecurity?.id == roleSecurity?.id
	}

	int hashCode() {
		def builder = new HashCodeBuilder()
		if (userSecurity) builder.append(userSecurity.id)
		if (roleSecurity) builder.append(roleSecurity.id)
		builder.toHashCode()
	}

	static UserSecurityRoleSecurity get(long userSecurityId, long roleSecurityId) {
		find 'from UserSecurityRoleSecurity where userSecurity.id=:userSecurityId and roleSecurity.id=:roleSecurityId',
			[userSecurityId: userSecurityId, roleSecurityId: roleSecurityId]
	}

	static UserSecurityRoleSecurity create(UserSecurity userSecurity, RoleSecurity roleSecurity, boolean flush = false) {
		new UserSecurityRoleSecurity(userSecurity: userSecurity, roleSecurity: roleSecurity).save(flush: flush, insert: true)
	}

	static boolean remove(UserSecurity userSecurity, RoleSecurity roleSecurity, boolean flush = false) {
		UserSecurityRoleSecurity instance = UserSecurityRoleSecurity.findByUserSecurityAndRoleSecurity(userSecurity, roleSecurity)
		if (!instance) {
			return false
		}

		instance.delete(flush: flush)
		true
	}

	static void removeAll(UserSecurity userSecurity) {
		executeUpdate 'DELETE FROM UserSecurityRoleSecurity WHERE userSecurity=:userSecurity', [userSecurity: userSecurity]
	}

	static void removeAll(RoleSecurity roleSecurity) {
		executeUpdate 'DELETE FROM UserSecurityRoleSecurity WHERE roleSecurity=:roleSecurity', [roleSecurity: roleSecurity]
	}

	static mapping = {
		id composite: ['roleSecurity', 'userSecurity']
		version false
	}
}
