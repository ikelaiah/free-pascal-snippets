program DynArrayDemo01;

{$mode objfpc}{$H+}{$J-}

uses
  {$IFDEF UNIX}
  cmem, cthreads,
  {$ENDIF}
  Classes,
  SysUtils;

type
  // Declaring a static array in the type-section.
  TRealArray = array of real;

var
  // Creating an array var based on a type.
  // You can assign initial values here too.
  dailyTemp: TRealArray;

  // Declaring an array type in the var section.
  multipleTwo: array of integer;

  // Declaring an array type in the var section.
  defenceForces: array of string = ('Navy', 'Army', 'Air Force');

  tempInt, index: integer;      // variables for loops.
  tempReal: real;               // variable for loops.
  tempStr: string;              // a string placeholder for loops.

begin

  // Setting length of dynamic arrays
  SetLength(dailyTemp, 7);   // This array's size is 7, index 0..6
  SetLength(multipleTwo, 5);  // This array's size is 5, index 0..4

  // Populate the daily temp array
  dailyTemp[0] := 30.1;
  dailyTemp[1] := 25.5;
  dailyTemp[2] := 28.7;
  dailyTemp[3] := 29.1;
  dailyTemp[4] := 28.8;
  dailyTemp[5] := 28.5;
  dailyTemp[6] := 27.2;

  // Populate the int array with multiples of two
  for index := low(multipleTwo) to high(multipleTwo) do
    multipleTwo[index] := index * 2;

  // Print the length of the arrays
  WriteLn('The length of dailyTemp array    : ', Length(dailyTemp));
  WriteLn('The length of multipleTwo array  : ', Length(multipleTwo));
  WriteLn('The length of defenceForces array: ', Length(defenceForces));

  WriteLn('-------------------');

  // Print an element from each array
  WriteLn('Last temp recorded in the array          : ', high(dailyTemp));
  WriteLn('Second number in multipleTwo array       : ', multipleTwo[1]);
  WriteLn('The third item in the defenceForces array: ', defenceForces[2]);

  WriteLn('-------------------');

  WriteLn('-- Printing the real array');

  // Print the real array
  for index := 0 to high(dailyTemp) do
  begin
    // Option 1
    // WriteLn('Temp day ', (index + 1), ' is ', dailyTemp[index]:0:2);
    // Option 2
    WriteLn(Format('The temp for day %d is %2f.', [index, dailyTemp[index]]));
  end;

  WriteLn('-- Printing the integer array');

  // Print the integer array
  for tempInt in multipleTwo do
    WriteLn(tempInt);

  WriteLn('-- Printing the string array');

  // Print the string array
  for tempStr in defenceForces do
    WriteLn(tempStr);

  // Pause console
  WriteLn('-------------------');
  WriteLn('Press enter to quit');
  ReadLn;
end.
