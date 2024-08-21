program ExampleFunctionWithoutParams;

function GetGreeting: string;
begin
  Result := 'Hello World!';
end;

begin
  WriteLn(GetGreeting);  // Calling the function and printing the result
end.

