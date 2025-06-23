program SimpleProgram;

{$mode objfpc}{$H+}{$J-}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes,
  SysUtils;

const
  student_id_prefix: string = 'ua-';

type
  TStudent = record
    studentId: string;
    firstname: string;
    lastname: string;
  end;

  // Prints the contents of a TStudent var
  procedure PrintStudentInfo(student: TStudent);
  begin
    WriteLn(student.studentId);
    WriteLn(student.firstname, ' ', student.lastname);
  end;

var
  myStudent: TStudent;

begin
  // The Main block/entry of the program

  WriteLn('Now : ', DateToStr(Now));

  myStudent.firstname := 'John';
  myStudent.lastname := 'Costco';
  myStudent.studentId := student_id_prefix + '2227209';
  PrintStudentInfo(myStudent);

  // Pause console
  WriteLn('Press Enter key to quit ...');
  ReadLn();
end.
