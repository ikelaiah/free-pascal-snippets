program LargeTextFileParser;

{$mode objfpc}{$H+}{$J-}

uses
  Classes,
  SysUtils,
  Math;

const
  // Max threads to use
  MaxThreads = 8;
  // Size of chunk for each thread to process
  ChunkSize = 12 * 1024 * 1024; // 12MB


type
  // The TThread class encapsulates the native thread support of the OS.
  // To create a thread, (1) declare a child of the TThread object, ...
  TFileChunkProcessor = class(TThread)
  private
    // (with a data to work with)
    FData: array of char;
    FDataSize: integer;
  protected
    // (2) override the Execute method, and ...
    procedure Execute; override;
  public
    // (3) include a constructor to setup variables for this thread.
    constructor Create(const Data: array of char; DataSize: integer);
  end;

  constructor TFileChunkProcessor.Create(const Data: array of char; DataSize: integer);
  begin
    // Call parent's constructor and don't start thread automatically
    inherited Create(True);

    // Assign data size to work with.
    FDataSize := DataSize;

    // Assign the data to work with using two routines:

    //  1. `SizeOf(Char)`, gives the size of a single Char in bytes.
    //  2. `Move`, which operates on bytes.

    // Since Char in Free Pascal can be 1 or 2 bytes (depending on whether
    // it's an ANSI or Unicode character), using SizeOf(Char) ensures
    // the correct number of bytes are moved.
    SetLength(FData, FDataSize);
    Move(Data[0], FData[0], FDataSize * SizeOf(char));

    // Free thread automatically when finished.
    FreeOnTerminate := True;
  end;

  procedure TFileChunkProcessor.Execute;
  var
    Line: string;
    i: integer;
  begin
    // Example processing: print the chunk size and the first line
    Line := '';
    for i := 0 to FDataSize - 1 do
    begin
      if FData[i] = #10 then
      begin
        Writeln('Processed chunk of size: ', FDataSize, ' bytes');
        Writeln('First line: ', Line);
        Break;
      end
      else if FData[i] <> #13 then
      begin
        Line := Line + FData[i];
      end;
    end;
  end;

  procedure ReadFileInChunks(const FileName: string);
  var
    FileStream: TFileStream;
    Buffer: array of char;
    BufferSize: integer;
    i, LastNewLine: integer;
    Threads: array of TFileChunkProcessor;
    ActiveThreads: integer;
  begin
    FileStream := TFileStream.Create(FileName, fmOpenRead);
    try
      SetLength(Buffer, ChunkSize);
      SetLength(Threads, MaxThreads);
      ActiveThreads := 0;

      while FileStream.Position < FileStream.Size do
      begin
        BufferSize := Min(ChunkSize, (FileStream.Size - FileStream.Position) div SizeOf(Char));
        FileStream.Read(Buffer[0], BufferSize);

        // Find the last newline character in the buffer
        LastNewLine := -1;
        for i := BufferSize - 1 downto 0 do
        begin
          if Buffer[i] = #10 then
          begin
            LastNewLine := i;
            Break;
          end;
        end;

        if LastNewLine = -1 then
          LastNewLine := BufferSize - 1;

        // Create a thread to process the chunk
        Threads[ActiveThreads] := TFileChunkProcessor.Create(Buffer, LastNewLine + 1);
        Threads[ActiveThreads].Start;

        // Move the file position back to the last newline character
        FileStream.Position := FileStream.Position - (BufferSize - LastNewLine - 1) * SizeOf(Char);

        Inc(ActiveThreads);
        if ActiveThreads = MaxThreads then
        begin
          // Wait for all threads to finish
          for i := 0 to MaxThreads - 1 do
          begin
            Threads[i].WaitFor;
          end;
          ActiveThreads := 0;
        end;
      end;

      // Wait for remaining threads to finish
      for i := 0 to ActiveThreads - 1 do
      begin
        Threads[i].WaitFor;
      end;

    finally
      FileStream.Free;
    end;
  end;

begin

  if not FileExists(ParamStr(1)) then
  begin
    WriteLn('File not found. Does ', ParamStr(1), ' exist?');
    Exit;
  end;

  try
    ReadFileInChunks(ParamStr(1));
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
