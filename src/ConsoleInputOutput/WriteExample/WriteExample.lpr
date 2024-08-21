program WriteExample;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes;

begin
  { Using Write, World! appears after Hello. }
  Write('Hello '); // There is no new line at the end of the string.
  Write('World!'); // There is no new line at the end of the string.

  // A spacer
  WriteLn;

  { Using WriteLn, World! appears underneath Hello. }
  WriteLn('Hello '); // There is a new line at the end of the string.
  WriteLn('World!'); // There is a new line at the end of the string.

  // Pause console
  ReadLn;
end.
