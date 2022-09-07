package com.example.store.exception;

public class AlreadyUsedEmailException extends StoreException {

	private static final long serialVersionUID = 7151583059845095990L;

	public AlreadyUsedEmailException(String message) {
		super(message);
	}
}
