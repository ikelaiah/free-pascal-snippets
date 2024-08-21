program FindFirstSearchStoreArray;

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
  filesFound: array of string;
  fileCount: integer = 0;
  i: integer;

begin
  // Call FindFirst, append wildcard pattern to path
  if FindFirst(path + criteria, faAnyFile, searchRec) = 0 then
  begin
    repeat
      if (searchRec.Name <> '.') and (searchRec.Name <> '..') and (searchRec.Attr <> faDirectory) then
      begin
        // Set length the array of string
        SetLength(filesFound, fileCount + 1);
        // Add file name from searchRec into this array
        filesFound[fileCount] := searchRec.Name;
        // Increment file counter
        Inc(fileCount);
      end;
    until FindNext(searchRec) <> 0;
    // MUST RELEASE RESOURCES relating to FindFirst and FindNext
    FindClose(searchRec);
  end;

  // Display count of matching files
  WriteLn(Format('Found %d files matching %s', [Length(filesFound), criteria]));

  // Display all files
  for i := 0 to High(filesFound) do WriteLn(filesFound[i]);

  // Pause console
  WriteLn;
  WriteLn('Press Enter key to quit');
  ReadLn;
end.
