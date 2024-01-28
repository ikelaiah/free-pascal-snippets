program RandomRealNumberList;

{$mode objfpc}{$H+}{$J-}

uses
  Math, lgVector;

function RandomNumberBetween(const min, max: real): real;
begin
  Result := Random * (max - min) + min;
end;

type
  // Create a list of real (double)
  TRealList = specialize TGVector<real>;

const
  noSample: integer = 250;

var
  i: integer;
  realList: TRealList;

begin

  //
Certainly! Here's a rephrased version:

  // Randomize initializes the random number generator by assigning a value
  // to Randseed, which is computed based on the system clock.
  Randomize;

  // Init the real list
  realList := TRealList.Create;
  try

    // Populating the list with random real numbers
    WriteLn('-- Populating the list --------------------------------');
    for i := 0 to noSample do
    begin
      realList.Add(RandomNumberBetween(1, 100));
    end;

    // Displaying the content of the list
    WriteLn('-- Content of list, showing up to 4 decimals ----------');
    for i := 0 to realList.Count - 1 do
    begin
      Write(realList[i]: 0: 4, ' ');
    end;
    WriteLn;

    // Displaying the mean
    WriteLn('-- The mean, up to 4 decimals, is ---------------------');
    WriteLn(Math.Mean(realList.ToArray): 0: 4);

  finally
    // Free allocated resources for list
    realList.Free;
  end;

  ReadLn;
end.
