program omv_norm_demo;

{$mode objfpc}{$H+}{$J-}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes,
  typ,
  omv;

var
  vector_a: array[0..3] of ArbFloat = (0, 1, 2, -3);
  matrix_b: array[0..3, 0..1] of Arbfloat = ((3, -1),
                                             (-2, 2),
                                             (0, -1),
                                             (2, 1));
  n_vec, n_col_matrix, m_row_matrix, i, j: integer;

begin
  // Get length of vector and the size of the matrix
  n_vec := High(vector_a) - Low(vector_a) + 1;
  m_row_matrix := High(matrix_b) - Low(matrix_b) + 1;
  n_col_matrix := High(matrix_b[1]) - Low(matrix_b[1]) + 1;

  Write('Vector a = [');
  for i := Low(vector_a) to High(vector_a) do
    Write(vector_a[i]: 5: 0);
  WriteLn('  ]');
  WriteLn('        1-norm of vector a: ', omvn1v(vector_a[0], n_vec): 0: 3);
  WriteLn('        2-norm of vector a: ', omvn2v(vector_a[0], n_vec): 0: 3);
  WriteLn('  maximum norm of vector a: ', omvnmv(vector_a[0], n_vec): 0: 3);
  WriteLn;

  WriteLn('Matrix b = ');
  for i := 0 to m_row_matrix - 1 do
  begin
    for j := 0 to n_col_matrix - 1 do
      Write(matrix_b[i, j]: 5: 0);
    WriteLn;
  end;
  WriteLn('        1-norm of matrix b: ', omvn1m(matrix_b[0, 0], m_row_matrix, n_col_matrix, n_col_matrix): 0: 3);
  WriteLn('Forbenius norm of matrix b: ', omvnfm(matrix_b[0, 0], m_row_matrix, n_col_matrix, n_col_matrix): 0: 3);
  WriteLn('  maximum norm of matrix b: ', omvnmm(matrix_b[0, 0], m_row_matrix, n_col_matrix, n_col_matrix): 0: 3);

  WriteLn;
  WriteLn('Press enter key to quit');
  ReadLn;
end.
