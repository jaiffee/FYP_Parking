package com.property.entities;

public class Responce {
	
	private boolean success;
	private String message;
	private String username;
	
	
	public Responce(boolean success, String message, String username) {
		super();
		this.success = success;
		this.message = message;
		this.username = username;
	}


	public boolean isSuccess() {
		return success;
	}


	public void setSuccess(boolean success) {
		this.success = success;
	}


	public String getMessage() {
		return message;
	}


	public void setMessage(String message) {
		this.message = message;
	}


	public String getUsername() {
		return username;
	}


	public void setUsername(String username) {
		this.username = username;
	}
	
	
	
	

}
