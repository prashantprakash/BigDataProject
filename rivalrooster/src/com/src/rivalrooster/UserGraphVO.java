package com.src.rivalrooster;

import java.util.ArrayList;
import java.util.List;

public class UserGraphVO {

	private List<String> xticks = new ArrayList<String>();
	private List<Integer> values1 = new ArrayList<Integer>();
	private List<Integer> values2 = new ArrayList<Integer>();

	public List<String> getXticks() {
		return xticks;
	}

	public void setXticks(List<String> xticks) {
		this.xticks = xticks;
	}

	public List<Integer> getValues1() {
		return values1;
	}

	public void setValues1(List<Integer> values1) {
		this.values1 = values1;
	}

	public List<Integer> getValues2() {
		return values2;
	}

	public void setValues2(List<Integer> values2) {
		this.values2 = values2;
	}

}
