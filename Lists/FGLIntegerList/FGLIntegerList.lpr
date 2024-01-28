program FGLIntegerList;

{$mode objfpc}{$H+}

uses
  fgl,
  Math;

type
  TIntegerList = specialize TFPGList<integer>;

  // Comparer function for sorting list
  function CompareInt(const left, right: integer): integer;
  begin
    Result := CompareValue(left, right);
  end;

var
  myIntList: TIntegerList;
  i: integer;

begin
  myIntList := TIntegerList.Create;
  try
    // Adding integers to the list
    myIntList.Add(444);
    myIntList.Add(222);
    myIntList.Add(333);

    // Printing list
    Writeln('-- Original list ----------');
    for i := 0 to myIntList.Count - 1 do WriteLn(myIntList[i]);

    // Sorting
    myIntList.Sort(@CompareInt);

    // Printing list
    Writeln('-- Sorted list ------------');
    for i := 0 to myIntList.Count - 1 do WriteLn(myIntList[i]);

  finally
    // Freeing the list when done
    myIntList.Free;
  end;

  // Pause console
  ReadLn;
end.
