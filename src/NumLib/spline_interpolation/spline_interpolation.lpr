program spline_interpolation;

{$mode objfpc}{$H+}{$J-}

uses
  typ,
  ipf;

const
  n = 8;

var
  x: array[0..n] of ArbFloat = (0.00, 0.09, 0.22, 0.34, 0.47, 0.58, 0.65, 0.80, 0.93);
  y: array[0..n] of ArbFloat = (0.990, 0.927, 0.734, 0.542, 0.388, 0.292, 0.248, 0.179, 0.139);
  d2s: array[1..n - 1] of ArbFloat;
  i: integer;
  term: ArbInt;
  xint, yint: ArbFloat;
begin
  WriteLn('Cubic spline interpolation');

  // Print data points
  WriteLn('Data points');
  WriteLn('i': 10, 'x_i': 10, 'y_i': 10);
  for i := 0 to n do
    WriteLn(i: 10, x[i]: 10: 2, y[i]: 10: 3);

  // Calculate spline parameters
  ipfisn(n, x[0], y[0], d2s[1], term);

  // Display second derivatives
  WriteLn('Second derivatives');
  for i := 1 to n - 1 do
    WriteLn(d2s[i]: 10: 6);

  // Interpolation
  WriteLn('Interpolated values');
  for i := 1 to 5 do
  begin
    xint := 0.2 * i;
    yint := ipfspn(n, x[0], y[0], d2s[1], xint, term);
    WriteLn(xint: 10: 2, yint: 10: 2);
  end;

// Pause to allow user to see results before exiting the program
WriteLn('Press enter to quit');
ReadLn;
end.
