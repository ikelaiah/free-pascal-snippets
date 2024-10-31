program eig_symtridiag_matrix;

{$mode objfpc}{$H+}{$J-}

uses
  typ, eig;

const
  n_mat_size = 4;

var
  // This var contains the elements of the main diagonal of the input matrix
  diag_elements: array[1..n_mat_size] of ArbFloat = (1, 1, 1, 1);

  // This var contains the elements of the subdiagonal
  subdiag_elements: array[2..n_mat_size] of ArbFloat = (1, 2, 1);

  // Array to store the calculated eigenvalues
  eig_values_lambda: array[1..n_mat_size] of ArbFloat;

  // Matrix to store the calculated eigenvectors
  eig_vectors_mat_x: array[1..n_mat_size, 1..n_mat_size] of ArbFloat;

  // Variable for capturing the result of the eigenvalue/eigenvector calculation
  term: integer = 0;

  // Variables for loops
  i, j, k: integer;

begin

  // Write elements of diagonal
  WriteLn('n = ', n_mat_size);
  Write('Elements of main diagonal = ', diag_elements[1]:0:0);
  for k := 2 to n_mat_size do
    Write(diag_elements[k]:3:0);
  WriteLn;

  // Write elements of sub-diagonal
  Write('Elements of subdiagonal   = ', ' ':3, subdiag_elements[2]:0:0);
  for k := 3 to n_mat_size do
    Write(subdiag_elements[k]:3:0);
  WriteLn;
  WriteLn;

  // Write reconstructed band input matrix (not needed for calculation)
  WriteLn('Reconstructed A = ');
  for i := 1 to n_mat_size do begin
    for j := 1 to n_mat_size do begin
      if j = i then
        Write(diag_elements[i]:3:0)
      else if (j = i-1) then
        Write(subdiag_elements[i]:3:0)
      else if (j = i+1) then
        Write(subdiag_elements[i+1]:3:0)
      else
        Write(0.0:3:0);
    end;
    WriteLn;
  end;
  WriteLn;

  // Calculate eigenvalues/vectors
  eigts3(diag_elements[1], subdiag_elements[2], n_mat_size, eig_values_lambda[1], eig_vectors_mat_x[1,1], n_mat_size, term);
  if term <> 1 then begin
    WriteLn('term = ', term, ' --> ERROR');
    halt;
  end;

  // Write expected results of eigenvalues
  WriteLn('Expected eigenvalues:');
  Write(-sqrt(2):15:3, 2-sqrt(2):15:3, sqrt(2):15:3, 2+sqrt(2):15:3);
  WriteLn;
  WriteLn;

  // write eigenvalues
  WriteLn('Calculated eigenvalues: lambda = ');
  for i := 1 to n_mat_size do
    Write(eig_values_lambda[i]:15:3);
  WriteLn;
  WriteLn;

  // Write eigenvectors
  WriteLn('Eigenvectors (as columns): x = ');
  for i := 1 to n_mat_size do begin
    for j := 1 to n_mat_size do
      Write(eig_vectors_mat_x[i, j]:15:3);
    WriteLn;
  end;

  // Pause to allow user to see results before exiting the program
  WriteLn('Press enter to quit');
  ReadLn;
end.

