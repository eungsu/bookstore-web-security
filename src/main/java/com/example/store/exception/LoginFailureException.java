package com.example.store.exception;

public class LoginFailureException extends StoreException {

	private static final long serialVersionUID = -5708278591909262778L;

	public LoginFailureException(String message) {
		super(message);
	}
}
