program ParamModifierVar;

uses
  sysutils;

// The procedure gets a pointer to the variable that was passed,
// and uses this pointer to access the variable’s value.
procedure AddFour(var input: integer);
begin
  input := input + 4; // this line modifies the original value of passed variable
end;

var
  myNumber: Integer = 10;

begin
  WriteLn('myNumber is ... ', myNumber); // the value will be 10
  AddFour(myNumber);                     // call the procedure
  WriteLn('myNumber is ... ', myNumber); // the value of myNumber will be 14
  ReadLn;
end.
