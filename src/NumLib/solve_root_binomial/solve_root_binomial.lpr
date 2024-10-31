program solve_root_binomial;

{$mode objfpc}{$H+}{$J-}

uses
  SysUtils, typ, roo;

const
  n = 4;

var
  z: array[1..n] of complex;
  term: ArbInt;
  i: Integer;
  a: complex;
  c: complex;

  function ComplexToStr(z: complex; Decimals: Integer): string;
  const
    SIGN: array[boolean] of string = ('+', '-');
  begin
    Result := Format('%.*g %s %.*g i', [Decimals, z.re, SIGN[z.im < 0], Decimals, abs(z.im)]);
  end;

begin
  // Prepare constant term as a complex value
  a.Init(-1, 0);

  // Solve equation
  roobin(n, a, z[1], term);

  if term = 1 then begin
    // Display results
    WriteLn('Results of procedure roobin:');
    for i:=1 to n do
      WriteLn('  Solution #', i, ': ', ComplexToStr(z[i], 6):20);
    WriteLn;

    // Display expected results
    Writeln('Expected results:');
    c.Init(1, 1);
    c.Scale(0.5*sqrt(2));
    WriteLn('  Solution #1: ', complexToStr(c, 6):20);
    c.Init(1, -1);
    c.Scale(0.5*sqrt(2));
    WriteLn('  Solution #2: ', complexToStr(c, 6):20);
    c.Init(-1, 1);
    c.Scale(0.5*sqrt(2));
    WriteLn('  Solution #3: ', complexToStr(c, 6):20);
    c.Init(-1, -1);
    c.Scale(0.5*sqrt(2));
    WriteLn('  Solution #4: ', complexToStr(c, 6):20);
  end else
    WriteLn('ERROR');

  // Pause to allow user to see results before exiting the program
  WriteLn('Press enter to quit');
  ReadLn;
end.

