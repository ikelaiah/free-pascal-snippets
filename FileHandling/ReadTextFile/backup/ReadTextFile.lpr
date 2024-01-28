program ReadTextFile;

uses
  Classes, SysUtils, streamex;

// Procedure to read a text file
procedure ReadTextFile(const filename: string);
var
  fileStream: TFileStream;
  inputReader: TStreamReader;
  line: string;
begin
  try
    fileStream := TFileStream.Create(filename, fmOpenRead);
    try
      inputReader := TStreamReader.Create(fileStream);
      try
        while not inputReader.EOF do
        begin
          line := inputReader.ReadLine;
          WriteLn(line);
        end;
      finally
        inputReader.Free;
      end;
    finally
      fileStream.Free;
    end;
  except
    on E: Exception do
      writeln('Error: ' + E.Message);
  end;
end;

begin

  // Read a file and print to std out
  ReadTextFile('cupcake-ipsum.txt');

  // Pause console
  ReadLn;
end.
