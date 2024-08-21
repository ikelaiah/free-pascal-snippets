program BasicMathOperations;

{$mode objfpc}{$H+}{$J-}

uses
  Math; // Include the Math unit for Power and Logarithm functions

var
  a, b, intResult: integer;
  realResult: real;

begin
  // Assign values to variables
  a := 10;
  b := 3;

  // Addition
  intResult := a + b;
  WriteLn('Addition: ', a, ' + ', b, ' = ', intResult);

  // Subtraction
  intResult := a - b;
  WriteLn('Subtraction: ', a, ' - ', b, ' = ', intResult);

  // Multiplication
  intResult := a * b;
  WriteLn('Multiplication: ', a, ' * ', b, ' = ', intResult);

  // Power
  realResult := Power(a, b); // 'Power' is used to calculate a^b
  WriteLn('Power: ', a, ' ^ ', b, ' = ', realResult: 0: 0);

  // Division
  intResult := a div b; // 'div' is used for integer division
  WriteLn('Division: ', a, ' div ', b, ' = ', intResult);

  // Real (Float) Division
  realResult := a / b; // '/' is used for real division
  WriteLn('Real (Float) Division: ', a, ' / ', b, ' = ', realResult: 0: 6);

  // Logarithm with Arbitrary Base (LogN)
  realResult := LogN(b, a); // 'LogN' is used to calculate logarithm base b
  WriteLn('Logarithm Base ', b, ': LogN(', b, ', ', a, ') = ', realResult: 0: 6);

  // Modulus
  intResult := a mod b; // 'mod' is used to find the remainder
  WriteLn('Modulus: ', a, ' mod ', b, ' = ', intResult);

  // Pause console
  WriteLn('Press enter key to exit');
  ReadLn;
end.
