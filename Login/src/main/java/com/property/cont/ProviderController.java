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
import com.property.entities.ParkingProvider;
import com.property.entities.Responce;
import com.property.services.ProviderService;

@RestController
@RequestMapping("/provider")
public class ProviderController {

	@Autowired
	private ProviderService providerService;
	
	@CrossOrigin
	@PostMapping("/signup")
	public ResponseEntity<ApiResponse> addUsers(@RequestBody ParkingProvider parkingProvider){
		try {
			this.providerService.addUsers(parkingProvider);
			return new ResponseEntity<ApiResponse>(new ApiResponse(true, "User Registered Successfully"),HttpStatus.OK);
		} catch (Exception e) {
			return new ResponseEntity<ApiResponse>(new ApiResponse(false, e.getMessage()),HttpStatus.BAD_REQUEST);
		}
	}
	
	 @PostMapping("/login")
	 @CrossOrigin
	    public ResponseEntity<Responce> loginUser(@RequestBody ParkingProvider parkingProvider) {
	        Optional<ParkingProvider> authenticatedUser = providerService.authenticateUser(parkingProvider.getEmail(), parkingProvider.getPassword());
	        if (authenticatedUser.isPresent()) {
	        	ParkingProvider provider = authenticatedUser.get();
	            return new ResponseEntity<>(new Responce(true, "User login successfully",provider.getName()), HttpStatus.OK);
	        } else {
	            return new ResponseEntity<>(new Responce(false, "Invalid Credentials",null), HttpStatus.UNAUTHORIZED);
	        }
	    }
	
	
}
