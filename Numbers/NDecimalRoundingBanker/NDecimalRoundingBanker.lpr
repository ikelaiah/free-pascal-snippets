program NDecimalRoundingBanker;

{$mode objfpc}{$H+}{$J-}

uses
  Math;

var
  originalValue: double;
  roundedValue: double;
  tempValue: double;

{ Main Block }
begin
  originalValue := 12345.678875;

  { 1. Simplest approach using RoundTo function }

  roundedValue := RoundTo(originalValue, -4);

  WriteLn('Original value        : ', originalValue: 0: 6);
  writeln('Bankers rounded value : ', roundedValue : 0: 4);

  { 2. Alternative approach using multiplication and division by 10000 }

  // First, multiply by 10000 to move the decimal point
  tempValue := originalValue * 10000;

  // Round to the nearest integer (banker's rounding happens here)
  tempValue := Round(tempValue);

  // Then divide by 10000 to move the decimal point back
  roundedValue := tempValue / 10000;

  WriteLn('Original value        : ', originalValue: 0: 6);
  writeln('Bankers rounded value : ', roundedValue : 0: 4);



  // Pause console
  WriteLn('Press enter key to exit');
  ReadLn;
end.

