program TStringListAppend;

{$mode objfpc}{$H+}{$J-}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes,
  SysUtils;

var
  filename: string = 'hello-text.txt';
  text: TStringList;

begin

  // First of all, check if the input file exists.
  // It not, exit program early.
  if not FileExists(fileName) then
  begin
    WriteLn(Format('File %s does not exist. Press Enter to quit.', [filename]));
    ReadLn;
    Exit;
  end;

  // If file exists, create a TStringList object
  text := TStringList.Create;
  try
    // Read an existing file into TStringList object
    text.LoadFromFile(filename);

    // Append more text
    text.Add('New line!');
    text.Add('New line!');

    // Save the appended TStringList file
    text.SaveToFile(filename);
    WriteLn(Format('Saved to %s.', [filename]));

  finally
    // Free object
    text.Free;
  end;

  // Pause Console
  WriteLn('Press Enter to exit.');
  ReadLn;

end.
