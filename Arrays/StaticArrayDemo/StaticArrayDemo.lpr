program StaticArrayDemo01;

{$mode objfpc}{$H+}{$J-}

uses
  {$IFDEF UNIX}
  cmem, cthreads,
  {$ENDIF}
  Classes;

type
  // Declaring a static array in the type-section.
  TByteArray = array [1..5] of byte; // size is 5

var
  // Creating an array var based on a type.
  // You can assign initial values here too.
  studentGrades: TByteArray;

  // Declaring an array type in the var section.
  multipleTen: array [0..9] of integer; // size is 10

  // Declaring static array and init values in the var-section.
  osChoices: array [1..3] of string = ('Linux', 'MacOS', 'Windows');

  index: integer; // a var for loops

begin
  // Assign a value to an array's element by using a valid index value
  // enclosed in square brackets.
  // Populate student grades
  studentGrades[1] := 95;
  studentGrades[2] := 85;
  studentGrades[3] := 75;
  studentGrades[4] := 55;
  studentGrades[5] := 85;

  // Populate multiple ten
  for index := low(multipleTen) to high(multipleTen) do
    multipleTen[index] := index * 10;

  // Print the length of the arrays
  WriteLn('The length of grades array     : ', Length(studentGrades));
  WriteLn('The length of osChoices array  : ', Length(osChoices));
  WriteLn('The length of multipleTen array: ', Length(multipleTen));

  WriteLn('-------------------');

  // Print an element from each array
  WriteLn('Grade of student 3 in the array : ', studentGrades[3]);
  WriteLn('First choice of OS the array    : ', osChoices[1]);
  WriteLn('The Last multiple of 10 in array: ', high(multipleTen));

  WriteLn('-------------------');

  // Print all elements from each array
  WriteLn('-- Student grades array');
  for index := low(studentGrades) to high(studentGrades) do
    WriteLn('Student ', index, ' scored ', studentGrades[index]);

  WriteLn('-- Multiple of ten array');
  for index := low(multipleTen) to high(multipleTen) do
    WriteLn('Index  ', index, ' contains ', multipleTen[index]);

  WriteLn('-- OS choices array');
  for index := low(osChoices) to high(osChoices) do
    WriteLn('OS choice no ', index, ' is ', osChoices[index]);

  // Pause console
  WriteLn('-------------------');
  WriteLn('Press enter to quit');
  ReadLn;
end.
