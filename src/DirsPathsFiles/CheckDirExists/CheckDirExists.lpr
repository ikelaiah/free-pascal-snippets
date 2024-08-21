program CheckDirExists;

{$mode objfpc}{$H+}{$J-}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes,
  SysUtils;

begin

  if (DirectoryExists('sub-folder/')) then
    WriteLn('That folder exists!')
  else
    WriteLn('Can''t find it!');

  // Pause console
  ReadLn;

end.
