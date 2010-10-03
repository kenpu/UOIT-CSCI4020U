from sqlalchemy import *
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
from sqlalchemy.exc import *
import sys
import json
import re
from datetime import datetime

engn = create_engine('sqlite:///myc.sq3')

Base = declarative_base()

class Course(Base):
  __tablename__ = 'courses'

  code = Column(String, primary_key=True)
  title = Column(String)

class Section(Base):

  __tablename__ = 'sections'

  id = Column(Integer, primary_key=True)
  actual = Column(Integer)
  campus = Column(String)
  capacity = Column(Integer)
  credits = Column(Float)
  levels = Column(String)
  registration_start = Column(Date)
  registration_end = Column(Date)
  semester = Column(String)
  sec_code = Column(String)
  sec_number = Column(String)
  year = Column(String)
  title = Column(String)
  course = Column(String, ForeignKey('courses.code'))

class Instructor(Base):

  __tablename__ = 'instructors'

  id = Column(Integer, primary_key=True)
  lastname = Column(String)
  firstname = Column(String)

class Schedule(Base):

  __tablename__ = 'schedules'

  id = Column(Integer, primary_key=True)
  date_start = Column(Date)
  date_end = Column(Date)
  day = Column(String)
  schedtype = Column(String)
  hour_start = Column(Integer)
  hour_end = Column(Integer)
  min_start = Column(Integer)
  min_end = Column(Integer)
  schedtype2 = Column(String)
  location = Column(String)
  section_id = Column(Integer, ForeignKey('sections.id'))

class Teaches(Base):
  __tablename__ = 'teaches'
  id = Column(Integer, primary_key=True)
  schedule_id = Column(Integer, ForeignKey('schedules.id'))
  instructor_id = Column(Integer, ForeignKey('instructors.id'))
  position = Column(String)

Base.metadata.create_all(engn)

Session = sessionmaker()
Session.configure(bind = engn)
session = Session()

def sections():
  for line in sys.stdin.xreadlines:
    yield json.loads(line)

re_title = re.compile(r'(.*) - (\d{5}) - (\w+ \w+) - (\w+)')
def parse_title(line):
  """
  Blah blah - 75693 - CSCI 3030U - 007
  """
  (title, sec_code, code, sec_num) = re_title.findall(line)[0]
  return (code, title, sec_code, sec_num)

def parse_credits(line):
  """
             3.000 credits
  """
  if line:
    return float(line[:-8])
  else:
    return None

def parse_registration(line):
  """
  jun 28, 2010 to jan 21, 2011
  """

  return map(
    lambda x: datetime.strptime(x, "%b %d, %Y") \
    if x else None,
             line.split(" to "))

def parse_semester(line):
  """
  uoit winter 2011
  """
  return (line, line[-4:])

def store_section(section_js):

  sql = Session()
  (code, title, sec_code, sec_num) = parse_title(section_js['title'])
  course = Course()
  course.code = code
  course.title = title

  sec = Section()
  sec.actual = int(section_js['actual'])
  sec.campus = section_js['campus']
  sec.capacity = int(section_js['capacity'])
  sec.credits = parse_credits(section_js.get('credits'))
  sec.levels = section_js['levels']
  sec.registration_start, sec.registration_end = parse_registration(
    section_js['registration'])
  sec.semester, sec.year = parse_semester(section_js['semester'])
  sec.course = course.code

  if sql.query(Course).filter(Course.code == course.code).count() == 0:
    sql.add(course)
  sql.add(sec)

  sql.commit()
  
def load(lines):
  for (i, line) in enumerate(lines):
    print "line: %d, index: %d" % (i+1, i)
    sec_js = json.loads(line)
    store_section(sec_js)

if __name__ == '__main__':
  lines = sys.stdin.xreadlines()
  load(lines)
