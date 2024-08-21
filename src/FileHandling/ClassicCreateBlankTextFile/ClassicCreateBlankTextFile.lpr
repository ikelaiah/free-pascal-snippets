program ClassicCreateBlankTextFile;

uses
  Classes,
  SysUtils;

var
  filename: string = 'hello-text.txt';
  textFile: System.TextFile;

begin
  // Set the name of the file that will be created
  AssignFile(textFile, filename);

  // Enclose in try/except block to handle errors
  try
    // Open the file for writing (it will create it file doesn't exist)
    ReWrite(textFile);

    // Close file
    CloseFile(textFile);

    // Show a confirmation
    WriteLn('Created a new blank file');

  except
    // Catch error here
    on E: EInOutError do
      WriteLn('Error occurred. Details: ', E.ClassName, '/', E.Message);
  end;

  // Pause console
  ReadLn;
end.
