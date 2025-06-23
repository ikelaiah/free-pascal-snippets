program Loops;

  {$mode objfpc}{$H+}{$J-}

var
  intArray: array [0..2] of integer = (10, 20, 30);
  strArray: array of string = ('Apple', 'Banana', 'Cirtus');
  i, j: integer; // vars for iteration
  item: string; // var for iterating a collection of string
  c: char = char(0);
begin

  // 1a. For Loop -------------------------------
  for i := 0 to 2 do
  begin
    WriteLn('For Loop: Value of i is ', intArray[i]);
  end;

  WriteLn('--------------------');

  // 1b. For Loop using low & high --------------
  for i := low(intArray) to high(intArray) do
  begin
    WriteLn('For Loop with low & high: ', intArray[i]);
  end;

  WriteLn('--------------------');

  // 1c. For Loop with downto -------------------
  for i := 10 downto 1 do
  begin
    WriteLn('For Loop with downto: Value of i is ', i);
  end;

  WriteLn('--------------------');

  //2a. For-In Loop -----------------------------
  for i in intArray do
  begin
    WriteLn('For-In Loop - integer: ', i);
  end;

  //2b. For-In Loop -----------------------------
  for item in strArray do
  begin
    WriteLn('For-In Loop - string: ', item);
  end;

  WriteLn('--------------------');

  // 3. While Loop ------------------------------
  j := 0;
  while j <= 5 do
  begin
    WriteLn('While Loop from 0 until 5: ', j);
    Inc(j);
  end;

  WriteLn('--------------------');

  // 4. Repeat Until Loop -----------------------
  repeat
    Write('Repeat Until Loop: What is the next letter after ''a''? ');
    ReadLn(c);
  until c = 'b';
  WriteLn('Yes, b is the correct answer');

  WriteLn('--------------------');

  // 5. An example of a Nested Loops
  for item in strArray do
    for i := low(intArray) to high(intArray) do
    begin
      Writeln('Nested Loops: For ', item, ', You can buy in pack of ', intArray[i]);
    end;

  WriteLn('--------------------');

  // Pause console
  ReadLn;
end.
