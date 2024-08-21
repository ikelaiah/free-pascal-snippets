program TStringListNewTextFile;

{$mode objfpc}{$H+}{$J-}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes;

var
  textFileName: string = 'hello-text.txt';
  stringList: TStringList;

begin

  // Create TStringList object
  stringList := TStringList.Create;
  try
    // Add lines
    stringList.Add('Hello Line 1!');
    stringList.Add('Hello Line 2!');

    // Save to a file
    stringList.SaveToFile(textFileName);
  finally
    // Free object
    stringList.Free;
  end;

  // Pause Console
  WriteLn('Press Enter key to exit ...');
  ReadLn;

end.
