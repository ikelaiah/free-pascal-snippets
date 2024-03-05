program TStringListBlankFile;

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

