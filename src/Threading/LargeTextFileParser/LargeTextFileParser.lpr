program LargeTextFileParser;

{
 Description

 This program is a simple example of parsing of a text file using N threads.
 The code reads and divides the text file into chunks and assigns these chunks
 to different threads, ensuring that no chunk splits a paragraph or sentence.

 Workflow

 1. File Reading      - Read the file in 12MB chunks.
 2. Data Integrity    - Ensure chunks do not split paragraphs or sentences by
                        adjusting the file pointer based on the last newline
                        character.
 3. Thread Management - Use up to N threads to process chunks in parallel.
 4. Display Output    - Print the size of each chunk and the first line of each chunk.
}

{$mode objfpc}{$H+}{$J-}

uses
  Classes,
  SysUtils,
  Math;

const
  MAX_THREADS = 8; // Max threads to use
  CHUNK_SIZE = 12 * 1024 * 1024; // Size of chunk for each thread to process (12MB)

type
  // The TThread class encapsulates the native thread support of the OS.
  TFileChunkProcessor = class(TThread)
  private
    FData: array of char; // Chunk of data to work with
    FDataSize: integer;   // Length of data to the nearest new line
  protected
    procedure Execute; override;
  public
    constructor Create(const AData: array of char; ADataSize: integer);
  end;

  constructor TFileChunkProcessor.Create(const AData: array of char; ADataSize: integer);
  begin
    // Call parent's constructor and don't start thread automatically
    inherited Create(True);

    // Assign a AData size to work with
    FDataSize := ADataSize;

    // Allocate memory for AData and copy it
    // Since Char in Free Pascal can be 1 or 2 bytes (depending on whether
    // it's an ANSI or Unicode character), using SizeOf(Char) ensures
    // the correct number of bytes are moved
    SetLength(FData, FDataSize);
    Move(AData[0], FData[0], FDataSize * SizeOf(char));

    // Do not free thread automatically when finished.
    FreeOnTerminate := False;
  end;

  procedure TFileChunkProcessor.Execute;
  var
    line: string;
    index: integer;
  begin
    // Example processing: print the chunk size and the first line
    line := '';
    for index := 0 to FDataSize - 1 do
    begin
      if FData[index] = #10 then
      begin
        Writeln('Processed chunk of size: ', FDataSize, ' bytes');
        Writeln('First line: ', line);
        Break;
      end
      else if FData[index] <> #13 then
      begin
        line := line + FData[index];
      end;
    end;
  end;

  {
   This routine reads a text file in chunks and processes each chunk using
   separate threads. It ensures each thread processes a chunk up to the
   nearest newline, without breaking a paragraph or sentence.
  }
  procedure ReadFileInChunks(const AFileName: string);
  var
    fStream: TFileStream;
    buffer: array of char;
    bufferSize: integer;
    index, lastNewLine: integer;
    threadList: array of TFileChunkProcessor;
    activeThreads: integer;
  begin
    fStream := TFileStream.Create(AFileName, fmOpenRead);
    try

      // Initialise variables for buffer, threads and threads counter.
      SetLength(buffer, CHUNK_SIZE);
      SetLength(threadList, MAX_THREADS);
      activeThreads := 0;

      // Read the file until the file pointer reaches the end of the file
      while fStream.Position < fStream.Size do
      begin
        // Determine the buffer size to read and ensuring that the buffer size
        // for reading does not exceed the size of the remaining data in the file.
        bufferSize := Min(CHUNK_SIZE, (fStream.Size - fStream.Position) div SizeOf(char));

        // Read data into buffer
        fStream.Read(buffer[0], bufferSize);

         // Find the index of the last newline character in the buffer
        lastNewLine := -1;
        for index := bufferSize - 1 downto 0 do
        begin
          if buffer[index] = #10 then
          begin
            lastNewLine := index;
            Break;
          end;
        end;

        if lastNewLine = -1 then
          lastNewLine := bufferSize - 1;

        // Create a thread to process the chunk and its size (index of \n + 1)
        threadList[activeThreads] := TFileChunkProcessor.Create(buffer, lastNewLine + 1);
        threadList[activeThreads].Start;

        {
          Next, adjust file position to the character after the last newline.

          ---
          Explanation
          ---

          Let's say we have a buffer size of 1000 characters, and the last
          newline character is found at index 950.
          The buffer contains 50 characters after the last newline.

          bufferSize  = 1000
          lastNewLine = 950
          bufferSize - lastNewLine - 1 = 1000 - 950 - 1 = 49
          Assuming SizeOf(Char) = 1 (for simplicity),

          ```pascal
          fStream.Position := fStream.Position - 49 * SizeOf(Char);
          ```

          This means the file position is moved back by 49 bytes, so the next
          read operation will start at the 951st character in the buffer,
          which is the character immediately following the last newline.
          This ensures that no line is split between two chunks and maintains
          the integrity of the data being processed.
        }
        fStream.Position := fStream.Position - (bufferSize - lastNewLine - 1) * SizeOf(char);

        // Increment active thread counter
        Inc(activeThreads);

        // If max threads are active, wait for them to finish
        if activeThreads = MAX_THREADS then
        begin
          for index := 0 to MAX_THREADS - 1 do
          begin
            threadList[index].WaitFor;
          end;
          activeThreads := 0;
        end;
      end; // -- End of the `while fStream.Position < fStream.Size do` loop.

      // Wait for any remaining threads to complete
      for index := 0 to activeThreads - 1 do
      begin
        threadList[index].WaitFor;
      end;

    finally
      fStream.Free; // Clean up the file stream
    end;
  end;

  // MAIN block ----------------------------------------------------------------
begin

  // Check if the input file exists
  if not FileExists(ParamStr(1)) then
  begin
    WriteLn('File not found. Does ', ParamStr(1), ' exist?');
    Exit;
  end;

  // Parse the text file using multi-threading
  try
    ReadFileInChunks(ParamStr(1));
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
