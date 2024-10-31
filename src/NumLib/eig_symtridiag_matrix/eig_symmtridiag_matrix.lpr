program eig_symmtridiag_matrix;

{$mode objfpc}{$H+}{$J-}

uses
  typ, eig;

const
  n = 4;

  // a contains the elements of the main diagonal of the input matrix
  d: array[1..n] of ArbFloat = (1, 1, 1, 1);
  // c contains the elements of the subdiagonal
  c: array[2..n] of ArbFloat = (1, 2, 1);

var
  lambda: array[1..n] of ArbFloat;
  x: array[1..n, 1..n] of ArbFloat;
  term: Integer = 0;
  i, j, k: Integer;

begin
  // Write diagonals elements
  WriteLn('n = ', n);
  Write('Elements of main diagonal = ', d[1]:0:0);
  for k := 2 to n do
    Write(d[k]:3:0);
  WriteLn;
  Write('Elements of subdiagonal   = ', ' ':3, c[2]:0:0);
  for k := 3 to n do
    Write(c[k]:3:0);
  WriteLn;
  WriteLn;

  // write reconstructed band input matrix (not needed for calculation)
  WriteLn('Reconstructed A = ');
  for i := 1 to n do begin
    for j := 1 to n do begin
      if j = i then
        Write(d[i]:3:0)
      else if (j = i-1) then
        Write(c[i]:3:0)
      else if (j = i+1) then
        Write(c[i+1]:3:0)
      else
        Write(0.0:3:0);
    end;
    WriteLn;
  end;
  WriteLn;

  // Calculate eigenvalues/vectors
  eigts3(d[1], c[2], n, lambda[1], x[1,1], n, term);
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
  for i := 1 to n do
    Write(lambda[i]:15:3);
  WriteLn;
  WriteLn;

  // Write eigenvectors
  WriteLn('Eigenvectors (as columns): x = ');
  for i := 1 to n do begin
    for j := 1 to n do
      Write(x[i, j]:15:3);
    WriteLn;
  end;

  // Pause to allow user to see results before exiting the program
  WriteLn('Press enter to quit');
  ReadLn;
end.

