program ParseDate;

uses
  SysUtils,
  DateUtils;

var
  dateString: string;
  parsedDate: TDateTime;

begin

  // date to parse
  dateString := '03-MAR-24';

  // default value of parsed date. If conversion fails, use this value
  parsedDate := Default(TDateTime);

  try
    parsedDate := ScanDateTime('dd?mmm?yy', dateString);
    // Now dateValue contains the parsed date, else ScanDateTime will raise an exception

    // Use FormatDateTime to format the parsed date as needed
    WriteLn('Parsed date                : ', DateToStr(parsedDate));
    WriteLn('Parsed date (custom format): ', FormatDateTime('dddddd tt', parsedDate));
    WriteLn('Parsed date (custom format): ', FormatDateTime('yyyy-mm-dd hh:nn:ss', parsedDate));
  except
    on E: EConvertError do
      WriteLn('Invalid date string');
  end;

  // Pause console
  Readln;
end.
