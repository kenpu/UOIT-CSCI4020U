CP = ./lib/antlr-3.3-complete.jar:./lib/gson-1.6.jar:./bin:.
ANTLR = java -cp ../../lib/antlr-3.3-complete.jar org.antlr.Tool
JAVAC = javac -cp $(CP)
autojar = java -jar ./lib/autojar.jar

all: myc jar bin/myc/tryLexer.class py

myc: 	bin/myc/Instructor.class \
	bin/myc/Schedule.class \
	bin/myc/Section.class \
	bin/myc/SectionHandler.class \
	bin/myc/MycampusLexer.class \
	bin/myc/MycampusParser.class \
	bin/parseMyc.class

src/myc/MycampusLexer.java : src/myc/MycampusLexer.g
	cd src/myc; \
	$(ANTLR) MycampusLexer.g

src/myc/MycampusParser.java : src/myc/MycampusParser.g \
	src/myc/MycampusLexer.java
	cd src/myc; \
	$(ANTLR) MycampusParser.g

bin/myc/Instructor.class : src/myc/Instructor.java
	$(JAVAC) -d bin -s src src/myc/Instructor.java

bin/myc/Schedule.class : src/myc/Schedule.java bin/myc/Instructor.class
	$(JAVAC) -d bin -s src src/myc/Schedule.java

bin/myc/Section.class : src/myc/Section.java \
                        bin/myc/Instructor.class bin/myc/Schedule.class
	$(JAVAC) -d bin -s src src/myc/Section.java

bin/myc/SectionHandler.class : src/myc/SectionHandler.java \
                               bin/myc/Section.class
	$(JAVAC) -d bin -s src src/myc/SectionHandler.java

bin/myc/MycampusLexer.class : src/myc/MycampusLexer.java
	$(JAVAC) -d bin -s src src/myc/MycampusLexer.java

bin/myc/MycampusParser.class : src/myc/MycampusParser.java
	$(JAVAC) -d bin -s src src/myc/MycampusParser.java

bin/parseMyc.class : src/parseMyc.java
	$(JAVAC) -d bin -s src src/parseMyc.java

bin/myc/tryLexer.class : src/myc/tryLexer.java
	$(JAVAC) -d bin -s src src/myc/tryLexer.java

jar:
	$(autojar) -c $(CP) -o bin/myc_json.jar -m src/Manifest.txt parseMyc.class

py:
	cp src/fetchMyc.py bin
	cp src/storeMyc.py bin

clean:
	rm -rf \
	src/myc/MycampusParser.java \
	src/myc/MycampusLexer.java \
	src/myc/*.tokens *.tokens \
	./bin/*

