package com.example.demo.model;

/**
 * Data transfer object representing a todo item.
 */
public class TodoDTO {
	private int id;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTest() {
		return test;
	}
	public void setTest(String test) {
		this.test = test;
	}
        private String test;

}
