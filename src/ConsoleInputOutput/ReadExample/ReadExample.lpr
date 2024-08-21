program ReadExample;

  {$mode objfpc}{$H+}{$J-}

var
  num1, num2: integer;
begin
  { Using Read -- The next value read will be num 2. }
  Write('Enter two numbers: ');
  Read(num1);
  Read(num2);
  WriteLn('You entered: ', num1, ' and ', num2);

  { Using ReadLn -- The next value after a new line will be num 2. }
  Write('Enter two numbers on separate lines: ');
  ReadLn(num1);
  ReadLn(num2);
  WriteLn('You entered: ', num1, ' and ', num2);

  // Pause console
  ReadLn;
end.
