package com.property.cont;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.property.entities.ApiResponse;
import com.property.entities.ParkingTaker;
import com.property.entities.Responce;
import com.property.services.TakerService;

@RestController
@RequestMapping("/taker")
public class TakerController {

	@Autowired
	private TakerService takerService;
	
	@CrossOrigin
	@PostMapping("/signup")
	public ResponseEntity<ApiResponse> addUsers(@RequestBody ParkingTaker parkingTaker){
		try {
			this.takerService.addUsers(parkingTaker);
			return new ResponseEntity<ApiResponse>(new ApiResponse(true, "User Registered Successfully"),HttpStatus.OK);
		} catch (Exception e) {
			return new ResponseEntity<ApiResponse>(new ApiResponse(false, e.getMessage()),HttpStatus.BAD_REQUEST);
		}
	}
	
	 @PostMapping("/login")
	 @CrossOrigin
	 public ResponseEntity<Responce> loginUser(@RequestBody ParkingTaker parkingTaker) {
		    Optional<ParkingTaker> optionalTaker = takerService.authenticateUser(parkingTaker.getEmail(), parkingTaker.getPassword());
		    
		    if (optionalTaker.isPresent()) {
		        ParkingTaker taker = optionalTaker.get();
		        return new ResponseEntity<>(new Responce(true, "User login successfully", taker.getName()), HttpStatus.OK);
		    } else {
		        return new ResponseEntity<>(new Responce(false, "Invalid Credentials", null), HttpStatus.UNAUTHORIZED);
		    }
		}

	
	
}
