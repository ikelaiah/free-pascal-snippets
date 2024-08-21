program GenericFunctionExample;

{$mode objfpc}{$H+}{$J-}

generic function DoubleValue<T>(AValue: T): T;
begin
  Result := AValue + AValue;
end;

var
  resultInt: integer;
  resultReal: real;

// Main block
begin
  resultInt := specialize DoubleValue<integer>(8);
  Writeln('resultInt:  ', resultInt);         // Output: resultInt: 64

  resultReal := specialize DoubleValue<real>(-1.2);
  Writeln('resultReal: ', resultReal: 0: 2); // Output: resultReal: -2.40

  // Pause console
  WriteLn('Press Enter to quit');
  ReadLn;
end.
