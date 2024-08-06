program DynArrayConcat;

{$mode objfpc}{$H+}{$J-}
{$modeswitch arrayoperators}

uses
  SysUtils;

type
  TIntArray = array of integer;

  procedure PrintArray(arr: TIntArray);
  var
    i: integer;
  begin
    for i := Low(arr) to High(arr) do
      Write(arr[i], ' ');
    WriteLn;
  end;

var
  arr1, arr2, resultArr: TIntArray;

  { Main block }
begin
  // Initialize the first array
  arr1 := [1, 2, 3, 4, 5];

  // Initialize the second array
  arr2 := [6, 7, 8, 9, 10];

  // Concatenate the arrays using the + operator
  resultArr := arr1 + arr2;

  // Print the arrays
  WriteLn('Array 1:');
  PrintArray(arr1);
  WriteLn('Array 2:');
  PrintArray(arr2);
  WriteLn('Concatenated Array:');
  PrintArray(resultArr);

  // Pause console
  ReadLn;
end.
