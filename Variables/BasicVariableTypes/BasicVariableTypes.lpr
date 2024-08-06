program BasicVariableTypes;

  {$mode objfpc}{$H+}{$J-}

var
  myChar: char;       // A single character, like 'A' or 'b'
  myString: string;   // A sequence of characters, like "Hello, world!"
  myInt: integer;     // A whole number, like 42 or -7
  myBool: boolean;    // A true or false value
  myReal: real;       // A number with decimals, like 3.14 or -0.5

begin
  // Assign values to the variables
  myChar := 'A';
  myString := 'Hello World!';
  myInt := 42;
  myBool := True;
  myReal := 1234.5678;

  // Print the values of the variables to the console
  Writeln('Character: ', myChar);
  Writeln('String: ', myString);
  Writeln('Integer: ', myInt);
  Writeln('Boolean: ', myBool);
  Writeln('Real: ', myReal:0:4);

  // Pause Console
  WriteLn('Press enter to quit');
  ReadLn;
end.
