package com.property.repos;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.property.entities.ParkingTaker;

public interface TakerRepo extends JpaRepository<ParkingTaker, Integer> {
	
	Optional<ParkingTaker> findByEmail(String email);
}
