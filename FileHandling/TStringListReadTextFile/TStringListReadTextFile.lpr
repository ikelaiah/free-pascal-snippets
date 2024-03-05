program TStringListReadTextFile;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cmem, cthreads,
  {$ENDIF}
  Classes,
  SysUtils;

var
  filename: string = 'cake-ipsum.txt';
  stringList: TStringList;
  line: string;

// Main block
begin

  // Provide user feedback
  WriteLn(Format('Reading ''%s''', [filename]));
  WriteLn('--------------------');

  // Start try..except
  try
    // Create the TSTringList object
    stringList := TStringList.Create;

    // Start try..finally
    try
      // Read the file into a TStringList
      stringList.LoadFromFile(filename);

      // Use for loop to read the content of the stringList
      for line in stringList do
        WriteLn(line);

    finally
      // Free object from memory
      stringList.Free;
    end;

  except
    on E: Exception do
      WriteLn('File handling error occurred. Details: ', E.Message);
  end; // end of try..except

  // Pause console
  WriteLn('--------------------');
  WriteLn('Press Enter key to quit.');
  ReadLn;

end.
