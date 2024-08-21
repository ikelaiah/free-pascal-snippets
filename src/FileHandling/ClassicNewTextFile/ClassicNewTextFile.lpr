program ClassicNewTextFile;

{$mode objfpc}{$H+}{$J-}

uses
  SysUtils;

var
  textFile: System.TextFile;

begin
    try
      // Set the name of the file that will be created
      AssignFile(textFile, 'output_file.txt');

      // Enclose in try/except block to handle errors
      try
        // Create (if not found) and open the file for writing
        Rewrite(textFile);

        // Adding text
        WriteLn(textFile, 'Hello Text!');

      except
        // Catch error here
        on E: EInOutError do
          WriteLn('Error occurred. Details: ', E.ClassName, '/', E.Message);
      end;
    finally
      // Close file
      CloseFile(textFile);
    end;

  // Pause console
  ReadLn;
end.
