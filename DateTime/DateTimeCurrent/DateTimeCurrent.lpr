program DateTimeCurrent;

uses
  SysUtils;

begin

  // Display current date only with the default formatting
  WriteLn('Date: ', DateToStr(Now));

  // Display current time only with the default formatting
  Writeln('Time: ', TimeToStr(Now));

  // Display current timestamp with the default formatting
  Writeln('Now is (default format): ', DateTimeToStr(Now));

  // Display timestamp with custom formatting
  Writeln('Now is (custom format) : ',
          FormatDateTime('yyyy-mm-dd hh:nn:ss.z', Now));
  Writeln('Now is (custom format) : ',
          FormatDateTime('dd-mmm-yy hh:nn AM/PM', Now));

  // Display timestamp in long format -- Tuesday, 9 January 2024 12:08:17 PM
  Writeln('Now is (custom format) : ', FormatDateTime('dddddd tt', Now));

  // Pause console
  ReadLn;
end.
