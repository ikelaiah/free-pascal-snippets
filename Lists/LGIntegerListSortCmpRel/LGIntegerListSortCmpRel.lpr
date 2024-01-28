program LGIntegerListSortCmpRel;

{$mode objfpc}{$H+}

uses
  Classes,
  lgVector,
  lgUtils;

type
  TIntCmpRel = class
    class function Less(const L, R: integer): boolean; static;
  end;

  class function TIntCmpRel.Less(const L, R: integer): boolean;
  begin
    Result := L < R;
  end;

type
  TIntList = specialize TGVector<integer>;
  TIntHelper = specialize TGComparableVectorHelper<integer>;

var
  myInteger: TIntList;
  i: integer;

begin
  // Creating a new instance of TGVector<integer>
  myInteger := TIntVector.Create;
  try
    // Adding numbers
    myInteger.Add(1);
    myInteger.Add(10);
    myInteger.Add(100);

    // Printing list
    WriteLn('--original');
    for i := 0 to myInteger.Count - 1 do
    begin
      WriteLn(myInteger[i]);
    end;

    // Sorting descending using .Sort()
    TIntHelper.Sort(myInteger, TSortOrder.soDesc);

    // Printing sorted list
    WriteLn('--sorted');
    for i := 0 to myInteger.Count - 1 do
    begin
      WriteLn(myInteger[i]);
    end;


  finally
    //myInteger.Free;
  end;

  ReadLn;
end.
