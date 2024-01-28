program LGIntegerListSort;

{$mode objfpc}{$H+}

uses
  Classes,
  lgVector,
  lgUtils;

type
   TIntCmpRel = class
      class function Less(L, R: Integer): Boolean; static;
    end;
  TIntVector = specialize TGVector<integer>;
  TIntOrdHelper = specialize TGOrdVectorHelper<integer>;
  TIntVecHelper = specialize TGVectorHelper<integer>;

var
  myInteger: TIntVector;
  i: integer;

begin
  // Creating a new instance of TGVector<integer>
  myInteger := TIntVector.Create([11, 33, 22, 55, 44, 66]);
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
    // TIntOrdHelper.Sort(myInteger, TSortOrder.soDesc);
    TIntVecHelper.Sort(myInteger, TSortOrder.soDesc);

    // Printing sorted list
    WriteLn('--sorted desc');
    for i := 0 to myInteger.Count - 1 do
    begin
      WriteLn(myInteger[i]);
    end;

    // Sorting ascending using .RadixSort()
    TIntOrdHelper.RadixSort(myInteger, TSortOrder.soAsc);

    // Printing sorted list
    WriteLn('--sorted asc');
    for i := 0 to myInteger.Count - 1 do
    begin
      WriteLn(myInteger[i]);
    end;

  finally
    myInteger.Free;
  end;

  ReadLn;
end.
