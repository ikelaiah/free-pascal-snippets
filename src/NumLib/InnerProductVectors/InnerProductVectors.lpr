program InnerProductVectors;

{$mode objfpc}{$H+}{$J-}

{
 An example of inner product of two vectors using omvinp in numlib.

 function omvinp(var a, b: ArbFloat; n: ArbInt): ArbFloat;

 - `a` and `b` are the first elements of 1-dimensional arrays representing
    the vectors a and b, respectively.
 - `n` defines the dimension of the vectors (count of array elements).
 -  Both vectors must have the same number of elements.
}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes,
  typ,
  omv;

var
  a: array[0..4] of ArbFloat = (0, 1, 2, 2, -1);
  b: array[0..4] of Arbfloat = (3, -1, -2, 2, -1);
  ab: ArbFloat;
  i: integer;

begin

  // Perform dot product
  ab := omvinp(a[0], b[0], high(a));

  // Print vector a
  Write('Vector a = [');
  for i := Low(a) to High(a) do
    Write(a[i]: 5: 0);
  WriteLn('  ]');

  // Print vector b
  Write('Vector b = [');
  for i := Low(b) to High(b) do
    Write(b[i]: 5: 0);
  WriteLn('  ]');

  // Print a . b
  Write('Dot product a . b = ');
  WriteLn(ab: 4: 0);

  WriteLn;
  WriteLn('Press enter key to quit');
  ReadLn;
end.
