program ExampleProcedureWithVarSection;

procedure SwapNumbers(var x, y: integer);
var
  temp: integer;  // Local variable to help with swapping
begin
  temp := x;  // Store the value of x in temp
  x := y;     // Assign the value of y to x
  y := temp;  // Assign the value of temp (original x) to y
end;

var
  a, b: integer;

begin
  a := 10;
  b := 20;

  WriteLn('Before swapping: a = ', a, ', b = ', b);

  SwapNumbers(a, b);  // Call the procedure to swap the values

  WriteLn('After swapping: a = ', a, ', b = ', b);
end.
