package myc;

class Instructor {
	String name;
	String position;
	public Instructor(String name, String position) {
		this.name = name;
		this.position = position;
	}
	public Instructor(String name) {
		this(name, null);
	}
}
