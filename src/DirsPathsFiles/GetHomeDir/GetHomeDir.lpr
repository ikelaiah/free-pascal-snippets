program GetHomeDir;

{$mode objfpc}{$H+}{$J-}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes,
  SysUtils;

var
  homeDir: string;

begin

  // Get home dir
  homeDir := GetUserDir;

  WriteLn('THe home directory is ', homeDir);

  // Pause console
  WriteLn('Press enter to quit ...');
  ReadLn;
end.
