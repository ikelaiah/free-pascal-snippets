program inverse_matrix;

{$mode objfpc}{$H+}{$J-}

uses
  typ, inv, omv;

const
  n_mat_size = 4;
  decimals = 5;

var
  // a is the input matrix to be inverted
  // Note that this is matrix must be symmetric positive definite.
  mat_a: array[1..n_mat_size, 1..n_mat_size] of ArbFloat = (
    (5,  7,  6,  5),
    (7, 10,  8,  7),
    (6,  8, 10,  9),
    (5,  7,  9, 10)
  );
  mat_b: array[1..n_mat_size, 1..n_mat_size] of Arbfloat;
  mat_c: array[1..n_mat_size, 1..n_mat_size] of ArbFloat;
  term: integer = 0;
  i, j: integer;

begin
  // Write input matrix
  WriteLn('a = ');
  for i := 1 to n_mat_size do begin
    for j := 1 to n_mat_size do
      Write(mat_a[i, j]:10:decimals);
    WriteLn;
  end;
  WriteLn;

  // Store input matrix because it will be overwritten by the inverse of mat_a
  for i := 1 to n_mat_size do
    for j := 1 to n_mat_size do
      mat_b[i, j] := mat_a[i, j];

  // Calculate inverse  -- uncomment the procedure to be used.
  //invgen(n_mat_size, n_mat_size, mat_a[1, 1], term);
  //invgsy(n_mat_size, n_mat_size, mat_a[1, 1], term);
  invgpd(n_mat_size, n_mat_size, mat_a[1, 1], term);

  // Write inverse
  WriteLn('a^(-1) = ');
  for i := 1 to n_mat_size do begin
    for j := 1 to n_mat_size do
      Write(mat_a[i, j]:10:decimals);
    WriteLn;
  end;
  WriteLn;

  // Check validity of result by multiplying inverse with saved input matrix
  omvmmm(mat_a[1, 1], n_mat_size, n_mat_size, n_mat_size,
         mat_b[1, 1], n_mat_size, n_mat_size,
         mat_c[1, 1], n_mat_size);

  // Write inverse
  WriteLn('a^(-1) x a = ');
  for i := 1 to n_mat_size do begin
    for j := 1 to n_mat_size do
      Write(mat_c[i, j]:10:decimals);
    WriteLn;
  end;

  // Pause console
  WriteLn('Press enter to quit');
  ReadLn;
end.
