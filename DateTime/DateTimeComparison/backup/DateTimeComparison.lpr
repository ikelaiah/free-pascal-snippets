program DateTimeComparison;

uses
  SysUtils,
  DateUtils;

var
  surveyReleaseDate: TDateTime;

begin

  // Set survey release date
  surveyReleaseDate := StrToDate('15/12/2024');

  if surveyReleaseDate < Now then
  begin
    WriteLn('You can release survey results now');
    WriteLn('You''re behind by ', DaysBetween(Now, surveyReleaseDate), ' days.');
  end
  else
  begin
    WriteLn('You CANNOT release survey results now');
    WriteLn('You can release results in ', DaysBetween(Now, surveyReleaseDate), ' days.');
  end;

  // Pause console
  ReadLn;
end.
