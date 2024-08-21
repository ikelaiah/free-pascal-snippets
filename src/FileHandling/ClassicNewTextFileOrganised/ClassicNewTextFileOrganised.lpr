program ClassicNewTextFileOrganised;

{$mode objfpc}{$H+}{$J-}

uses
  SysUtils;

  // Write or append a text to a file
  procedure WriteTextToFile(fileName: string; stringText: string);
  var
    textFile: System.TextFile;
  begin
    try
      // Set the name of the file that will be created
      AssignFile(textFile, fileName);

      // Enclose in try/except block to handle errors
      try
        // Create (if not found) and open the file for writing
        Rewrite(textFile);

        // Adding text
        WriteLn(textFile, stringText);

      except
        // Catch error here
        on E: EInOutError do
          WriteLn('Error occurred. Details: ', E.ClassName, '/', E.Message);
      end;
    finally
      // Close file
      CloseFile(textFile);
    end;
  end;

begin

  // Write a text to a file
  WriteTextToFile('hello-text.txt', 'Hello There! How are you?');

  // Pause console
  ReadLn;
end.
