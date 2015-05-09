package com.src.rivalrooster;

import java.util.ArrayList;
import java.util.List;

public class GraphVO {
	private List<String> xticks = new ArrayList<String>();
	private List<Integer> values = new ArrayList<Integer>();
	public List<String> getXticks() {
		return xticks;
	}
	public void setXticks(List<String> xticks) {
		this.xticks = xticks;
	}
	public List<Integer> getValues() {
		return values;
	}
	public void setValues(List<Integer> values) {
		this.values = values;
	}
	
	

}
