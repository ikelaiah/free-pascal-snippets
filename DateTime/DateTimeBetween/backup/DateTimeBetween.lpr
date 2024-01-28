program DateTimeBetween;

uses
  SysUtils,
  DateUtils;

var
  diffSec, diffDay: integer;

begin

  // Seconds between 2 times

  diffSec := SecondsBetween(StrToTime('18:30'), StrToTime('07:35'));
  WriteLn('The seconds between 18:30 and 07:35 is: ', diffSec, ' seconds');

  // Days between 2 dates
  diffDay := DaysBetween(StrToDate('09/01/2024'), StrToDate('01/01/2015'));
  WriteLn('The days difference between 2024-01-05 and 2015-01-01 is: ', diffDay, ' days');

  // Seconds between 2 dates
  // Casting diffsec to float
  diffSec := SecondsBetween(StrToDate('09/01/2024'), StrToDate('01/01/2015'));
  WriteLn('The seconds between 2024-01-05 and 2015-01-01 is: ', Format('%n', [diffSec + 0.0]),' seconds');

  ReadLn;
end.
