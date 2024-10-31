program ZipEx02;

{$mode objfpc}{$H+}{$J-}

// Usage:
// ZipEx02 newzip.zip file1.txt file2.txt

uses
  Zipper;

var
  zip: TZipper;
  index: integer;

begin
  zip := TZipper.Create;
  try
    // Define the file name of the zip file to be created
    zip.FileName := ParamStr(1);
    for index := 2 to ParamCount do
      // First argument: the names of the files to be included in the zip
      // Second argument: the name of the file as it appears in the zip and
      // later in the file system after unzipping
      zip.Entries.AddFileEntry(ParamStr(index), ParamStr(index));
    // Execute the zipping operation and write the zip file.
    zip.ZipAllFiles;
  finally
    zip.Free;
  end;
end.

