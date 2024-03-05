program ClassicReadTextFile;

{$mode objfpc}{$H+}{$J-}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes,
  SysUtils;

var
  filename: string = 'cake-ipsum.txt';
  textFile: System.TextFile;
  line: string;

begin

  // Provide user feedback
  writeln(Format('Reading ''%s''', [filename]));
  writeln('--------------------');

  // Assign filename to a TextFile variable - set the name of the file for reading
  AssignFile(textFile, filename);

  // Perform the read operation in a try..except block to handle errors gracefully
  try
    // Open the file for reading
    Reset(textFile);

    // Keep reading lines until the end of the file is reached
    while not EOF(textFile) do
    begin
      ReadLn(textFile, line);
      WriteLn(line);
    end;

    // Close the file
    CloseFile(textFile);

  except
    on E: Exception do
      writeln('File handling error occurred. Details: ', E.Message);
  end;

  // Pause console
  writeln('--------------------');
  writeln('Press Enter to quit.');
  readln;
end.
