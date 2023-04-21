package com.MyReaderSpace.registration;

import java.util.regex.Pattern;

import java.util.regex.Matcher;

public class SearchTitle {
	public boolean searchText(String s1, String s2) {
		Pattern pattern = Pattern.compile(s1, Pattern.CASE_INSENSITIVE);
	    Matcher matcher = pattern.matcher(s2);
	    boolean matchFound = matcher.find();
	    if(matchFound) {
	      return true;
	    } else {
	    	return false;
	    }
	}
}
