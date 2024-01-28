program ParamModifierConst;

function CalcAreaCircle(const radius: Real): Real;
begin

  // Argument 'radius' has a const modifier.
  // So, it is not possible to re-assign it another value.
  // Uncommenting the following line may lead to a compile error.
  // radius:=radius*2;
  Result:= Pi * radius * radius;
end;

var
  myRadius:Real = 3.0;
  area:Real = 0.0;

begin
  area := CalcAreaCircle(myRadius);
  WriteLn('The radius is ', myRadius:0:2);
  WriteLn('The area of the circle is ', area:0:2);
  ReadLn;
end.
