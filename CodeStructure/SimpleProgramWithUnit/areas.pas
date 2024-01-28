unit Areas;

interface

function CalcAreaSquare(side: real): real;
function CalcAreaCircle(radius: real): real;

implementation

const
  shortPI: real = 3.14;

function CalcAreaSquare(side: real): real;
begin
  Result := side * side;
end;

function CalcAreaCircle(radius: real): real;
begin
  Result := shortPI * radius * radius;
end;

end.
