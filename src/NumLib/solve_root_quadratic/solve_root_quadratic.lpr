program solve_root_quadratic;

{$mode objfpc}{$H+}{$J-}

uses
  SysUtils, typ, roo;

var
  z1, z2: complex;

const
  SIGN: array[boolean] of string = ('+', '-');

begin
  rooqua(2, 5, z1, z2);

  WriteLn(Format('1st solution: %g %s %g i', [z1.re, SIGN[z1.im < 0], abs(z1.im)]));
  WriteLn(Format('2nd solution: %g %s %g i', [z2.re, SIGN[z2.im < 0], abs(z2.im)]));

  // Pause to allow user to see results before exiting the program
  WriteLn('Press enter to quit');
  ReadLn;
end.

