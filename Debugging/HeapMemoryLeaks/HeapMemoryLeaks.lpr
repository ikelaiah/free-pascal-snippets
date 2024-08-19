program HeapMemoryLeaks;

{$mode objfpc}{$H+}{$J-}

// Define a symbol name DEBUG.
// With this compiler directives we can compile parts of code associated with this symbol.
{$DEFINE DEBUG}

uses
  {$IFDEF UNIX}
  cmem, cthreads,
  {$ENDIF}
  Classes,
  SysUtils;

var
  stringList: TStringList;
  i: integer;

  // MAIN block
begin

  {$IFDEF DEBUG}
  // This block assumes your build mode sets -dDEBUG in `Project Options` or other means when defining -gh.
  // For production build, remove -dDEBUG in `Project Options` or other means and disable -gh.

  // Setup Heaptrc output for the Leak and Traces window in Lazarus.
  if FileExists('heap.trc') then
    DeleteFile('heap.trc');
  SetHeapTraceOutput('heap.trc');
  {$ENDIF DEBUG}

  // Create a string list
  stringList := TStringList.Create;

  try
    // Adding items
    WriteLn('Adding items');
    WriteLn('--------------------');
    for i := 0 to 3 do
      stringList.Add('Counting ' + IntToStr(i));

    // Printing contents
    for i:=0 to stringList.Count - 1 do
      WriteLn(stringList[i]);

  finally
    // If you don't free, the -gh will give report of memory leaks
    // If Leak and Traces window is set to a heap trace file, this will appear in the Leak and Traces windoww.
    // Otherwise, Heaptrc will print heap memory reports on CLI.
    // stringList.Free;
  end;
end.
