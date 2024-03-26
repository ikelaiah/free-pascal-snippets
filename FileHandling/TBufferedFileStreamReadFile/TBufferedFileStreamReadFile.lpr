program TBufferedFileStreamReadFile;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cmem, cthreads,
  {$ENDIF}
  Classes,
  SysUtils,
  bufstream;

var
  fStream: TBufferedFileStream;
  line: string;
  ch: char;

begin

  if Length(ParamStr(1)) < 3 then
  begin
    WriteLn('Invalid input file');
    Exit;
  end;

  try

    // Create TBufferedFileStream object, read only
    fStream := TBufferedFileStream.Create(ParamStr(1), fmOpenRead);
    try
      // Keep on reading until there is no more data to read
      while fStream.Read(ch, 1) = 1 do
      begin
        if ch = #10 then
        begin
          // Display the line.
          WriteLn('Line: ', line);
          // After displaing, reset.
          line := '';
        end
        else
          // If not #10, combine the characters to make up a line.
          line := line + ch;
      end;
    finally
      fStream.Free;
    end;

  except
    on E: Exception do
      WriteLn('Error: ' + E.Message);
  end;

end.
