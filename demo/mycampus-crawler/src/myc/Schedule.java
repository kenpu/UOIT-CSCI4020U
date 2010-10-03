package myc;

import java.util.Vector;

public class Schedule {
	public String type;
	public String time;
	public String days;
	public String where;
	public String daterange;
	public String scheduletype;
	public Vector<Instructor> instructor_list;
	
	public Schedule() {
		this.instructor_list = new Vector<Instructor>();
	}
}
