program RandomNumberSimple;

{$mode objfpc}{$H+}{$J-}

uses
  Math;

var
  i: integer;

begin

  // Init the random number generator.
  Randomize;

  // Generate a random number betwen 0 to 100
  i := Random(101);
  WriteLn(i);

  // Pause console
  ReadLn;
end.
