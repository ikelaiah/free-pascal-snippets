program UnzipExample;

{$mode objfpc}{$H+}{$J-}

uses
  zipper;

var
  UnZipper: TUnZipper;

begin
  UnZipper := TUnZipper.Create;
  try
    UnZipper.FileName := 'simple.zip';
    UnZipper.OutputPath := 'output_folder';
    UnZipper.UnZipAllFiles;
  finally
    UnZipper.Free;
  end;
  WriteLn('File unzipped successfully.');
end.


