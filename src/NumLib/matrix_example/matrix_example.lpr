program matrix_example;

{$mode objfpc}{$H+}{$J-}

uses
  NumLib,
  typ,
  omv;

var
  // Array of ArbFloat to store matrix elements
  A: array [1..2, 1..3] of Arbfloat = ((1, 2, 3),
                                       (4, 5, 6));
  b: array [1..3] of ArbFloat = (1, 2, 3);
  C: array [1..2] of ArbFloat;
  // Rows (m) and columns (n)
  m, n: integer;
  // Loop variables for rows and columns
  i, j: integer;

begin

  // Define dimensions of the matrix
  m := High(A);      // Number of rows
  n := High(A[1]);   // Number of columns

  WriteLn('Demo of matrix vector multiplication; C = A b');
  WriteLn;


  // Print matrix A ------
  WriteLn('Matrix A = ');
  for i := 1 to m do
  begin
    for j := 1 to n do
    begin
      Write(A[i, j]: 4: 1); // Print element
    end;
    WriteLn;
  end;
  WriteLn;

  // Print vector b ------
  WriteLn('Vector b =');
  for i := Low(b) to High(b) do
    WriteLn(b[i]: 4: 1);
  WriteLn;

  // Calculate product C = A b ------
  omvmmv(
    A[1, 1], m, n, n,
    b[1],
    c[1]
    );

  // Print vector C ------
  WriteLn('C = A b');
  WriteLn('Vector C = ');
  for i := 1 to m do
    WriteLn(C[i]: 4: 1);
  WriteLn;

  WriteLn('Press enter key to exit');
  ReadLn; // Wait for user input before closing
end.
