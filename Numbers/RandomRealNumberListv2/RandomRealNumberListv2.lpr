program RandomRealNumberListv2;

{$mode objfpc}{$H+}{$J-}

uses
  Math;

function RandomNumberBetween(const min, max: real): real;
begin
  Result := Random * (max - min) + min;
end;

const
  noSample: integer = 250;

var
  i: integer;
  realList: array of real;

begin
  // Randomize initializes the random number generator by assigning a value
  // to Randseed, which is computed based on the system clock.
  Randomize;

  // Set size of the dynamic array
  SetLength(realList, noSample);

  // Populating the list with random real numbers
  WriteLn('-- Populating the list --------------------------------');
  for i := low(realList) to high(realList) do
  begin
    realList[i] := RandomNumberBetween(1, 100);
  end;

  // Displaying the content of the list
  WriteLn('-- Content of list, showing up to 4 decimals ----------');
  for i := 0 to high(realList) do
  begin
    Write(realList[i]: 0: 4, ' ');
  end;

  WriteLn;

  // Displaying the mean
  WriteLn('-- The mean, up to 4 decimals, is ---------------------');
  WriteLn(Math.Mean(realList): 0: 4);

  ReadLn;
end.
