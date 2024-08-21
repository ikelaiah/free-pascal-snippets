program GenericClassExample;

{$mode objfpc}{$H+}{$J-}

type
  // Define a generic class TSimpleCalculator
  generic TSimpleCalculator<T> = class
  public
    function Add(A, B: T): T;
    function Subtract(A, B: T): T;
  end;

  function TSimpleCalculator.Add(A, B: T): T;
  begin
    Result := A + B;
  end;

  function TSimpleCalculator.Subtract(A, B: T): T;
  begin
    Result := A - B;
  end;

type
  // Define specific calculator types based on the generic class
  TIntCalculator = specialize TSimpleCalculator<integer>;
  TRealCalculator = specialize TSimpleCalculator<double>;

var
  intCalc: TIntCalculator;
  floatCalc: TRealCalculator;

// Main block
begin
  // Create a calculator for integers
  intCalc := TIntCalculator.Create;
  Writeln('Integer Calculator:');
  Writeln('5 + 3 = ', intCalc.Add(5, 3));
  Writeln('5 - 3 = ', intCalc.Subtract(5, 3));

  // Create a calculator for floating-point numbers
  floatCalc := TRealCalculator.Create;
  Writeln('Float Calculator:');
  Writeln('5.5 + 3.2 = ', floatCalc.Add(5.5, 3.2): 0: 2);
  Writeln('5.5 - 3.2 = ', floatCalc.Subtract(5.5, 3.2): 0: 2);

  // Free the calculators
  intCalc.Free;
  floatCalc.Free;

  // Pause console
  WriteLn('Press Enter to quit');
  ReadLn;
end.
