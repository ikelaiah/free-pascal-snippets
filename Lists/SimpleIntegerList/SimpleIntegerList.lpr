program SimpleIntegerList;

{$mode objfpc}{$H+}{$J-}

uses
  Math,
  Generics.Defaults,
  Generics.Collections;

type
  TIntegerList = specialize TList<integer>;

var
  myIntList: TIntegerList;
  i: integer;

begin
  // Create a new generic list
  myIntList := TIntegerList.Create;
  try
    // Add some elements to the list, use Add or AddRange (append)
    myIntList.Add(0);
    myIntList.Add(1);
    myIntList.AddRange([9, 8, 7, 6, 5]);

    // Access the n-th element, 0-indexed
    WriteLn('The 3rd item is: ', myIntList[2]);

    // Sorting it ascending
    myIntList.Sort;

    // Iterate through the list
    for i := 0 to myIntList.Count - 1 do
      Writeln(myIntList[i]);

    // Get the mean
    WriteLn('The mean is: ', Math.Mean(myIntList.ToArray): 0: 2);

    // Empty the list
    myIntList.Clear;

  finally
    // Free the memory used by the list
    myIntList.Free;
  end;

  // Pause console
  ReadLn;
end.
