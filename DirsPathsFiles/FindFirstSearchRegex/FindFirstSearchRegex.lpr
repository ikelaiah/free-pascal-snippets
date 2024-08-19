program FindFirstSearchRegex;

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
  Count: integer = 0; // Optional, only if you need a count

begin
  // Call FindFirst, append *.* to path
  if FindFirst(path + '*.*', faAnyFile, searchRec) = 0 then
  begin
    repeat
      if (searchRec.Name <> '.') and (searchRec.Name <> '..') and (searchRec.Attr <> faDirectory) then
      begin
        if IsFileNameMatching(searchRec.Name, regexExpression) then
        begin
          // Optional, only if you need a count -- increase a counter
          Inc(Count);
          // Display files found by FindFirst
          WriteLn(searchRec.Name);
        end;
      end;
    until FindNext(searchRec) <> 0;
    // MUST FREE RESOURCES relating to FindFirst and FindNext
    FindClose(searchRec);
  end;

  // Display count of matching files
  WriteLn(Format('Found %d files matching %s', [Count, regexExpression]));

  // Pause console
  WriteLn;
  WriteLn('Press Enter key to quit');
  ReadLn;
end.
