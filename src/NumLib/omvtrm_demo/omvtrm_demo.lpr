program omvtrm_demo;

{$mode objfpc}{$H+}{$J-}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes,
  typ,
  omv;

var
  matrix_A: array[1..2, 1..4] of ArbFloat = (
    ( 1,  2,  3,  4),
    (11, 22, 33, 44));
  transposed_A: array[1..4, 1..2] of ArbFloat;
  m_row_matrix_A, n_col_matrix_A, i, j: integer;

begin

  m_row_matrix_A := High(matrix_A) - Low(matrix_A) + 1;
  n_col_matrix_A := High(matrix_A[1]) - Low(matrix_A[1]) + 1;

  // Transpose matrix_A
  omvtrm(
    matrix_A[1,1], m_row_matrix_A, n_col_matrix_A, n_col_matrix_A,
    transposed_A[1,1], m_row_matrix_A
  );

  // Print matrix_A
  WriteLn('A = ');
  for i:= 1 to m_row_matrix_A do begin
    for j := 1 to n_col_matrix_A do
      Write(matrix_A[i, j]:8:0);
    WriteLn;
  end;
  WriteLn;

  // Print transposed_A
  WriteLn('Aᵀ = ');
  for i:= 1 to n_col_matrix_A do begin
    for j := 1 to m_row_matrix_A do
      Write(transposed_A[i, j]:8:0);
    WriteLn;
  end;

  WriteLn;
  WriteLn('Press enter key to quit');
  ReadLn;
end.
