program solve_root_nonlinear;

{$mode objfpc}{$H+}{$J-}

uses
  SysUtils, typ, roo;

const
  n = 2;
  ra = 1e-10;

var
  x: array[1..n] of ArbFloat;
  f_check: array[1..n] of ArbFloat;
  residu: ArbFloat;
  i: integer;
  term: integer;
  deff: boolean;

  procedure funcs(var x0, fx: ArbFloat; var deff: boolean);
  var
    xloc: array[1..n] of ArbFloat absolute x0;
    f: array[1..n] of ArbFloat absolute fx;
  begin
    f[1] := sqr(xloc[1]) + sqr(xloc[2]) - 2;
    f[2] := -sqr(xloc[1] - 1) + xloc[2];
  end;

begin
  // Initial guess values
  x[1] := 0;
  x[2] := 0;

  // Solve the equation system
  roofnr(@funcs, n, x[1], residu, ra, term);

  WriteLn('term = ', term);
  WriteLn;

  if term in [1, 2] then begin
    WriteLn('Results found by procedure roofnr:');
    for i := 1 to n do
      WriteLn('Solution #' + IntToStr(i) + ': ', x[i]:0:6);
    WriteLn('Norm of residuals: ', residu:0:15);
  end else
    WriteLn('ERROR');

  // Pause to allow user to see results before exiting the program
  WriteLn('Press enter to quit');
  ReadLn;
end.

