program SimpleWriteTextFile;

{$mode objfpc}{$H+}{$J-}

uses
  Classes,
  SysUtils;

var
  Text: string;
  filename: string;
  fileStream: TFileStream;
  size: longint;

  { Main Block }
begin

  try
    // String to be written
    Text := 'Hello Text!' + LineEnding + 'I''ll be written in a file!';

    // Text file to write the text to
    filename := 'hello-text.txt';

    // Create a TFileStream
    fileStream := TFileStream.Create(filename, fmCreate);
    try
      // Set writing position at the beginning of file
      fileStream.Position := 0;
      // Write text into the file and return written bytes
      size := fileStream.Write(Text[1], Length(Text));
      // Optional - Show confirmation
      Writeln(Format('Created %s. %d bytes written.', [filename, size]));
    finally
      // Free TFileStream object
      fileStream.Free;
    end;
  except
    on E: Exception do
      Writeln('An error occurred: ', E.Message);
  end;
end.
