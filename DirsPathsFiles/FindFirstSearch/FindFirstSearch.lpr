program FindFirstSearch;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes,
  SysUtils;

var
  searchRec: TSearchRec;

  path: string = './sub-folder/';
  criteria: string = '*.csv';
  Count: integer = 0; // Optional, only if you need a count

begin

  // Call FindFirst, requires 3 arguments
  if FindFirst(path + criteria, faAnyFile, searchRec) = 0 then
  begin
    repeat
      if (searchRec.Name <> '.') and (searchRec.Name <> '..') and (searchRec.Attr <> faDirectory) then
      begin
        // Optional, only if you need a count -- increase a counter
        Inc(Count);
        // Display files found by FindFirst
        WriteLn(searchRec.Name);
      end;
    until FindNext(searchRec) <> 0;

    // A successful FindFirst call must always be followed by a FindClose call
    // with the same TSearchRec record. Failure to do so will result in memory leaks.
    // If the findfirst call failed (i.e. returned a nonzero handle) there is
    // no need to call FindClose.
    // See https://www.freepascal.org/docs-html/3.2.2/rtl/sysutils/findfirst.html
    FindClose(searchRec);
  end;

  // Display count of matching files
  WriteLn(Format('Found %d files matching %s', [Count, criteria]));

  // Pause console
  WriteLn;
  WriteLn('Press Enter key to quit');
  ReadLn;
end.
