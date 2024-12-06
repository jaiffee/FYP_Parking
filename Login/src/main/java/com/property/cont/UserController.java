//package com.property.cont;
//
//import java.util.Optional;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.http.HttpStatus;
//import org.springframework.http.ResponseEntity;
//import org.springframework.web.bind.annotation.CrossOrigin;
//import org.springframework.web.bind.annotation.PostMapping;
//import org.springframework.web.bind.annotation.RequestBody;
//import org.springframework.web.bind.annotation.RestController;
//
//import com.property.entities.ApiResponse;
//import com.property.entities.User;
//import com.property.services.UserService;
//
//@RestController
//public class UserController {
//	
//	@Autowired
//	private UserService userService;
//
//	@CrossOrigin
//	@PostMapping("/signup")
//	public ResponseEntity<ApiResponse> addUsers(@RequestBody User user){
//		try {
//			this.userService.addUsers(user);
//			return new ResponseEntity<ApiResponse>(new ApiResponse(true, "User Registered Successfully"),HttpStatus.OK);
//		} catch (Exception e) {
//			return new ResponseEntity<ApiResponse>(new ApiResponse(false, e.getMessage()),HttpStatus.BAD_REQUEST);
//		}
//	}
//	
////	@PostMapping("/login")
////    public ResponseEntity<User> loginUser(@RequestBody User user) {
////		try {
////		
////			Optional<User> authenticatedUser = userService.authenticateUser(user.getName(), user.getPassword());
////			return ResponseEntity.status(HttpStatus.ACCEPTED).build();
////			
////		} catch (Exception e) {
////			// TODO: handle exception
////		}
////        return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
////    }
//	
//	 @PostMapping("/login")
//	 @CrossOrigin
//	    public ResponseEntity<ApiResponse> loginUser(@RequestBody User user) {
//	        Optional<User> authenticatedUser = userService.authenticateUser(user.getEmail(), user.getPassword());
//	        if (authenticatedUser.isPresent()) {
//	            return new ResponseEntity<>(new ApiResponse(true, "User login successfully"), HttpStatus.OK);
//	        } else {
//	            return new ResponseEntity<>(new ApiResponse(false, "Invalid Credentials"), HttpStatus.UNAUTHORIZED);
//	        }
//	    }
//	
//	
//	
//}
