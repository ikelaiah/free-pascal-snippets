program TCSVDocumentGetSpecificCols;


{
 An example of listing the content of first two columns in a CSV file
 using TCSVDocument.
}

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cmem, cthreads,
  {$ENDIF}
  Classes,
  SysUtils,
  csvdocument,
  streamex,
  bufstream;

  procedure ReadCSV(filename: string; delimiter: char);
  var
    fileStream: TFileStream;
    buffStream: TReadBufStream;
    csvReader: TCSVDocument;
    index, totalLines: int64;
  begin
    totalLines := 0;
    fileStream := TFileStream.Create(filename, fmOpenRead);
    try
      buffStream := TReadBufStream.Create(fileStream, 65536);
      try
        csvReader := TCSVDocument.Create;
        try
          // Assign a delimiter
          csvReader.Delimiter := delimiter;

          // Assign a source stream.
          csvReader.LoadFromStream(buffStream);

          // Get total lines for iteration.
          totalLines := csvReader.RowCount;

          // Print the values of first two columns from the CSV file.
          for index := 0 to totalLines-1 do
          begin
            WriteLn(Format('row %d: %s, %s', [(index + 1),
                                              csvReader.Cells[0, index],
                                              csvReader.Cells[1, index]]));
          end;

        finally
          csvReader.Free;
        end;
      finally
        buffStream.Free;
      end;
    finally
    end;
    fileStream.Free;
  end;

var
  filename: string;

begin
  filename := ParamStr(1);
  if not FileExists(filename) then
  begin
    WriteLn('Cannot find file.');
    Exit;
  end;

  ReadCSV(filename, ';');
end.
