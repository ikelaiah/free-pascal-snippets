program ZipEx03;

{$mode objfpc}{$H+}{$J-}

// Usage:
// ZipEx03 output_zip.zip input_file1.txt input_file2.txt

uses
  Zipper;

  // A function that takes 2 arguments.
  // The first, the name of the zip file to be created.
  // The second, an array of file names to be zipped.
  procedure ZipFiles(const zipFilename: string; const FilesToZip: array of string);
  var
    zip: TZipper;
    index: integer;
  begin
    zip := TZipper.Create;
    try
      zip.FileName := zipFilename;
      for index := 0 to high(FilesToZip) do
      begin
        zip.Entries.AddFileEntry(FilesToZip[index], FilesToZip[index]);
      end;
      zip.ZipAllFiles;
    finally
      WriteLn('Success! ', zipFilename, ' has been created!');
      zip.Free;
    end;
  end;

var
  fileIndex, noFiles: integer;
  filesToZip: array of string;

  // Main block
begin

  // Check if user specified input files
  noFiles := ParamCount - 1;
  if noFiles < 1 then
  begin
    WriteLn('It seems you did not specify input file(s). Please try again.');
    Halt(0);
  end;

  // Build array of input file names
  SetLength(filesToZip, noFiles);
  for fileIndex := 2 to ParamCount do
    filesToZip[fileIndex - 2] := ParamStr(fileIndex);

  // Optional -- Display info to user
  WriteLn('Output file name: ', ParamStr(1));
  WriteLn('No of files for zipping: ', noFiles);
  for fileIndex := 0 to high(filesToZip) do
    WriteLn(' - ', filesToZip[fileIndex]);

  // Now, zip the files in the array
  ZipFiles(ParamStr(1), filesToZip);
end.
