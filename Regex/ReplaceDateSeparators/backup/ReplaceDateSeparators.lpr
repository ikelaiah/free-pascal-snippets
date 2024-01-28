program ReplaceDateSeparators;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes,
  RegExpr,
  SysUtils;

  function ReplaceDateSeparatorWithQMark(dateString: string): string;
  var
    re: TRegExpr;
  begin
    re := TRegExpr.Create;
    try
      // A regex to capture common date formats: dd.mm.yyyy, yyyy.mm.dd, dd.mmm.yy
      re.Expression := '(\d{1,4})[-/.](\d{1,2}|[a-zA-Z]{3,})[-/.](\d{1,4})';

      // Next line does 3 tasks.
      // 1. Capture date, month and year groups
      // 2. Construct a date string and using `?` as separators
      // 3. And return the result to function caller
      Result := re.Replace(dateString, '$1?$2?$3', True);
    finally
      re.Free;
    end;
  end;

var
  dateInput1: string = '24-Mar-24';
  dateInput2: string = '24/03/24';
  dateInput3: string = '2024/03/24';

begin
  try
    WriteLn(ReplaceDateSeparatorWithQMark(dateInput1));
    WriteLn(ReplaceDateSeparatorWithQMark(dateInput2));
    WriteLn(ReplaceDateSeparatorWithQMark(dateInput3));
  except
    on E: Exception do
      writeln('Error: ' + E.Message);
  end;
  // Pause Console
  ReadLn;

end.
