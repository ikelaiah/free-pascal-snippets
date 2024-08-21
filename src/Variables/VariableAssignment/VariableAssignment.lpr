program VariableAssignment;

  {$mode objfpc}{$H+}{$J-}

var
  studentName: string;
  studentAge: byte; // byte's range is 0..255. Suitable for storing a person's age.
  studentID: string;
  studentGroup: char;

begin
  { Assign a string to studentName variable}
  studentName := 'Jean Valjean';

  { Assign a number to studentAge variable}
  studentAge := 24;

  { Assign a string to studentID variable}
  studentID := 'j-24601';

  { Assign a char to studentGroup variable}
  studentGroup := 'A';

  { Display values to console }
  WriteLn('Student Name : ', studentName);
  WriteLn('Student Age  : ', studentAge);
  WriteLn('Student ID   : ', studentID);
  WriteLn('Student Group: ', studentGroup);

  { Pause console }
  ReadLn;
end.
