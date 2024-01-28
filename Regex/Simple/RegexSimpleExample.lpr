program RegexSimple;

// Program will quit when you give a text input matching regex pattern
// in the program's argument.

// For example.
// $./RegexSimple.exe "hello(.+)world"
// Enter a text: hello??world
// Matches!
// $

{$mode objfpc}{$H+}

uses
  RegExpr;

var
  re: TRegExpr;
  input: string;

begin

  // Create the regex object using first argument of the program
  re := TRegExpr.Create(ParamStr(1));

  // Set the regex to case-insensitive
  re.ModifierI := True;

  try

    // Keep on repeating until there is a match
    repeat
      WriteLn;
      Write('Enter a text:');
      ReadLn(input);

      // If there is a match, and the first match is not '' print 'Matches!'
      if re.Exec(input) and (re.Match[0] <> '') then
        // Show confirmation on screen
        WriteLn('Matches!')
      else
        WriteLn('No match, try again.');
    until re.Match[0] <> '';

  finally
    // Free TRegExpr object
    re.Free;
  end;

end.
