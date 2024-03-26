program TFileStreamCount;

{$mode objfpc}{$H+}{$J-}

uses
  {$IFDEF UNIX}
  cmem, cthreads,
  {$ENDIF}
  Classes,
  SysUtils,
  streamex;

var
  fStream: TFileStream;
  fReader: TStreamReader;
  total: int64;
  line: string;

begin
  // Do we have a valid input file?
  if Length(ParamStr(1)) < 3 then
  begin
    WriteLn('Please specify a valid input file.');
    Exit;
  end;

  // Reset total
  total := 0;

  // try - except block start
  try
    fStream := TFileStream.Create(ParamStr(1), fmOpenRead or fmShareDenyWrite);
    try
      fReader := TStreamReader.Create(fStream);
      try
        while not fReader.EOF do
        begin
          // Read line
          line := fReader.ReadLine;
          // Process line here if needed
          // ....
          // Increase counter
          Inc(total);
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
