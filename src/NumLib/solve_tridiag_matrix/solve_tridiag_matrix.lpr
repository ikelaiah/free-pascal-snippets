program solve_tridiag_matrix;

{$mode objfpc}{$H+}{$J-}

uses
  typ, sle;

const
  n = 8;

var
  u_super_diag_items: array[1..n-1] of ArbFloat = (-100, -100, -100, -100, -100, -100, -100      );
  d_diag_items      : array[1..n]   of ArbFloat = ( 188,  188,  188,  188,  188,  188,  188,  188);
  l_sub_diag_items  : array[1..n-1] of ArbFloat = (      -100, -100, -100, -100, -100, -100, -100);
  vec_b             : array[1..n]   of ArbFloat = (  88,  -12,  -12,  -12,  -12,  -12,  -12,   88);
  soln_vec_x: array[1..n] of ArbFloat;
  ca: ArbFloat;
  i, term: integer;
  vec_b_test: array[1..n] of ArbFloat;

begin
  WriteLn('Solve tridiagonal matrix system A x = b');
  WriteLn;

  Write('Superdiagonal of A:':25);
  for i := 1 to n-1 do
    Write(u_super_diag_items[i]:10:0);
  WriteLn;

  Write('Main diagonal of A:':25);
  for i:= 1 to n do
    Write(d_diag_items[i]:10:0);
  WriteLn;

  Write('Subdiagonal of A:':25);
  Write('':10);
  for i:=2 to n do
    Write(l_sub_diag_items[i]:10:0);
  WriteLn;

  Write('Vector b:':25);
  for i:=1 to n do
    Write(vec_b[i]:10:0);
  WriteLn;

  // Solve for vector x
  slegtr(n, l_sub_diag_items[2], d_diag_items[1], u_super_diag_items[1], vec_b[1], soln_vec_x[1], ca, term);
  // Alternatively,
  // sledtr(n, l_sub_diag_items[2], d_diag_items[1], u_super_diag_items[1], vec_b[1], soln_vec_x[1], term);


  if term = 1 then begin
    Write('Solution vector x:':25);
    for i:= 1 to n do
      Write(soln_vec_x[i]:10:0);
    WriteLn;

    // Multiply A with soln_vec_x to test the result
    // NumLib does not have a routine to multiply a tridiagonal matrix with a
    // vector... Let's do it manually.
    vec_b_test[1] := d_diag_items[1]*soln_vec_x[1] + u_super_diag_items[1]*soln_vec_x[2];
    for i := 2 to n-1 do
      vec_b_test[i] := l_sub_diag_items[i]*soln_vec_x[i-1] + d_diag_items[i]*soln_vec_x[i] + u_super_diag_items[i]*soln_vec_x[i+1];
    vec_b_test[n] := l_sub_diag_items[n]*soln_vec_x[n-1] + d_diag_items[n]*soln_vec_x[n];

    Write('Check b = A x:':25);
    for i:= 1 to n do
      Write(vec_b_test[i]:10:0);
    WriteLn;
  end
  else
    WriteLn('Error');

  // Pause Console
  WriteLn('Press enter to quit');
  ReadLn;
end.
