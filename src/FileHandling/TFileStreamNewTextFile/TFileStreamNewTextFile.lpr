program TFileStreamNewTextFile;

uses
  Classes, SysUtils;

var
  text: string = 'QILT Surveys';
  filename :String = 'hello-text.txt';
  fileStream: TFileStream;
  size: longint;

begin
  // Create a TFileStream object
  fileStream := TFileStream.Create(filename, fmCreate);
  try
    // set position at the beginning of file
    fileStream.Position := 0;
    // Write text into the file
    size := fileStream.Write(text[1], Length(text));
    // Show confirmation
    Writeln(Format('Created %s. %d bytes written.', [filename, size]));
  finally
    // Free TFileStream object
    fileStream.Free;
  end;

  // Pause console
  ReadLn;
end.
