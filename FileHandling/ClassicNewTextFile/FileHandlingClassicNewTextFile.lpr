program ClassicNewTextFile;

{$mode objfpc}{$H+}

uses
  SysUtils;

var
  textFile: System.TextFile;

begin
  // Set the name of the file that will be created
  AssignFile(textFile, 'output_file.txt');

  // Enclose in try/except block to handle errors
  try
    // Open the file for writing (it will create it file doesn't exist)
    ReWrite(textFile);

    // Adding text
    WriteLn(textFile, 'This is a new line');

    // Close file
    CloseFile(textFile);

    WriteLn('Created a new file');

  except
    // Catch error here
    on E: EInOutError do
      WriteLn('Error occurred. Details: ', E.ClassName, '/', E.Message);
  end;

  // Pause console
  ReadLn;
end.
