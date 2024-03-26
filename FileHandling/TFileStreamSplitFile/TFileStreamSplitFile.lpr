program TFileStreamSplitFile;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cmem, cthreads,
  {$ENDIF}
  SysUtils,
  Classes,
  bufstream;

  procedure SaveChunkToFile(const filename: string;
                            const chunkData: pansichar;
                            const dataSize: integer;
                            const chunkIndex: integer);
  var
    chunkFile: TFileStream;
  begin
    // Create a new file for the chunk
    chunkFile := TFileStream.Create(filename + '-chunk-' + IntToStr(ChunkIndex) +
      '.txt', fmCreate);
    try
      // Write the chunk data to the chunk file
      chunkFile.WriteBuffer(chunkData^, dataSize);
    finally
      chunkFile.Free;
    end;

  end;

var
  fileStream: TFileStream;
  buffer: pansichar;
  bytesRead, TotalBytesRead: int64;
  lineBreakPos: int64;
  chunkIndex: int64;
  chunkSize: int64 = 1073741824; // 1 GB in bytes
begin

  if Length(ParamStr(1)) < 4 then
  begin
    WriteLn('Please spefcify a valid text file.');
    Exit;
  end;

  // Open the file for reading
  FileStream := TFileStream.Create(ParamStr(1), fmOpenRead);
  try
    // Allocate memory buffer for reading chunks
    GetMem(Buffer, ChunkSize);
    try
      TotalBytesRead := 0;
      ChunkIndex := 0;

      // Read and parse chunks of data until EOF
      while TotalBytesRead < FileStream.Size do
      begin
        BytesRead := FileStream.Read(Buffer^, ChunkSize);
        Inc(TotalBytesRead, BytesRead);

        // Find the position of the last newline character in the chunk
        LineBreakPos := BytesRead;
        while (LineBreakPos > 0) and (Buffer[LineBreakPos - 1] <> #10) do
          Dec(LineBreakPos);

        // Write the chunk data to a file using the separate procedure
        SaveChunkToFile('output', buffer, lineBreakPos, chunkIndex);

        // Display user feedback
        WriteLn('Chunk ', ChunkIndex, ', Total bytes read:', IntToStr(totalBytesRead));

        // Increase chunk index - a counter
        Inc(chunkIndex);
      end;
    finally
      // Free the memory buffer
      FreeMem(buffer);
    end;
  finally
    // Close the file
    FileStream.Free;
  end;
end.
