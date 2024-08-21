program FuncRefCalculatorExample;

{$mode objfpc}{$H+}{$J-}
{$modeswitch functionreferences}

uses
  SysUtils;

type
  // Define a type represents a reference to a function
  // that takes two doubles and returns a double
  TMathOperation = reference to function(a, b: double): double;

  // Define basic math operations
  function Add(a, b: double): double;
  begin
    // Return the sum of a and b
    Result := a + b;
  end;

  function Subtract(a, b: double): double;
  begin
    // Return the difference of a and b
    Result := a - b;
  end;

  function Multiply(a, b: double): double;
  begin
    // Return the product of a and b
    Result := a * b;
  end;

  function Divide(a, b: double): double;
  begin
    try
      // Return the quotient of a and b
      Result := a / b
    except
      on E: Exception do
        WriteLn('Error: ' + E.Message);
    end;
  end;

  // Procedure to perform a math operation
  // Takes a math operation and two operands as arguments
  procedure Calculate(mathOp: TMathOperation; a, b: double);
  begin
    WriteLn(mathOp(a, b): 0: 2);
  end;

// Main block
begin
  Calculate(@Add, 10, 5);      // Outputs: 15.00
  Calculate(@Subtract, 10, 5); // Outputs: 5.00
  Calculate(@Multiply, 10, 5); // Outputs: 50.00
  Calculate(@Divide, 10, 5);   // Outputs: 2.00

  // Pause console
  WriteLn('Press Enter to quit');
  ReadLn;
end.
