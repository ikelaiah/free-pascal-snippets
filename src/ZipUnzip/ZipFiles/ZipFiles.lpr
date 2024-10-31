program ZipFiles;

{$mode objfpc}{$H+}{$J-}

uses
  zipper;

var
  zip: TZipper;

begin
  zip := TZipper.Create;
  try
    zip.FileName := 'simple.zip';
    zip.Entries.AddFileEntry('file1.txt');
    zip.Entries.AddFileEntry('file2.txt');
    zip.ZipAllFiles;
  finally
    zip.Free;
  end;
  WriteLn('File zipped successfully.');
end.

