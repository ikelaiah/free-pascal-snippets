program ExampleProcedureWithParams;

procedure Greet(name: string);
begin
  writeln('Hello, ', name, '!');
end;

begin
  Greet('Alice'); // Calling the procedure with arguments
end.
