program ClassicNewTextFileOrganised;

{$mode objfpc}{$H+}

uses
  SysUtils;

  // Write or append a text to a file
  procedure WriteTextToFile(fileName: string; stringText: string;);
  var
    textFile: System.TextFile;
  begin
    // Set the name of the file that will be created
    AssignFile(textFile, fileName);

    // Enclose in try/except block to handle errors
    try
      // Create (if not found) and open the file for writing
      Rewrite(textFile);

      // Adding text
      WriteLn(textFile, stringText);

      // Close file
      CloseFile(textFile);

    except
      // Catch error here
      on E: EInOutError do
        writeln('Error occurred. Details: ', E.ClassName, '/', E.Message);
    end;
  end;

begin

  // Write a text to a file
  WriteTextToFile('hello-text.txt', 'Hello There! How are you?');

  // Wait for enter
  readln;
end.
