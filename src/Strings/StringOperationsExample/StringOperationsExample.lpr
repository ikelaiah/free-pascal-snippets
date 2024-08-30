program StringOperationsExample;

{$mode objfpc}{$H+}{$J-}

uses
  SysUtils;

var
  str1, str2, str3, result: string;
  position: integer;
  comparisonResult: integer;

begin
  str1 := 'Hello World';
  str2 := 'Welcome to Pascal';
  str3 := 'This is not easy!';

  // Concatenation
  result := str1 + ', ' + str2;
  Writeln('Concatenated string: ', result);
  // Outputs: Hello World, Welcome to Pascal

  // CompareStr (case-sensitive)
  comparisonResult := CompareStr(str1, 'hello world');
  Writeln('CompareStr result: ', comparisonResult);
  // Outputs: < 0 , since orc('H') < ord('h')

  // CompareText (case-insensitive)
  comparisonResult := CompareText(str1, 'hello world');
  Writeln('CompareText result: ', comparisonResult);
  // Outputs: 0,  since 'Hello World' = 'hello world' ignoring case

  // Length
  Writeln('Length of str1: ', Length(str1));
  // Outputs: 11

  // Pos
  position := Pos('World', str1);
  Writeln('Position of ''World'' in str1: ', position);
  // Outputs: 7

  // Copy
  result := Copy(str1, Pos('World', str1), Length('World'));
  Writeln('Copy ''World'' from str1: ', result);
  // Outputs: World

  // Delete
  Delete(str3, Pos('not ', str3), Length('not '));
  Writeln('After deleting ''NOT '' from str3: ', str3);
  // Outputs: This is easy

  // Insert
  Insert('really ', str3, pos('easy', str3));
  Writeln('After inserting ''really '' into str3: ', str3);
  // Outputs: This is really easy

  // StringReplace
  result := StringReplace(str1, 'Hello', 'Hello Free Pascal', [rfReplaceAll, rfIgnoreCase]);
  Writeln('After StringReplace to str1: ', result);
  // Outputs: Hello Free Pascal

  // Access character at position n
  Writeln('Character at pos 7 in str2: ', str2[7]);
  // Outputs: e

  // UpperCase
  result := UpperCase(str2);
  Writeln('UpperCase of str2: ', result);
  // Outputs: WELCOME TO FREE PASCAL

  // LowerCase
  result := LowerCase(str2);
  Writeln('LowerCase of str2: ', result);
  // Outputs: welcome to free pascal

  //Pause console
  WriteLn('Press enter key to quit');
  ReadLn;
end.
