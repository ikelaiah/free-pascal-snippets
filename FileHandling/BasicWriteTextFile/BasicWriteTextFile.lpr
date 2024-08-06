program BasicWriteTextFile;

{$mode objfpc}{$H+}{$J-}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes,
  SysUtils;

var
  filename: string;                // File to create
  textFile: System.TextFile;       // File handle
  buffer: array[0..65535] of byte; // Buffer for file operation

begin
  filename := 'new-file.txt';      // File to create

  AssignFile(textFile, filename);  // Associate file with handle
  try
    Rewrite(textFile);             // Create a file for writing
    SetTextBuf(textFile, buffer);  // Assign a buffer for writing

    WriteLn(textFile, 'Hello 1!'); // Write a line
    WriteLn(textFile, 'Hello 2!'); // Write another line

    CloseFile(textFile);           // Close the file
  except
    on E: Exception do
      WriteLn('File error: ', E.Message);
  end;

end.
