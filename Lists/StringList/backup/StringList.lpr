program StringList;

{$mode objfpc}{$H+}

uses
  Classes;

var
  myStringList: TStringList;
  stringIndex: integer;
  i: integer;

begin

  // Allocate a memory for this list
  myStringList := TStringList.Create;
  try
    // Add items into the list
    myStringList.Add('cc');
    myStringList.Add('aa');
    myStringList.Add('bb');

    // Insert at index-n
    myStringList.Insert(0, 'zero');

    // Remove item at index - n
    myStringList.Delete(0);

    // Append an array of string
    myStringList.AddStrings(['yy', 'zz - last one']);

    // Sort list
    myStringList.Sort;

    // Find an exact match string, case insensitive, un-sorted
    // A sorted TStringlist has myStringList.Sorted:=True;
    stringIndex := myStringList.IndexOf('yy');
    if stringIndex >= 0 then
    begin
      WriteLn('Found yy at index: ', stringIndex);
    end;

    // Iteration for partial string mathching
    for i := 0 to myStringList.Count - 1 do
    begin
      if Pos('last one', myStringList[i]) > 0 then
      begin
        // String found at index "i"
        WriteLn('Found ''last one'' at index: ', i);
        Break; // Exit the loop if a match is found
      end;
    end;

    // Iterate through the list
    for i := 0 to myStringList.Count - 1 do
      Writeln(myStringList[i]);

    // Clear the list, size of the list will be 0
    myStringList.Clear;

  finally
    // Free the memory
    myStringList.Free;
  end;

  // Pause Console
  Readln;

end.
