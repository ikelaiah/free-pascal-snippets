program RandomRealNumbers;

{$mode objfpc}{$H+}{$J-}

uses
  Math, lgVector;

function RandomBetween(a, b: double): double;
begin
  Result := a + Random * (b - a);
end;

type
  // Create a list of real (double)
  TIntList = specialize TGVector<real>;

const
  noSample: integer = 200;

var
  i: integer;
  intList: TIntList;

begin

  //Init the random number generator, by giving a value to Randseed, calculated with the system clock.
  Randomize;

  // Init the TIntList
  intList := TIntList.Create;
  try

    // Populating the list with random values
    WriteLn('-- Populating the list --------------------------------');
    for i := 0 to noSample do
    begin
      intList.Add(RandomBetween(1, 100));
    end;

    // DIsplaying the content of the list
    WriteLn('-- Content of list, showing up to 4 decimals ----------');
    for i := 0 to intList.Count - 1 do
    begin
      Write(intList[i]: 0: 4, ' ');
    end;
    WriteLn;

    // Displaying the mean
    WriteLn('-- The mean, up to 4 decimals, is ---------------------');
    WriteLn(Math.Mean(intList.ToArray): 0: 4);

  finally
    // Free allocated resources for list
    intList.Free;
  end;

  ReadLn;
end.
