program polynomial_fit;

{$mode objfpc}{$H+}{$J-}

uses
  SysUtils, typ, ipf, spe;

const
  m = 8;  // Number of data points
  n = 2;  // Polynomial degree

var
  x: array[1..m] of ArbFloat = (0.00, 0.08, 0.22, 0.33, 0.46, 0.52, 0.67, 0.81);
  y: array[1..m] of ArbFloat = (1.26, 1.37, 1.72, 2.08, 2.31, 2.64, 3.12, 3.48);
  b: array[0..n] of ArbFloat;
  i: Integer;
  term: ArbInt;
  xint, yint: ArbFloat;
begin
  WriteLn('Fitting a polynomial of degree 2: p(x) = b[0] + b[1] x + b[2] x^2');

  // Print data points
  WriteLn('Data points');
  WriteLn('i':10, 'x_i':10, 'y_i':10);
  for i := 1 to m do
    WriteLn(i:10, x[i]:10:2, y[i]:10:2);

  // Fit polynomial
  ipfpol(m, n, x[1], y[1], b[0], term);

  // Display coefficients
  WriteLn('Fitted coefficients b = ', b[0]:10:6, b[1]:10:6, b[2]:10:6);

  // Interpolation
  WriteLn('Interpolated values:');
  for i := 1 to 5 do begin
    xint := 0.2 * i;
    yint := spepol(xint, b[0], n);
    WriteLn(xint:10:2, yint:10:2);
  end;

  // Pause to allow user to see results before exiting the program
  WriteLn('Press enter to quit');
  ReadLn;
end.
