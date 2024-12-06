package com.property.services;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.property.entities.ParkingProvider;
import com.property.repos.ProviderRepo;

@Service
public class ProviderService {
	
	@Autowired
	private ProviderRepo providerRepo;
	
	public ParkingProvider addUsers(ParkingProvider providers) throws Exception  {
		if (providerRepo.findByEmail(providers.getEmail()).isPresent()) {
            throw new Exception("Email already exists");	
		}
		ParkingProvider save = providerRepo.save(providers);
		return save;
	}
	
	public Optional<ParkingProvider> authenticateUser(String email, String password) {
        Optional<ParkingProvider> provider = providerRepo.findByEmail(email);
        if (provider.isPresent() && provider.get().getPassword().equals(password)) {
            return provider;
        }
        return Optional.empty();
    }

}
