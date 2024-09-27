program omvmmv_demo;

{$mode objfpc}{$H+}{$J-}

uses
  typ,
  omv;

var
  matrix_A: array[1..3, 1..5] of ArbFloat = (
    (3, 5, 4, 1, -4),
    (-2, 3, 4, 1, 0),
    (0, 1, -1, -2, 5));
  vector_b: array[1..5] of ArbFloat = (3, 0, -1, -2, 1);
  vector_c: array[1..5] of ArbFloat;
  m_row, n_column, i, j: integer;

begin

  m_row := High(matrix_A) - Low(matrix_A) + 1;
  n_column := High(matrix_A[1]) - Low(matrix_A[1]) + 1;

  // Calculate product vector_c = matrix_A vector_b
  omvmmv(
    matrix_A[1, 1], m_row, n_column, n_column,
    vector_b[1],
    vector_c[1]
    );

  // Print matrix_A
  WriteLn('A = ');
  for i := 1 to m_row do
  begin
    for j := 1 to n_column do
      Write(matrix_A[i, j]: 4: 0);
    WriteLn;
  end;
  WriteLn;

  // Print vector vector_b
  WriteLn('b = ');
  for i := 1 to n_column do
    WriteLn(vector_b[i]: 4: 0);
  WriteLn;
  WriteLn;

  // Print result vector vector_c
  WriteLn('c = A b');
  WriteLn('c = ');
  for i := 1 to m_row do
    WriteLn(vector_c[i]: 4: 0);
  WriteLn;

  // Pause console
  WriteLn('Press enter key to exit');
  ReadLn;
end.
