program TBufferedFileStreamCount;

{$mode objfpc}{$H+}{$J-}

uses
  {$IFDEF UNIX}
  cmem, cthreads,
  {$ENDIF}
  Classes,
  SysUtils,
  streamex;

const
  BufferSize = 131072; // Adjust buffer size as needed

var
  filename: string;
  fStream: TFileStream;
  total: int64;
  buffer: array[0..BufferSize - 1] of char;
  bytesRead: integer;
  i: integer;

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
      repeat
        bytesRead := fStream.Read(buffer[0], BufferSize);
        i := 0;
        while i < bytesRead do
        begin
          // Count lines in the buffer
          if buffer[i] = #10 then
            total := total + 1;
          Inc(i);
        end;
      until bytesRead = 0;
    finally
      fStream.Free;
    end;

    // User feedback
    WriteLn('Total lines:', IntToStr(total));

  except
    on E: Exception do
      WriteLn('Error: ' + E.Message);
  end; // try - except block ends
end.
