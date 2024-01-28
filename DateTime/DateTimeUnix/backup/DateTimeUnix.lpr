program DateTimeUnix;

uses
  SysUtils,
  DateUtils;

var
  unixTime:integer;

begin
  unixTime:=DateTimeToUnix(Now);
  Writeln('Current time in Unix epoch time is: ', unixTime);

  // Pause console;
  ReadLn;
end.
