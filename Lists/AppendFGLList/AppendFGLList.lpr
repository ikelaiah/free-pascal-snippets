program AppendFGLList;

{$mode objfpc}{$H+}

uses
  fgl,
  Math;

type
  TIntegerList = specialize TFPGList<integer>;

var
  myIntList1, myIntList2: TIntegerList;
  i: integer;

begin
  myIntList1 := TIntegerList.Create;
  myIntList2 := TIntegerList.Create;

  // Adding integers to the lists
  myIntList1.Add(1);
  myIntList1.Add(2);
  myIntList2.Add(3);
  myIntList2.Add(4);

  myIntList1.AddList(myIntList2);

  // Printing the first list
  WriteLn('The content of myIntList1 is now:');
  for i := 0 to myIntList1.Count - 1 do
  begin
    WriteLn(myIntList1[i]);
  end;

  // Freeing the lists when done
  myIntList2.Free;
  myIntList1.Free;

  ReadLn;
end.
