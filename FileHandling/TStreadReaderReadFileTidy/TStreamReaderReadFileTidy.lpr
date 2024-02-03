program TStreamReaderReadFileTidy;

{$mode objfpc}{$H+}{$J-}

uses
  Classes,
  SysUtils,
  streamex;

  // Read a stream of string line by line
  procedure ReadTextFile(const fileStream: TStream);
  var
    reader: TStreamReader;
    i: integer;
    line: string;
  begin
    reader := TStreamReader.Create(fileStream);
    try
      // Set line counter to 1
      i := 1;
      while not reader.EOF do
      begin
        line := reader.ReadLine;
        WriteLn(Format('line %d: %s', [i, line]));
        i := i + 1;
      end;
    finally
      reader.Free;
    end;
  end;

  // Open a file for reading, and pass the stream to TStreamReader for reading.
  procedure ReadTextFile(const filename: string);
  var
    fileStream: TFileStream;
  begin
    fileStream := TFileStream.Create(filename, fmOpenRead);
    try
      ReadTextFile(fileStream);
    finally
      fileStream.Free;
    end;
  end;

var
  filename: string;

begin
  // filename to read
  filename := 'cake-ipsum.txt';
  try
    ReadTextFile(filename);
  except
    on E: Exception do
      WriteLn('Error: ' + E.Message);
  end;

  // Pause console
  ReadLn;
end.
