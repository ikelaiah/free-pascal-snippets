program RoundingExamples;

{$mode objfpc}{$H+}{$J-}

uses
  Math;  // Include the Math unit for Ceil and Floor

var
  num: Real;
  rounded: Integer;

  { Main Block }
begin
  num := 123.4567;

  // Using Round
  rounded := Round(num);  // Nearest integer, Banker's Rounding
  WriteLn('Rounded value (Round): ', rounded);

  // Using Ceil
  rounded := Ceil(num);   // Always rounds up
  WriteLn('Ceiling value (Ceil): ', rounded);

  // Using Floor
  rounded := Floor(num);  // Always rounds down
  WriteLn('Floor value (Floor): ', rounded);

  // Examples of Banker's Rounding
  num := 2.5;
  rounded := Round(num);  // Banker's Rounding
  WriteLn('Rounded value for 2.5 (Banker''s Rounding): ', rounded);

  num := 3.5;
  rounded := Round(num);  // Banker's Rounding
  WriteLn('Rounded value for 3.5 (Banker''s Rounding): ', rounded);

  // Pause console
  WriteLn('Press enter key to exit');
  ReadLn;
end.

