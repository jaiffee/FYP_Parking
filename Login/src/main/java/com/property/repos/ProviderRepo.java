package com.property.repos;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.property.entities.ParkingProvider;

public interface ProviderRepo extends JpaRepository<ParkingProvider, Integer> {
	Optional<ParkingProvider> findByEmail(String email);

}
