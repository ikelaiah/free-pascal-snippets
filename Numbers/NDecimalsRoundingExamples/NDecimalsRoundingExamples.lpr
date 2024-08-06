program NDecimalRoundingExample;

{$mode objfpc}{$H+}{$J-}

uses
  Math;

var
  num: real;
  rounded: real;
  n: integer;

  { Main Block }
begin
  num := 12345.678875;
  n := 4;  // Number of decimal places you want

  rounded := RoundTo(num, -n);

  WriteLn('Rounded Number: ', rounded: 0: 4);  // Format to 4 decimal places

  // Pause console
  WriteLn('Press enter key to exit');
  ReadLn;
end.
