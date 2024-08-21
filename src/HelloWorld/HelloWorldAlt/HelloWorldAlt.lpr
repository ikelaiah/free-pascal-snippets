program HelloWorldAlt;

  // Here is an example using more readable complier directives
  {$mode objfpc}
  {$longStrings on}
  {$writeableConst off}

begin
  WriteLn('Hello World!');

  WriteLn('Press Enter key to exit');
  ReadLn;
end.
