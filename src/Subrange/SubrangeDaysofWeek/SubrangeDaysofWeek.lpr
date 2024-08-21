program SubrangeDaysofWeek;

  {$mode objfpc}{$H+}{$J-}

type
  // Define a subrange type for days of the week (1 = Sunday, 7 = Saturday)
  TDayOfWeek = 1..7;

var
  // Declare a variable of type TDayOfWeek
  day: TDayOfWeek;

  { Main Block }
begin
  // Assign a valid value within the subrange to the variable
  day := 3;  // 3 represents Tuesday
  WriteLn('Day of the week is: ', day);

  // Uncommenting the following line would cause a compile-time error
  // because 8 is not within the defined subrange
  // day := 8;  // This will cause a compile-time error

  // Pause console
  WriteLn('Press enter key to quit');
  ReadLn;
end.
