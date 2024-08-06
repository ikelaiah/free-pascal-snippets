program SimpleReadTextFile;

{$mode objfpc}{$H+}{$J-}

uses
  SysUtils,
  Classes,
  streamex;

var
  fileStream: TFileStream;
  streamReader: TStreamReader;
  line: string;

  { Main Block }
begin
  try
    // Open the file
    fileStream := TFileStream.Create('mock-data.csv', fmOpenRead);
    try
      streamReader := TStreamReader.Create(fileStream, 65536, False);
      try
        // Read the file line by line
        while not streamReader.Eof do
        begin
          line := streamReader.ReadLine;
          // Process the line (for now, we just print it)
          Writeln(line);
        end;
      finally
        // Clean up
        streamReader.Free;
      end;
    finally
      // Clean up
      fileStream.Free;
    end;
  except
    on E: Exception do
      Writeln('An error occurred: ', E.Message);
  end;
end.
