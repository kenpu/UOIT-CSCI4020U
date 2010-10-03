package myc;

import java.util.Vector;

public class Section {
	public String title;
	public String CRN;
	public String code;
	public String number;
	public String semester;
	public String year;
	public String registration;
	public String levels;
	public Vector<Instructor> instructor_list;
	public String campus;
	public String credits;
	public transient Vector<String> availability;
	public String capacity;
	public String actual;
	public Vector<Schedule> schedule_list;
	
	public Section() {
		this.instructor_list = new Vector<Instructor>();
		this.availability = new Vector<String>();
		this.schedule_list = new Vector<Schedule>();
	}
}
