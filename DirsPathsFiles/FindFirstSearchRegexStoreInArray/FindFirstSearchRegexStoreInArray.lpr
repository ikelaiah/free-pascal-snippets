program FindFirstSearchRegexStoreInArray;

{$mode objfpc}{$H+}{$J-}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes,
  SysUtils,
  RegExpr;

  // A function for matching filename against a regex pattern
  function IsFileNameMatching(const fileName: string; const regexPattern: string): boolean;
  var
    regex: TRegExpr;
  begin
    regex := TRegExpr.Create;
    try
      // Set the regex to case-insensitive
      regex.ModifierI := True;
      // Apply the regex pattern
      regex.Expression := regexPattern;

      // Check for a match
      if regex.Exec(filename) then
        Result := True
      else
        Result := False;
    finally
      // Free TRegExpr
      regex.Free;
    end;
  end;

var
  searchRec: TSearchRec;
  path: string = './sub-folder/';
  regexExpression: string = '(.csv|.txt)';
  filesFound:array of string;
  fileCount: integer = 0;
  i: integer;

begin
  // Call FindFirst, append *.* to path
  if FindFirst(path + '*.*', faAnyFile, searchRec) = 0 then
  begin
    repeat
      // Skipping `.`, `..` and directories
      if (searchRec.Name <> '.') and (searchRec.Name <> '..') and (searchRec.Attr <> faDirectory) then
      begin
        // Matching result against a regex expression
        if IsFileNameMatching(searchRec.Name, regexExpression) then
        begin
          // Set length the array of string
          SetLength(filesFound, fileCount + 1);
          // Add file name from searchRec into this array
          filesFound[fileCount] := searchRec.Name;
          // Increment file counter
          Inc(fileCount);
          // Display files found by FindFirst
          WriteLn(searchRec.Name);
        end;
      end;
    until FindNext(searchRec) <> 0;
    // MUST FREE RESOURCES relating to FindFirst and FindNext
    FindClose(searchRec);
  end;

  // Display count of matching files
  WriteLn(Format('Found %d files matching %s', [Length(filesFound), regexExpression]));

  // Pause console
  WriteLn;
  WriteLn('Press Enter key to quit');
  ReadLn;
end.
