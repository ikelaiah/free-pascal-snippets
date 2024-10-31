program eig_general_matrix;

{$mode objfpc}{$H+}{$J-}

uses
  SysUtils, math, typ, eig;

const
  n = 3;         // Size of the matrix where m (row) = n (row)
  dec_place = 3; // No of decimal place

var
  // a is the input matrix
  mat_a: array[1..n, 1..n] of ArbFloat = (
    ( 8, -1, -5),
    (-4,  4, -2),
    (18, -5, -7)
  );
  eig_values_lambda: array[1..n] of complex;
  eig_vec_mat_x: array[1..n, 1..n] of complex;
  term: integer = 0;
  i, j: integer;

  function ComplexToStr(z: complex; decimals: integer): String;
  var
    sgn: array[boolean] of string = ('+', '-');
  begin
    Result := Format('%.*f %s %.*fi', [Decimals, z.Re, sgn[z.Im < 0], Decimals, abs(z.Im)]);
  end;

begin
  // write input matrix
  WriteLn('Matrix a = ');
  for i := 1 to n do begin
    for j := 1 to n do
      Write(mat_a[i, j]:10:dec_place);
    WriteLn;
  end;
  WriteLn;

  // Calculate eigenvalues/vectors
  eigge3(mat_a[1,1], n, n, eig_values_lambda[1], eig_vec_mat_x[1,1], n, term);

  // write eigenvalues
  WriteLn('Eigenvalues: lambda = ');
  for i := 1 to n do
    Write(ComplexToStr(eig_values_lambda[i], dec_place):25);
  WriteLn;
  WriteLn;

  // Write eigenvectors
  WriteLn('Eigenvectors (as columns): x = ');
  for i := 1 to n do begin
    for j := 1 to n do
      Write(ComplexToStr(eig_vec_mat_x[i, j], dec_place):25);
    WriteLn;
  end;

  // Pause console
  WriteLn('Press enter to quit');
  ReadLn;
end.
