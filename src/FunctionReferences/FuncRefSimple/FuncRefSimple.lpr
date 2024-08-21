program FuncRefSimple;

{$mode objfpc}{$H+}{$J-}
{$modeswitch functionreferences}

type
  // Define a type for a function reference that take two doubles and return a double
  TMathOpFuncRef = reference to function(a, b: double): double;

  // Define a function that adds two doubles
  function Add(a, b: double): double;
  begin
    Result := a + b;
  end;

  // Define a function that multiplies two doubles
  function Multiply(a, b: double): double;
  begin
    Result := a * b;
  end;

var
  // A variable of type TMathOpFuncRef to hold function references
  mathOp: TMathOpFuncRef;
  num1, num2: double;

// Main block
begin
  num1 := 5;
  num2 := 3;

  // Assign the Add function to the mathOp function reference
  mathOp := @Add;
  WriteLn(num1:0:2, ' + ', num2:0:2, ' = ', mathOp(num1, num2):0:2);

  // Assign the Multiply function to the mathOp function reference
  mathOp := @Multiply;
  WriteLn(num1:0:2, ' * ', num2:0:2, ' = ', mathOp(num1, num2):0:2);

  // Pause console
  WriteLn('Press Enter to quit');
  ReadLn;
end.
