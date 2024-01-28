program DateTimeExample;

uses
  SysUtils;

var
  currDateTime: TDateTime;

begin

  // Get a timestamp; date and time
  currDateTime := Now;

  // Display current date only with the default formatting
  WriteLn('Current date: ', DateToStr(currDateTime));

  // Display current time only with the default formatting
  Writeln('Current time: ', TimeToStr(currDateTime));

  // Display current timestamp with the default formatting
  Writeln('Now is (default format): ', DateTimeToStr(currDateTime));

  // Display timestamp with custom formattings
  Writeln('Now is (custom format) : ',
    FormatDateTime('yyyy-mm-dd hh:nn:ss.z', currDateTime));
  Writeln('Now is (custom format) : ',
    FormatDateTime('dd-mmm-yy hh:nn AM/PM', currDateTime));

  // Display timestamp in long format -- Tuesday, 9 January 2024 12:08:17 PM
  Writeln('Now is (custom format) : ',
    FormatDateTime('dddddd tt', currDateTime));

  // Pause console
  ReadLn;
end.
