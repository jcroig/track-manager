package com.trackmanager;

import java.util.List;

public class ListElementsDTO {
	List <Object> list;
	Long numResults;
	public List<Object> getList() {
		return list;
	}
	public void setList(List<Object> list) {
		this.list = list;
	}
	public Long getNumResults() {
		return numResults;
	}
	public void setNumResults(Long numResults) {
		this.numResults = numResults;
	}
	

}
