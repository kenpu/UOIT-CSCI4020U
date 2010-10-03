lexer grammar MycampusLexer;
options {
filter=true;
}

@header {
package myc;
}

@members {
boolean startField = false;
boolean startBold = false;
boolean startInstruct = false;
boolean startAvail = false;
boolean startSchedule = false;
boolean startComments = false;
}

START_TITLE
	: '<th class="ddheader"' (~'>')+ '>' {startField = true;}
	;
	
UOD
  : '<font color="#ff0000">uod</font>'
  ;
  
TEXT
  : {startField|startBold|startInstruct}?=> (~'<')+ {
      String text = $text.replaceAll("\\r|\\n", "");
      if (startField | startBold) 
        text = text.replaceAll("&amp;", "&");
        
      if(startInstruct | startSchedule)
        // This is to strip away the (<abbr title="primary">p</abbr>)
        // for instructor names
        text = text.replaceAll("\\(|\\)", "");
      state.text = text;
    }
  ;
  
END_BR
  : {startField}?=> '<br>' {startField=false;}
  ;

START_TERM
  : '<span class=fieldlabeltext>associated term: </span>' {
    startField = true;
    }
  ;

START_REGISTRATION
  : '<span class=fieldlabeltext>registration dates: </span>' {
    startField = true;
    }
  ;

START_LEVELS
  : '<span class=fieldlabeltext>levels: </span>' {
    startField = true;
  };

START_INSTRUCTORS
  : '<span class=fieldlabeltext>instructors: </span>' {
    startInstruct = true;
  };
  
END_INSTRUCTORS
  : {startInstruct}?=> '<br>' {startInstruct = false;}
  ;

TBA
  : '<abbr title = "to be announced">tba</abbr>'
  ;

START_INSTRUCTOR_TITLE
  : '<abbr' (~'>')* '>'
  ;

END_INSTRUCTOR_TITLE
  : '</abbr>'
  ;

START_BOLD
  : '<b>' {startBold = true;}
  ;
END_BOLD
  : {startBold}?=>'</b>' {startBold = false;}
  ;

START_LECTURE_SCHEDULE_TYPE
  : 'lecture schedule type' NEWLINE '<br>' {
    startField = true;
  };
  
START_AVAILABILITY
  : '<td class="dblabel" scope="row" ><span class=fieldlabeltext>seats</span></td>' {
    startAvail = true;
  }
  ;
START_AVAILABILITY_VALUE
  : {startAvail}?=> '<td class="dbdefault">' {startField = true;}
  ;
  
END_AVAILABILITY_VALUE
  : {startAvail && startField}?=> '</td>' {startField = false;}
  ;
  
END_AVAILABILITY
  : {startAvail}?=> '</table>' {startAvail = false;}
  ;

START_SCHEDULE
  : {!startSchedule}?=> '<td class="dbdefault">&nbsp;' {
    startSchedule = true;
  };

START_SCHEDULE_VALUE
  : {startSchedule}?=> '<td class="dbdefault">' {
    startField = true;
  };
  
END_SCHEDULE_VALUE
  : {startSchedule && startField}?=> '</td>' {startField = false;}
  ;

END_SCHEDULE
  : {startSchedule}?=> '</tr>' {startSchedule = false;}
  ;

START_COMMENTS
  : '<p class="leftaligntext">' {startField = true;}
  ;
END_COMMENTS
  : {startField}?=> '</td>' {startField = false;}
  ;
fragment NEWLINE : '\n' | '\r\n';
