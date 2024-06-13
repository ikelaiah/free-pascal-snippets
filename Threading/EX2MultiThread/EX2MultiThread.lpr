program EX2MultiThread;

{$mode objfpc}{$H+}{$J-}

uses
  {$IFDEF UNIX}
  cmem, cthreads,
  {$ENDIF}
  Classes,
  Types,
  Generics.Collections,
  Math { you can add units after this };

  // --- Custom thread type --------------------------------------
type
  // The TThread class encapsulates the native thread support of the OS.
  // To create a thread, (1) declare a child of the TThread object, ...
  TMyThread = class(TThread)
    // (with a data to work with)
  private
    // Variables to store the input array for this thread to sum, along with
    // start index and end index
    anArray: TIntegerDynArray;
    startIdx: integer;
    endIdx: integer;
    // The sum of array in the thread
    partialSum: integer;
  protected
    // (2) override the Execute method, and ...
    procedure Execute; override;
  public
    // (3) lastly, you may include a constructor to setup variables
    // for executing this thread.
    constructor Create(const isSuspended: boolean;
                       var   inputArray: TIntegerDynArray;
                       const startIndex: integer;
                       const endIndex: integer);
  end;

  constructor TMyThread.Create(const isSuspended: boolean;
                               var   inputArray: TIntegerDynArray;
                               const startIndex: integer;
                               const endIndex: integer);
  begin
    // Call parent's constructor
    // If user pass True, thread won't start automatically
    inherited Create(isSuspended);

    // Assign a data to work with.
    self.anArray := inputArray;
    self.startIdx := startIndex;
    self.endIdx := endIndex;

    // DO NOT Free thread when finished here.
    // The main thread will ...
    //   1. collect the results from n threads,
    //   2. free n threads from the main thread.
    FreeOnTerminate := False;
  end;

  procedure TMyThread.Execute;
  var
    index: integer;
  begin
    // Execute thread, and DO SOMETHING in this thread.

    // Initialise partialSum to 0 to start with
    self.partialSum := 0;

    // partialSum the numbers in the assigned array using for..do loop.
    for index := self.startIdx to self.endIdx do
      self.partialSum := self.partialSum + self.anArray[index];

    // Display user feedback from this thread
    WriteLn('Thread ', ThreadID, ' summed up ', self.partialSum);
  end;

// const and var for the main block ----------------------------
const
  // Specify max number of threads to use.
  MAX_THREADS = 4;
  // The length of an input array may come from a file.
  INPUT_ARRAY_LENGTH = 10000;

var
  // Input array containg numbers to sum.
  inputArray: TIntegerDynArray;
  // Setting an array for the threads.
  myThreads: array of TMyThread;
  // Size of a segment for each thread
  segmentSize: integer;
  // total sum -- will collect values from each thread
  totalSum: integer;
  // Indexes
  index, startIndex, endIndex: integer;


  // Main block ------------------------------------------------
begin

  // Populate input array. This may come from a file.
  SetLength(inputArray, INPUT_ARRAY_LENGTH);
  for index := 0 to INPUT_ARRAY_LENGTH - 1 do
    inputArray[index] := index + 1;


  // Calculate segment size for each thread
  segmentSize := Math.Ceil((Length(inputArray) + MAX_THREADS - 1) / MAX_THREADS);

  // Create and start the threads.
  SetLength(myThreads, MAX_THREADS);
  for index := 0 to MAX_THREADS - 1 do
  begin
    // Start index for a thread is i * segmentSize.
    startIndex := index * SegmentSize;
    // Ensure that each thread processes the correct portion of the array
    // without going out of bounds on last iteration.
    endIndex := Min((index + 1) * SegmentSize - 1, Length(inputArray) - 1);

    // Show user info.
    WriteLn('startIndex: ', startIndex, ' ', ' endIndex:', endIndex);

    // Create a thread.
    myThreads[index] := TMyThread.Create(False, inputArray, StartIndex, EndIndex);
    // Start this new thread.
    myThreads[index].Start;
  end;

  // Wait until a thread is done, sum up and free it.
  totalSum := 0;
  for index := 0 to MAX_THREADS - 1 do
  begin
    // Wait until thread index n finishes
    myThreads[index].WaitFor;
    // Get the partial sum from thread index n
    totalSum := totalSum + myThreads[index].partialSum;
    // Lastly, free thread index n
    myThreads[index].Free;
  end;

  // Display results
  WriteLn('Total sum of array is: ', totalSum);

  WriteLn('Press enter key to quit');
  ReadLn;
end.
