program CollectFilePaths;

{$mode objfpc}{$H+}{$J-}

// Usage: CollectFIlePaths <file|directory> [file|directory] ...

uses
  SysUtils, Generics.Collections;

type
  TFilePathList = specialize TList<string>;

procedure CollectFilesFromDirectory(const BaseDir: string; Files: TFilePathList);
var
  searchRec: TSearchRec;
  findResult: Integer;
  fullPath: string;
begin
  fullPath := IncludeTrailingPathDelimiter(BaseDir);

  findResult := FindFirst(fullPath + '*.*', faAnyFile, searchRec);
  try
    while findResult = 0 do
    begin
      if (searchRec.Name <> '.') and (searchRec.Name <> '..') then
      begin
        if (searchRec.Attr and faDirectory) = faDirectory then
        begin
          // For directories, recurse
          CollectFilesFromDirectory(fullPath + searchRec.Name, Files);
        end
        else
        begin
          // For files, add full path
          Files.Add(fullPath + searchRec.Name);
        end;
      end;
      findResult := FindNext(searchRec);
    end;
  finally
    FindClose(searchRec);
  end;
end;

var
  filePaths: TFilePathList;
  index: integer;
  path: string;

// Main Block
begin
  filePaths := TFilePathList.Create;
  try
    // Check if we have any command line parameters
    if ParamCount < 1 then
    begin
      WriteLn('Usage: ', ExtractFileName(ParamStr(0)), ' <file|directory> [file|directory] ...');
      Exit;
    end;

    // Process each parameter
    for index := 1 to ParamCount do
    begin
      path := ParamStr(index);

      if not FileExists(path) and not DirectoryExists(path) then
      begin
        WriteLn('Warning: ''', path, ''' does not exist. Skipping...');
        Continue;
      end;

      if DirectoryExists(path) then
      begin
        // If it's a directory, collect all files recursively
        CollectFilesFromDirectory(path, filePaths);
      end
      else
      begin
        // If it's a file, add directly to list
        filePaths.Add(ExtractFileName(path));
      end;
    end;

    // Display all collected paths
    WriteLn('Collected paths:');
    WriteLn('---------------');
    for path in filePaths do
      WriteLn(path);

    WriteLn;
    WriteLn('Total files found: ', filePaths.Count);

  finally
    filePaths.Free;
  end;
end.
