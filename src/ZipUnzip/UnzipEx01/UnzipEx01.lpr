program UnzipEx01;

{$mode objfpc}{$H+}{$J-}

uses
  zipper;

var
  unZip: TUnZipper;

begin
  unZip := TUnZipper.Create;
  try
    unZip.FileName := 'simple.zip';
    unZip.OutputPath := 'output_folder';
    unZip.UnZipAllFiles;
  finally
    unZip.Free;
  end;
  WriteLn('File unzipped successfully.');
end.


