program CLSimple;

var
  i: integer;

begin
  WriteLn('Number of command line arguments: ', ParamCount);

    // Display all command line arguments
  for i := 1 to ParamCount do
    WriteLn('Argument ', i, ': ', ParamStr(i));

  // Pause console
  ReadLn;
end.
