program ExampleFunctionWithParams;

  function Add(a, b: integer): integer;
  begin
    Result := a + b; // Returning the product
  end;

begin
  WriteLn('3 + 5 = ', Add(3, 5));

  // Pause console
  ReadLn;
end.
