program RandomNumberBetween;

function RandomBetween(const min, max: integer): integer;
begin
  Result:= Random(max - min + 1) + min;
end;

var
  randomNumber: integer;
  min, max: integer;

begin
  min := 1;
  max := 10;

  // Initialise the randeom number generator
  Randomize;

  randomNumber := RandomBetween(2, 10);

  WriteLn('Random number between ', min, ' and ', max, ' is: ', randomNumber);

  // Pause console
  ReadLn;
end.

