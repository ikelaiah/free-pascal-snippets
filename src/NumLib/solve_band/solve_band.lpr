program solve_band;

{$mode objfpc}{$H+}{$J-}

uses
  typ, sle, omv;

const
  n = 7;  // For Square matrices, n_col = m_row
  L = 2;  // Number of diagonals the band extends below (or to the left of) the main diagonal.
  R = L;  // Number of diagonals the band extends above (or to the right of) the main diagonal.
  n_band_elements = n * (L + 1 + R) - (L * (L + 1) + R * (R + 1)) div 2;

var
  // Band elements arranged in rows, elements outside of the band omitted!
  mat_a_band_elements: array[1..n_band_elements] of Arbfloat = (
             5, -4, 1,
         -4, 6, -4, 1,
      1, -4, 6, -4, 1,
      1, -4, 6, -4, 1,
      1, -4, 6, -4, 1,
      1, -4, 6, -4,
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
  WriteLn('Solve matrix system A x = b where A is a band matrix');
  WriteLn;

  // Write diagonal elements
  WriteLn('Matrix A:');
  WriteLn('  n = ', n);
  Writeln('  Left band width L = ', L);
  WriteLn('  Right band width R = ', R);
  WriteLn('  Diagonal elements of A = ');
  for k := 1 to n_band_elements do
    Write(mat_a_band_elements[k]:5:0);
  WriteLn;
  WriteLn;

  // Solve
  slegba(n, l, r, mat_a_band_elements[1], vec_b[1], soln_vec_x[1], ca, term);

  if term = 1 then begin
    // Optional -- Test if tyhe result of matrix A with the solution vector x equals to vector b.
    // Since mutliplication of a matrix stored like a band matrix is quite
    // cumbersome we copy the band matrix into a standard matrix.
    FillChar(mat_a_test, SizeOf(mat_a_test), 0);
    k := 1;
    for i:=1 to L do
      for j := i-L to i+R do
        if (j >= 1) and (j <= n) then begin
          mat_a_test[i,j] := mat_a_band_elements[k];
          inc(k);
        end;

    for i:= L+1 to n-R do
      for j := i-L to i+R do begin
        mat_a_test[i,j] := mat_a_band_elements[k];
        inc(k);
      end;
    for i := n-R+1 to n do
      for j := i-L to i+R do
        if j <= n then begin
          mat_a_test[i,j] := mat_a_band_elements[k];
          inc(k);
        end;

    // Optional -- Print matrix A
    WriteLn('Matrix A =');
    for i:=1 to n do begin
      for j:=1 to n do
        Write(mat_a_test[i,j]:5:0);
      WriteLn;
    end;
    WriteLn;

    // Optional -- Print Vector b
    WriteLn('Vector b = ');
    for i:= 1 to n do
      Write(vec_b[i]:10:0);
    WriteLn;
    WriteLn;

    // Print solution
    WriteLn('Solution: vector x = ');
    for i:= 1 to n do
      Write(soln_vec_x[i]:10:3);
    WriteLn;
    WriteLn;

    // Optional -- Double-check result by multiply mat_a_text and the soln_vec_x
    // The result should be the same as vec_b
    omvmmv(mat_a_test[1,1], n, n, n, soln_vec_x[1], vec_b_test[1]);

    WriteLn('Check result: A x = (must be equal to b)');
    for i:= 1 to n do
      Write(vec_b_test[i]:10:0);
    WriteLn;
  end
  else
    WriteLn('Error');


  // Pause console
  WriteLn('Press enter to quit');
  ReadLn;
end.
