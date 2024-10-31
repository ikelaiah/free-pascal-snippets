program integrate;

{$mode objfpc}{$H+}{$J-}

uses
  SysUtils, Math, typ, int;

// Function representing 1/x^2
function recipx2(x: ArbFloat): ArbFloat;
begin
  Result := 1.0 / sqr(x);
end;

// Analytic result of the integral
function integral_recipx2(a, b: ArbFloat): Arbfloat;
begin
  if a = 0 then
    a := Infinity
  else if a = Infinity then
    a := 0.0
  else
    a := -1 / a;

  if b = 0 then
    b := Infinity
  else if b = Infinity then
    b := 0.0
  else
    b := -1 / b;

  Result := b - a;
end;

// Execute the integration and handle the result
procedure Execute(a, b: ArbFloat);
var
  err: ArbFloat = 0.0;
  term: ArbInt = 0;
  integral: ArbFloat = 0.0;
begin
  try
    int1fr(@recipx2, a, b, 1e-9, integral, err, term);
  except
    term := 4;
  end;

  Write('  The integral from ' + FloatToStr(a) + ' to ' + FloatToStr(b));

  case term of
    1: WriteLn(' is ', integral:0:9, ', expected: ', integral_recipx2(a, b):0:9);
    2: WriteLn(' is ', integral:0:9, ', error: ', err:0:9, ', expected: ', integral_recipx2(a, b):0:9);
    3: WriteLn(' cannot be calculated: Invalid input.');
    4: WriteLn(' cannot be calculated: Divergence or slow convergence.');
  end;
end;

begin
  WriteLn('Integral of f(x) = 1/x^2');
  Execute(1.0, 2.0);
  Execute(1.0, 1.0);
  Execute(2.0, 1.0);
  Execute(1.0, Infinity);
  Execute(-Infinity, -1.0);
  Execute(0.0, Infinity);
  // Note: The following case will raise an exception in some environments, but works outside the IDE.
  // Execute(-1.0, Infinity);

  // Pause to allow user to see results before exiting the program
  WriteLn('Press enter to quit');
  ReadLn;
end.
