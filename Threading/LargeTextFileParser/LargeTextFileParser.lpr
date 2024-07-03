program LargeTextFileParser;

{
 Description

 This program performs a simple parsing of a text file using N threads.
 The code reads and divides the text file into chunks and assigns these chunks
 to different threads, ensuring that no chunk splits a paragraph or sentence.

 Workflow

 1. File Reading - Read the file in 12MB chunks.
 2. Data Integrity - Ensure chunks do not split paragraphs or sentences by
                     adjusting the file pointer based on the last newline
                     character.
 3. Thread Management - Use up to N threads to process chunks in parallel.
 4. Display Output - Print the size of each chunk and the first line of each chunk.
}

{$mode objfpc}{$H+}{$J-}

uses
  Classes,
  SysUtils,
  Math;

const
  MaxThreads = 8; // Max threads to use
  ChunkSize = 12 * 1024 * 1024; // Size of chunk for each thread to process (12MB)

type
  // The TThread class encapsulates the native thread support of the OS.
  TFileChunkProcessor = class(TThread)
  private
    FData: array of char; // Chunk of data to work with
    FDataSize: integer;   // Length of data to the nearest new line
  protected
    procedure Execute; override;
  public
    constructor Create(const Data: array of char; DataSize: integer);
  end;

  constructor TFileChunkProcessor.Create(const Data: array of char; DataSize: integer);
  begin
    // Call parent's constructor and don't start thread automatically
    inherited Create(True);

    // Assign a data size to work with
    FDataSize := DataSize;

    // Allocate memory for data and copy it
    // Since Char in Free Pascal can be 1 or 2 bytes (depending on whether
    // it's an ANSI or Unicode character), using SizeOf(Char) ensures
    // the correct number of bytes are moved
    SetLength(FData, FDataSize);
    Move(Data[0], FData[0], FDataSize * SizeOf(char));

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
   separate threads. This routine ensure each thread to process a chunk up to
   the nearest newline, without breaking a paragraph or sentence.
  }
  procedure ReadFileInChunks(const FileName: string);
  var
    fStream: TFileStream;
    buffer: array of char;
    bufferSize: integer;
    index, lastNewLine: integer;
    threadList: array of TFileChunkProcessor;
    activeThreads: integer;
  begin
    fStream := TFileStream.Create(FileName, fmOpenRead);
    try

      // Step 1. Initialise variables for buffer, threads and threads counter.
      // Initialise the buffer; array of char
      SetLength(buffer, ChunkSize);
      // Initialise the array of TFileChunkProcessor
      SetLength(threadList, MaxThreads);
      // Initialise the number of active threadList
      activeThreads := 0;

      // Step 2. Read the file until the file pointer reaches the end of the
      // file as indicated by fStream.Size.
      while fStream.Position < fStream.Size do
      begin
        // Step 2-1. Get the current buffer size.
        // The following algorithm ensures that the buffer size for reading
        // does not exceed the size of the remaining data in the file.
        bufferSize := Min(ChunkSize, (fStream.Size -
          fStream.Position) div SizeOf(char));

        // Step 2-2. Read as much as bufferSize into our buffer
        fStream.Read(buffer[0], bufferSize);

        // Step 2-3. Find the index of the last newline character in the buffer.
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

        // Step 2-4. Create a thread to process (1) the chunk and (2) the size.
        // The size of the chunk to process is the index of the \n + 1.
        threadList[activeThreads] := TFileChunkProcessor.Create(buffer, lastNewLine + 1);
        threadList[activeThreads].Start;

        {
          Step 2-5. Adjust the current file position backwards by the number
          of bytes corresponding to the characters after the last newline.
          This ensures that the file pointer is set to just after the last
          newline character in the buffer.

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
        fStream.Position :=
          fStream.Position - (bufferSize - lastNewLine - 1) * SizeOf(char);

        // Step 2-6. Increment the counter of active threads.
        Inc(activeThreads);

        // Step 2-7. If the number of the threads is the MaxThreads, wait.
        if activeThreads = MaxThreads then
        begin
          // Wait for all current threads to finish
          for index := 0 to MaxThreads - 1 do
          begin
            threadList[index].WaitFor;
          end;
          activeThreads := 0;
        end;
      end; // -- End of the `while fStream.Position < fStream.Size do` loop.

      // Step 3. Last cleanup of remaining active threads.
      // Make sure all threads are completed before returning to the main thread.
      for index := 0 to activeThreads - 1 do
      begin
        threadList[index].WaitFor;
      end;

    finally
      // Clean up the fStream.
      fStream.Free;
    end;
  end;

  // MAIN block ----------------------------------------------------------------
begin

  // Check if we have an input file.
  // If not, Exit.
  if not FileExists(ParamStr(1)) then
  begin
    WriteLn('File not found. Does ', ParamStr(1), ' exist?');
    Exit;
  end;

  // If file exists, pass the file into the routine that parse the text file
  // using multi-threading.
  try
    ReadFileInChunks(ParamStr(1));
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
