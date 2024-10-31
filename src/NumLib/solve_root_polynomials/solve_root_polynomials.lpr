program solve_root_polynomials;

{$mode objfpc}{$H+}{$J-}

uses
  SysUtils, typ, roo;

const
  n = 5;

var
  a: array[1..n] of ArbFloat = (3, 4, -8, 0, 0);
  z: array[1..n] of complex;
  k: ArbInt;
  term: ArbInt;
  i: integer;
  c: complex;

  function ComplexToStr(z: complex; Decimals: integer): string;
  const
    SIGN: array[boolean] of string = ('+', '-');
  begin
    Result := Format('%.*f %s %.*f i', [Decimals, z.re, SIGN[z.im <0], Decimals, abs(z.im)]);
  end;

begin
  // Solve equation
  roopol(a[1], n, z[1], k, term);

  if term = 1 then begin
    // Display results
    WriteLn('Results of procedure roopol:');
    for i:=1 to n do
      WriteLn('  Solution #', i, ': ', ComplexToStr(z[i], 6):20);
    WriteLn;

    // Display expected results
    Writeln('Expected results:');
    c.Init(0, 0);  // z1 = 0
    WriteLn('  Solution #1: ', complexToStr(c, 6):20);
    c.Init(0, 0);  // z2 = 0
    WriteLn('  Solution #2: ', complexToStr(c, 6):20);
    c.Init(1, 0);  // z3 = 1
    WriteLn('  Solution #3: ', complexToStr(c, 6):20);
    c.Init(-2, +2);  // z4 = -2 + 2 i
    WriteLn('  Solution #4: ', complexToStr(c, 6):20);
    c.Init(-2, -2);  // z4 = -2 - 2 i
    WriteLn('  Solution #5: ', complexToStr(c, 6):20);
  end else
    WriteLn('ERROR');

  // Pause to allow user to see results before exiting the program
  WriteLn('Press enter to quit');
  ReadLn;
end.

