program ForInLoop;

{$mode objfpc}{$H+}{$J-}

uses
  SysUtils;

var
  numbers: array of integer;
  num: integer;

  { Main Block }
begin
  // Initialize the array
  numbers := [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  // Use the for..in loop to iterate over the array
  for num in numbers do
  begin
    WriteLn('Number: ', num);
  end;

  // Pause console
  WriteLn('Press enter key to quit');
  ReadLn;
end.
