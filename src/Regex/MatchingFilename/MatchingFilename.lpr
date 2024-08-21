program MatchingFilename;

{$mode objfpc}{$H+}{$J-}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes,
  SysUtils,
  RegExpr;

var
  regex: TRegExpr;
  regexPattern: string = '\w*.txt$';
  filename: string = 'hello-text.txt';

begin
  // Create TRegExpr
  regex := TRegExpr.Create;
  try
    // Set the regex to case-insensitive
    regex.ModifierI := True;
    // Apply the regex pattern
    regex.Expression := regexPattern;
    // Check for a match
    if regex.Exec(filename) then
      WriteLn(Format('''%s'' matches %s!', [regexPattern, filename]))
    else
      WriteLn(Format('''%s'' does not match %s!', [regexPattern, filename]));
  finally
    // Free TRegExpr
    regex.Free;
  end;

  // Pause console
  WriteLn('Press Enter key to exit ...');
  ReadLn;
end.
