program AnonymousFuncGradeCalculator;

{$mode objfpc}{$H+}{$J-}
{$modeswitch anonymousfunctions}  // Enable anonymous functions

var
  calculateGrade: function(score: integer): string;

begin
  // Assigning an anonymous function to the 'CalculateGrade' variable
  calculateGrade := function(score: integer): string
  begin
    if score >= 85 then
      Result := 'HD'
    else if score >= 75 then
      Result := 'D'
    else if score >= 65 then
      Result := 'C'
    else if score >= 50 then
      Result := 'P'
    else
      Result := 'F';
  end;

  // Using the anonymous function to calculate grades
  Writeln('Grade for score 90: ', CalculateGrade(90));
  Writeln('Grade for score 70: ', CalculateGrade(70));
  Writeln('Grade for score 40: ', CalculateGrade(40));

  // Pause the console to view the output
  WriteLn('Press Enter to quit');
  ReadLn;
end.
