program FindFirstSearchRecursive;

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

  // A recursive search function using FindFirst and Regex
  procedure SearchFiles(const path: string; const regexPattern: string);
  var
    searchRec: TSearchRec;
  begin
    if FindFirst(path + '*.*', faAnyFile, searchRec) = 0 then
    begin
      repeat
        if (searchRec.Name <> '.') and (searchRec.Name <> '..') then
        begin
          // If searchRec.Name is a directory, then call this function recursively
          if (searchRec.Attr and faDirectory) = faDirectory then
          begin
            // If found a directory, perform search on that directory
            SearchFiles(path + searchRec.Name + PathDelim, regexPattern);
          end
          else
            // If searchRec.Name is not a directory, check if the file matches regex pattern
          begin
            if IsFileNameMatching(path + searchRec.Name, regexPattern) then
              // If it matches regex expression, display name
              WriteLn(path + searchRec.Name);
          end;
        end;
      until FindNext(searchRec) <> 0;
      // MUST RELEASE resources relating to FindFirst and FindNext
      FindClose(searchRec);
    end;
  end;

var
  path: string = './sub-folder/';
  regexPattern: string = '(.csv|.xlsx)';

begin
  // Display files in a path, recursively, using a regex pattern
  SearchFiles(path, regexPattern);

  // Pause Console
  WriteLn('Press Enter key to Exit');
  ReadLn;
end.
