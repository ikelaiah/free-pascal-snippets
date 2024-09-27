program omvinp_demo;

{$mode objfpc}{$H+}{$J-}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes,
  typ,
  omv;

var
  vector_a: array[1..5] of ArbFloat = (0, 1, 2, 2, -1);
  vector_b: array[1..5] of Arbfloat = (3, -1, -2, 2, -1);
  product_ab: ArbFloat;
  i: integer;

begin

  // Perform dot product
  product_ab := omvinp(vector_a[1], vector_b[1], high(vector_a));

  // Print vector vector_a
  Write('Vector a = [');
  for i := Low(vector_a) to High(vector_a) do
    Write(vector_a[i]: 4: 0);
  WriteLn('  ]');

  // Print vector vector_b
  Write('Vector b = [');
  for i := Low(vector_b) to High(vector_b) do
    Write(vector_b[i]: 4: 0);
  WriteLn('  ]');

  // Print vector_a . b
  Write('Dot product a . b = ');
  WriteLn(product_ab: 4: 0);

  WriteLn;
  WriteLn('Press enter key to quit');
  ReadLn;
end.
