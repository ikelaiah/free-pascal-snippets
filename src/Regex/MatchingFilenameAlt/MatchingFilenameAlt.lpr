program MatchingFilenameAlt;

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
  regexPattern: string = '\w*.txt$';
  filename: string = 'hello-text.txt';

begin
  if IsFileNameMatching(filename, regexPattern) then
    WriteLn(Format('%s matches %s!', [regexPattern, filename]))
  else
    WriteLn(Format('%s does not match %s!', [regexPattern, filename]));

  //Pause console
  WriteLn('Press Enter kay to exit ...');
  ReadLn;
end.
