program TFileStreamAppendTextFile;

{$mode objfpc}{$H+}{$J-}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes,
  SysUtils;

var
  filename: string = 'hello-text.txt';
  fileStream: TFileStream;
  size: longint;
  newText: string;

begin

  // First, does the file exist?
  if FileExists(fileName) then
    // If yes, open the file in append mode.
    fileStream := TFileStream.Create(filename, fmOpenWrite or fmShareDenyNone)
  else
    // If not, create a a new file.
    fileStream := TFileStream.Create(filename, fmCreate);

  // Next, start appending.
  try
    // set position at the end of the file
    fileStream.Seek(0, soFromEnd);
    // Write text into the file
    newText := LineEnding + 'A new line!';
    size := fileStream.Write(newText[1], Length(newText));
    // Show confirmation
    Writeln(Format('Appended %s. %d bytes written.', [filename, size]));
  finally
    // Free TFileStream object
    fileStream.Free;
  end;

  // Pause console
  WriteLn('Press Enter to quit.');
  ReadLn;
end.
