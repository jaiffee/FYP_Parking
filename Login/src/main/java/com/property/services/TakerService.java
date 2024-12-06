package com.property.services;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.property.entities.ParkingTaker;
import com.property.repos.TakerRepo;

@Service
public class TakerService {
	
	@Autowired
	private TakerRepo takerRepo;
	
	public ParkingTaker addUsers(ParkingTaker taker) throws Exception  {
		if (takerRepo.findByEmail(taker.getEmail()).isPresent()) {
            throw new Exception("Email already exists");	
		}
		ParkingTaker save = takerRepo.save(taker);
		return save;
	}
	
	public Optional<ParkingTaker> authenticateUser(String email, String password) {
        Optional<ParkingTaker> taker = takerRepo.findByEmail(email);
        if (taker.isPresent() && taker.get().getPassword().equals(password)) {
            return taker;
        }
        return Optional.empty();
    }

}
