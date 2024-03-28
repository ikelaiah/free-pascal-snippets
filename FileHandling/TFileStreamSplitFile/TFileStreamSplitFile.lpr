program TFileStreamSplitFile;

{
 This program splits a text file based on a chunkSize.
 The algorithm ensures it won't split the text in the middle of a line/paragraph.

 1. Open the file and allocate memory bufers for reading chunks of data.

 2. Read the file in chunks and parse the data until we reach to last `\n` character in the chunk.
    Once it locates the last `\n` in the chunk, move the file pointer back to include
    that byte and any preceding bytes of the partial line in the next chunk's read operation.

 3. Repeat - read and parse the remainder.

 4. Once parsing is complete, close the file and free any allocated memory (to prevent memory leaks).
}


{$mode objfpc}{$H+}{$J-}

uses
  {$IFDEF UNIX}
  cmem, cthreads,
  {$ENDIF}
  SysUtils,
  Classes,
  bufstream;

  procedure SaveChunkToFile(const filename: string; const chunkData: pansichar;
  const dataSize: integer; const chunkIndex: integer);
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

const
  defaultChunkSize: integer = 1048576; // 1 MB in bytes

var
  fileStream: TFileStream;
  buffer: pansichar;
  bytesRead, totalBytesRead, chunkSize, lineBreakPos, chunkIndex: int64;

begin

  if not FileExists(ParamStr(1)) then
  begin
    WriteLn('Please spefcify a valid text file.');
    Exit;
  end;

  chunkSize := defaultChunkSize * 1;

  // Open the file for reading
  fileStream := TFileStream.Create(ParamStr(1), fmOpenRead);
  try
    // Allocate memory buffer for reading chunks
    // Ref: https://www.freepascal.org/docs-html/rtl/system/getmem.html
    GetMem(buffer, chunkSize);
    try
      totalBytesRead := 0;
      chunkIndex := 0;

      // Read and parse chunks of data until EOF
      while totalBytesRead < fileStream.Size do
      begin
        bytesRead := fileStream.Read(buffer^, chunkSize);
        Inc(totalBytesRead, bytesRead);

        // Find the position of the last newline character in the chunk
        lineBreakPos := BytesRead;
        while (lineBreakPos > 0) and (Buffer[lineBreakPos - 1] <> #10) do
          Dec(lineBreakPos);

        { Now, must ensure that if the last byte read in the current chunk
          is not a newline character, the file pointer is moved back to include
          that byte and any preceding bytes of the partial line in the next
          chunk's read operation.

          Also, no need to update the BytesRead variable in this context because
          it represents the actual number of bytes read from the file, including
          any partial line that may have been included due to moving the file
          pointer back.
          Ref: https://www.freepascal.org/docs-html/rtl/classes/tstream.seek.html}
        if lineBreakPos < bytesRead then
          fileStream.Seek(-(bytesRead - lineBreakPos), soCurrent);

        // Write the chunk data to a file using the separate procedure
        SaveChunkToFile('output', buffer, lineBreakPos, chunkIndex);

        // Display user feedback
        WriteLn('Chunk ', chunkIndex, ', Total bytes read:', IntToStr(totalBytesRead));

        // Increase chunk index - a counter
        Inc(chunkIndex);
      end;
    finally
      // Free the memory buffer
      FreeMem(buffer);
    end;
  finally
    // Close the file
    fileStream.Free;
  end;
end.
