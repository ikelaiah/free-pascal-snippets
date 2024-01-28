program CLSimple;

var
  i: integer;

begin
  WriteLn('Number of command line arguments: ', ParamCount);

    // Display all command line arguments
  for i := 0 to ParamCount do
    WriteLn('Argument ', i, ': ', ParamStr(i));
end.
