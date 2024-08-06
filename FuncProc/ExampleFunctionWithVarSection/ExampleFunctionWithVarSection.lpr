program ExampleFunctionWithVarSection;

  function Factorial(n: integer): integer;
  var
    i, tempCalc: integer;
  begin
    tempCalc := 1;
    for i := 1 to n do
      tempCalc := tempCalc * i;
    Result := tempCalc;
  end;

begin
  WriteLn('Factorial of 5 is: ', Factorial(5));

  // Pause console
  ReadLn;
end.
