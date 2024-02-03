program LGIntegerList;

{$mode objfpc}{$H+}{$J-}

uses
  Classes,
  lgVector;

type
  TIntVector = specialize TGVector<integer>;

var
  myInteger: TIntVector;
  i: integer;

begin
  // Creating a new instance
  myInteger := TIntVector.Create([11, 33, 22, 55, 44, 66]);
  try
    // Adding numbers
    myInteger.Add(1);
    myInteger.Add(10);
    myInteger.Add(100);

    // Printing list
    for i := 0 to myInteger.Count - 1 do
    begin
      WriteLn(myInteger[i]);
    end;

  finally
    // Releasing resource
    myInteger.Free;
  end;

  ReadLn;
end.
