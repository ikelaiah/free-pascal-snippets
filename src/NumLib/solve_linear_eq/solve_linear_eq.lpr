program solve_linear_eq;

{$mode objfpc}{$H+}{$J-}

{
  This is an example for solving linear equations; A x = b, using slgen in numlib.

  5 x_1 +  7 x_2 +  6 x_3 +  5 x_4 = 57         |5  7 6 5|      |57|
  7 x_1 + 10 x_2 +  8 x_3 +  7 x_4 = 79  => A = |7 10 8 7|, b = |79|
  6 x_1 +  8 x_2 + 10 x_3 +  9 x_4 = 88         |6 8 10 9|      |88|
  5 x_1 +  7 x_2 +  9 x_3 + 10 x_4 = 86         |5 7 9 10|      |86|

  Lastly, it tests the result, x, by multiplying A x (from slgen's output) and
  the result must be equal to b.
  }

uses
  NumLib,
  typ,
  sle,
  omv;

const
  n_col = 4; // n (col) = m (row) for square matrice

var
  mat_A: array[1..n_col, 1..n_col] of ArbFloat = (
  (5, 7, 6,  5),
  (7, 10, 8, 7),
  (6, 8, 10, 9),
  (5, 7, 9, 10));
  vec_b: array[1..n_col] of ArbFloat = (57, 79, 88, 86);
  soln_vec_x: array[1..n_col] of ArbFloat;
  vec_b_test: array[1..n_col] of ArbFloat;
  ca: ArbFloat;
  i, j: integer;
  term: integer;

begin

  WriteLn('Solve matrix system A x = b');
  WriteLn;

    // Print mat_A
    WriteLn('Matrix A = ');
    for i:= 1 to n_col do begin
      for j := 1 to n_col do
        Write(mat_A[i, j]:10:0);
      WriteLn;
    end;
    WriteLn;

    // Print vec_b
    WriteLn('Vector b = ');
    for i:= 1 to n_col do
      Write(vec_b[i]:10:0);
    WriteLn;
    WriteLn;

    // Solve - select one of these methods
    slegen(n_col, n_col, mat_A[1, 1], vec_b[1], soln_vec_x[1], ca, term);
    //slegsy(n_col, n_col, mat_A[1, 1], vec_b[1], soln_vec_x[1], ca, term);
    //slegpd(n_col, n_col, mat_A[1, 1], vec_b[1], soln_vec_x[1], ca, term);

  if term = 1 then begin
      WriteLn('Solution vector x = ');
      for i:= 1 to n_col do
        Write(soln_vec_x[i]:10:0);
      WriteLn;
      WriteLn;

      omvmmv(mat_A[1,1], n_col, n_col, n_col, soln_vec_x[1], vec_b_test[1]);

      WriteLn('Check result: A x = (must be equal to b)');
      for i:= 1 to n_col do
        Write(vec_b_test[i]:10:0);
      WriteLn;
    end
    else
      WriteLn('Error');

  WriteLn('Press enter key to exit');
  ReadLn; // Wait for user input before closing
end.
