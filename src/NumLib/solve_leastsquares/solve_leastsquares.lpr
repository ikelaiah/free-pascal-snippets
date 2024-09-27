program solve_leastsquares;

{$mode objfpc}{$H+}{$J-}

uses
  typ,
  sle,
  omv;

const
  m_row = 4;
  n_col = 3;

var
  mat_A: array[1..m_row, 1..n_col] of ArbFloat = (
     (1, 0, 1),
     (1, 1, 1),
     (0, 1, 0),
     (1, 1, 0));
  vec_b: array[1..m_row] of ArbFloat = (21, 39, 21, 30);
  soln_vec_x: array[1..n_col] of ArbFloat;
  term: ArbInt;
  i, j: integer;
  vec_b_test: array[1..m_row] of ArbFloat;
  sum: ArbFloat;

begin
  WriteLn('Solve A x = b with the least-squares method');
  WriteLn;

  // Display input data
  WriteLn('A = ');
  for i := 1 to m_row do
  begin
    for j := 1 to n_col do
      Write(mat_A[i, j]: 5: 0);
    WriteLn;
  end;
  WriteLn;
  WriteLn('b = ');
  for i := 1 to m_row do
    Write(vec_b[i]: 5: 0);
  WriteLn;

  // Calculate and show solution
  slegls(mat_A[1, 1], m_row, n_col, n_col, vec_b[1], soln_vec_x[1], term);

  WriteLn;
  WriteLn('Solution x = ');
  for j := 1 to n_col do
    Write(soln_vec_x[j]: 5: 0);
  WriteLn;

  // Calculate and display residuals
  WriteLn;
  WriteLn('Residuals A x - b = ');
  sum := 0;
  omvmmv(mat_A[1, 1], m_row, n_col, n_col, soln_vec_x[1], vec_b_test[1]);
  for i := 1 to m_row do
  begin
    Write((vec_b_test[i] - vec_b[i]): 5: 0);
    sum := sum + sqr(vec_b_test[i] - vec_b[i]);
  end;
  WriteLn;

  // Sum of squared residuals
  WriteLn;
  WriteLn('Sum of squared residuals');
  WriteLn(sum: 5: 0);

  WriteLn;
  WriteLn('----------------------------------------------------------------------------');
  WriteLn;

  // Modify solution to show that the sum of squared residuals increases';
  WriteLn('Modified solution x'' (to show that it has a larger sum of squared residuals)');
  soln_vec_x[1] := soln_vec_x[1] + 1;
  soln_vec_x[2] := soln_vec_x[2] - 1;
  WriteLn;
  for j := 1 to n_col do
    Write(soln_vec_x[j]: 5: 0);
  omvmmv(mat_A[1, 1], m_row, n_col, n_col, soln_vec_x[1], vec_b_test[1]);
  sum := 0;
  for i := 1 to m_row do
    sum := sum + sqr(vec_b_test[i] - vec_b[i]);
  WriteLn;
  WriteLn;
  WriteLn('Sum of squared residuals');
  WriteLn(sum: 5: 0);
  WriteLn;

  // Pause Console
  WriteLn('Press enter to quit');
  ReadLn;
end.
