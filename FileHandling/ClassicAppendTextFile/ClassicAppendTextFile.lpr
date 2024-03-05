program ClassicAppendTextFile;

{$mode objfpc}{$H+}{$J-}

uses
  SysUtils;

  // Create a new file, the classical way
  procedure CreateNewFile(filename: string);
  var
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
      WriteLn(Format('Created a new file: ''%s''', [filename]));

    except
      // Catch error here
      on E: EInOutError do
        WriteLn('Error occurred. Details: ', E.ClassName, '/', E.Message);
    end;
  end;

var
  filename: string = 'hello-text.txt';
  textFile: System.TextFile;

begin

  // First of all, check if the input file exists.
  // If not, create a new text file
  if not FileExists(filename) then
    CreateNewFile(filename);

  try
    // Set filename to a file
    AssignFile(textFile, filename);

    // Enclose in try/except block to handle errors
    try
      // Open a file for appending.
      Append(textFile);

      // Adding text
      WriteLn(textFile, 'New Line!');
      WriteLn(textFile, 'New Line!');

    except
      // Catch error here
      on E: EInOutError do
        writeln('Error occurred. Details: ', E.ClassName, '/', E.Message);
    end;

  finally
    // Close file
    CloseFile(textFile);
  end;

  // Pause console
  WriteLn('Press Enter key to quit.');
  ReadLn;
end.
