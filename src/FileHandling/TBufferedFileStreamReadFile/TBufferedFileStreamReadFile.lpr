program TBufferedFileStreamReadFile;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cmem, cthreads,
  {$ENDIF}
  Classes,
  SysUtils,
  streamex,
  bufstream;

var
  fStream: TBufferedFileStream;
  sReader: TStreamReader;
  line: string;
  Count: int64 = 0;

begin

  if Length(ParamStr(1)) < 1 then
  begin
    WriteLn('Please provide a valid input file.');
    Exit;
  end;

  try
    // Create TBufferedFileStream object
    fStream := TBufferedFileStream.Create(ParamStr(1), fmOpenRead);
    try
      sReader := TStreamReader.Create(fStream);
      try
        // Keep on reading until there is no more data to read
        Count := 0;
        while not sReader.EOF do
        begin
          line := sReader.ReadLine;
          Inc(Count);
          WriteLn('Line ', IntToStr(Count), ' : ', line);
        end;
      finally
        sReader.Free;
      end;
    finally
      fStream.Free;
    end;
  except
    on E: Exception do
      WriteLn('Error: ' + E.Message);
  end;
end.
