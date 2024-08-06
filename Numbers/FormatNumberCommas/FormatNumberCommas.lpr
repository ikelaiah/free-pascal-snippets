program FormatNumberCommas;

{$mode objfpc}{$H+}{$J-}

uses
  SysUtils;

var
  number: int64;
  formattedNumber: string;

  { Main Block }
begin
  // Formatting a number with commas
  number := 12345678;
  formattedNumber := Format('%.0n', [number * 1.0]);
  WriteLn('Formatted Number: ', formattedNumber);  // Output: 12,345,678

  // Pause console
  WriteLn('Press enter key to exit');
  ReadLn;
end.

