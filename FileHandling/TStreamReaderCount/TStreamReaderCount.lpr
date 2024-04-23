program TStreamReaderCount;

{$mode objfpc}{$H+}{$J-}

uses
  {$IFDEF UNIX}
  cmem, cthreads,
  {$ENDIF}
  Classes,
  SysUtils,
  streamex;

var
  filename: string;
  fStream: TFileStream;
  fReader: TStreamReader;
  total: int64;
  line: string;

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

  // try - except block start
  try
    fStream := TFileStream.Create(filename, fmOpenRead or fmShareDenyWrite);
    try
      fReader := TStreamReader.Create(fStream, 131072, False);
      try
        while not fReader.EOF do
        begin
          // Read line
          line := fReader.ReadLine;
          // Process line here if needed
          // ....
          // Increase counter
          total := total + 1;
        end;
      finally
        fReader.Free;
      end;
    finally
      fStream.Free;
    end;

    // User feedback
    WriteLn('Total line is: ', IntToStr(total));

  except
    on E: Exception do
      WriteLn('Error: ' + E.Message);
  end; // try - except block ends
end.
