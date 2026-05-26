package com.univ.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.univ.entity.UserDtls;
import com.univ.entity.UserLocation;
@Repository
public interface UserLocationRepository  extends JpaRepository<UserLocation,Integer> {
	 // Get latest location of a user
    UserLocation findFirstByUserOrderByIdDesc(UserDtls user);

    // Get location by user
    UserLocation findByUser(UserDtls user);

}
