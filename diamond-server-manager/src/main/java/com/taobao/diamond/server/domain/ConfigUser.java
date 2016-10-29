package com.taobao.diamond.server.domain;

import java.io.Serializable;

public class ConfigUser implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private long id;
	private String userIds;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getUserIds() {
		return userIds;
	}

	public void setUserIds(String userIds) {
		this.userIds = userIds;
	}
	
	public ConfigUser() {
	}
	
	public ConfigUser(long id, String userIds) {
		this.id = id;
		this.userIds = userIds;
	}

}
