program RandomRealNumberBetween;

function RandomNumberBetween(const min, max: real): real;
begin
  Result := Random * (max - min) + min;
end;

var
  randomRealNumber: real;
  min, max: real;

begin
  min := 1.0;
  max := 10.0;

  // Initialise random number generator
  Randomize;

  // Get a random (real) number between min and max
  randomRealNumber := RandomNumberBetween(min, max);

  writeln('Random real number between ', min: 0: 6, ' and ', max: 0: 6, ' is: ', randomRealNumber: 0: 6);

  // Pause console
  ReadLn;
end.
