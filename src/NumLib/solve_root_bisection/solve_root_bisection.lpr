program solve_root_bisection;

{$mode objfpc}{$H+}{$J-}

uses
  typ, roo;

function f(x: ArbFloat): ArbFloat;
begin
  Result := x*x - 2;
end;

var
  x: ArbFloat = 0.0;
  term: ArbInt;

begin
  roof1r(@f, 1.0, 2.0, 1e-9, 0, x, term);
  WriteLn('Bisection result: ', x);
  WriteLn('sqrt(2):          ', sqrt(2.0));

  // Pause to allow user to see results before exiting the program
  WriteLn('Press enter to quit');
  ReadLn;
end.

