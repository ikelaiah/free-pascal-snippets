program solve_spd;    // "spd" = symmetric positive definite

{$mode objfpc}{$H+}{$J-}

uses
  typ, sle, omv;

const
  n = 7;
  w = 2;
  n_band_elements = n * (w + 1) - (w * (w + 1)) div 2;

var
  // Band elements arranged in rows
  // Elements outside of the band as well as right diagonals are omitted!
  mat_a: array[1..n_band_elements] of Arbfloat = (
             5,
            -4, 6,
             1, -4, 6,
                 1, -4, 6,
                     1, -4, 6,
                       1, -4, 6,
                          1, -4, 5
    );
  vec_b: array[1..n] of ArbFloat = (
    0, 0, 0, 1, 0, 0, 0
  );
  soln_vec_x: array[1..n] of ArbFloat;
  mat_a_test: array[1..n, 1..n] of ArbFloat;
  vec_b_test: array[1..n] of ArbFloat;
  ca: ArbFloat;
  i, j, k: integer;
  term: integer;

begin
  WriteLn('Solve matrix system A x = b where A is a symmetric positive definite band matrix');
  WriteLn;

  // Write diagonal elements
  WriteLn('Matrix A:');
  WriteLn('  n = ', n);
  Writeln('  (One-sided) band width w = ', w);
  WriteLn('  Diagonal elements of A = ');
  for k := 1 to n_band_elements do
    Write(mat_a[k]:5:0);
  WriteLn;
  WriteLn;

  // Solve
  slegpb(n, w, mat_a[1], vec_b[1], soln_vec_x[1], ca, term);

  if term = 1 then begin
    // To test the result we multiply a with the solution vector x and check
    // whether the result is equal to b.
    // Since mutliplication of a matrix stored like a band matrix is quite
    // cumbersome we copy the band matrix into a standard matrix.
    FillChar(mat_a_test, SizeOf(mat_a_test), 0);
    i := 1;
    k := 1;
    while (k <= n_band_elements) and (i <= n) do begin
      for j := i - w to i do
        if (j >= 1) and (j <= n) then begin
          mat_a_test[i, j] := mat_a[k];
          mat_a_test[j, i] := mat_a[k];
          inc(k);
        end;
      inc(i);
    end;

    // Print mat_a
    WriteLn('Matrix A =');
    for i:=1 to n do begin
      for j:=1 to n do
        Write(mat_a_test[i,j]:5:0);
      WriteLn;
    end;
    WriteLn;

    // Print vec_b
    WriteLn('Vector b = ');
    for i:= 1 to n do
      Write(vec_b[i]:10:0);
    WriteLn;
    WriteLn;

    // Print solution vec_x
    WriteLn('Solution: vector x = ');
    for i:= 1 to n do
      Write(soln_vec_x[i]:10:3);
    WriteLn;
    WriteLn;

    omvmmv(mat_a_test[1,1], n, n, n, soln_vec_x[1], vec_b_test[1]);

    WriteLn('Check result: A x = (must be equal to b)');
    for i:= 1 to n do
      Write(vec_b_test[i]:10:3);
    WriteLn;
  end
  else
    WriteLn('Error');

  // Pause Console
  WriteLn('Press enter to quit');
  ReadLn;
end.
