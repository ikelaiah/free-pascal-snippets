program ConsoleIO;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes;

var
  num1, num2, num3, total: integer;

begin
  WriteLn('Enter three numbers separated by spaces');
  ReadLn(num1, num2, num3);
  total := num1 + num2 + num3;
  WriteLn('The sum is: ', total);
  ReadLn;
end.
