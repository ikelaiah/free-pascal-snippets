program BasicReadTextFile;

{$mode objfpc}{$H+}{$J-}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes, SysUtils;

var
  filename: string;                // File to read
  textFile: System.TextFile;       // File handle
  buffer: array[0..65535] of byte; // Buffer for file operation
  line: string;                    // Stores each line read

begin
  filename:='input-file.txt';      // File to read

  AssignFile(textFile, filename);  // Associate file with handle
  try
    Reset(textFile);               // Open file for reading
    SetTextBuf (textFile,buffer);  // Assign a buffer for reading

    while not EOF(textFile) do     // Read until end of file
    begin
      ReadLn(textFile, line);      // Read a line
      WriteLn(line);               // Print the line
    end;

    CloseFile(textFile);           // Close the file
  except
    on E: Exception do
      WriteLn('File error: ', E.Message);
  end;

end.
