program ListAllFiles;

{$mode objfpc}{$H+}{$J-}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes,
  FileUtil, // Add LazUtils in Project Inspector -> Required Packages first
  SysUtils;

var
  searchResults: TStringList;
  path: string = './sub-folder/';
  criteria: string = '*.csv;*.xlsx';
  isRecursive: boolean = True;
  item: string;

begin

  // Call FindAllFiles, no need to create TStringList manually
  searchResults := FindAllFiles(path, criteria, isRecursive);
  try
    // Print number of files found
    WriteLn(Format('Found %d files', [searchResults.Count]));

    // Display results, if any
    if searchResults.Count > 0 then
      for item in searchResults do WriteLn(item);

  finally
    // Free the TStringList
    searchResults.Free;
  end;

  // Pause console
  WriteLn;
  WriteLn('Press Enter key to exit ...');
  ReadLn;
end.
