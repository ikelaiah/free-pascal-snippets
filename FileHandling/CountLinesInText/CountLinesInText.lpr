program CountLinesInText;

{$mode objfpc}{$H+}{$J-}

uses
  {$IFDEF UNIX}
  cmem, cthreads,
  {$ENDIF}
  Classes, SysUtils;

  function CountLinesInCSV(const FileName: string): qword;
  var
    TextFile: System.TextFile;
    Line: string;
  begin
    AssignFile(TextFile, FileName);
    Reset(TextFile);
    Result := 0;
    while not EOF(TextFile) do
    begin
      ReadLn(TextFile, Line);
      Inc(Result);
    end;
    CloseFile(TextFile);
  end;

var
  FileName: string;
  NumLines: int64;
begin
  // Provide the CSV file path
  FileName := 'data_measurements.txt';

  // Count the number of lines in the CSV file
  NumLines := CountLinesInCSV(FileName);

  // Output the result
  Writeln('Number of lines in ', ExtractFileName(FileName), ': ', NumLines);

  // Pause
  WriteLn('Press Enter to quit.');
  ReadLn;

end.
