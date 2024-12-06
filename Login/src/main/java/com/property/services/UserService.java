//package com.property.services;
//
//import java.util.Optional;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Service;
//
//import com.property.entities.User;
//import com.property.repos.UserRepo;
//
//@Service
//public class UserService {
//	
//	@Autowired
//	private UserRepo userRepo;
//	
//	public User addUsers(User users) throws Exception  {
//		if (userRepo.findByEmail(users.getEmail()).isPresent()) {
//            throw new Exception("Email already exists");	
//		}
//		User user = userRepo.save(users);
//		return user;
//	}
//	
//	public Optional<User> authenticateUser(String email, String password) {
//        Optional<User> user = userRepo.findByEmail(email);
//        if (user.isPresent() && user.get().getPassword().equals(password)) {
//            return user;
//        }
//        return Optional.empty();
//    }
//}
