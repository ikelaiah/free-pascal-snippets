program ClassicCountLine;

{$mode objfpc}{$H+}{$J-}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes,
  SysUtils;

const
  BUFFER_SIZE = 131072;

var
  filename: string;
  textFile: System.TextFile;
  buffer: array [0..BUFFER_SIZE - 1] of char;
  line: string;
  total: int64;

begin
  // Get filename
  filename := ParamStr(1);

  // Do we have a valid input file?
  if not FileExists(filename) then
  begin
    WriteLn('Please specify a valid input file.');
    Exit;
  end;

  // Reset total
  total := 0;

  // Assign filename to a TextFile variable - set the name of the file for reading
  AssignFile(textFile, filename);
  SetTextBuf(textFile, buffer);

  // Perform the read operation in a try..except block to handle errors gracefully
  try
    // Open the file for reading
    Reset(textFile);

    // Keep reading lines until the end of the file is reached
    while not EOF(textFile) do
    begin
      ReadLn(textFile, line);
      total := total + 1;
    end;

    // Close the file
    CloseFile(textFile);

    // User feedback
    WriteLn('Total number of lines: ', IntToStr(total));

  except
    on E: Exception do
      WriteLn('File handling error occurred. Details: ', E.Message);
  end;
end.
