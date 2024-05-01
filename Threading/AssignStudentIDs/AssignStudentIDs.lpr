program AssignStudentIDs;

{
 This program read a list of student names, and assign a student ID for each
 student using 2 threads, into a shared output variable.

 Pre-requisite

    - TThread for managing the threads.
    - TRTLCriticalSection for ensuring only one thread can modify a shared
      variable at one time.
    - LGenerics library by A.Koverdyaev (avk).

 Algorithm

    - Read the text file into an array.
      - All threads will read from the same array, but at differing start and
        finish indexes. This depends on the number of max threads.
    - Assign workloads to each thread.
      - Specify the start and finish indexes to each thread.
      - Will use the rounding up division method to ensure near-equal division
        of workload for each thread.
    - Wait until all task is done.
    - Print results on screen.
}

{$mode objfpc}{$H+}{$J-}

uses
  {$IFDEF UNIX}
  cmem
  , cthreads
  {$ENDIF}
  Classes,
  SysUtils,
  Math,
  lgVector,
  streamex;

type
  TStudent = record
    Name: string;
    id: integer;
  end;

type
  TStudentList = specialize TGLiteVector<TStudent>;
  TStrList = specialize TGLiteVector<string>;

  // Create a thread class deriving from TThread.
type
  TCustomThread = class(TThread)
  private
    list: TstrList;
  protected
    procedure Execute; override;
  public
    constructor Create(const listToProcess: TStrList; startIndex, finishIndex: int64);
  end;

  // All the variables and procedures to get the job done.
const
  maxThreads: int64 = 4;
var
  customCriticalSection: TRTLCriticalSection;
  fileStream: TFileStream;
  streamReader: TStreamReader;
  startStudentID: int64 = 200000;
  studentList: TStrList;
  finalStudentList: TStudentList;
  myThreads: array of TThread;
  subArraySize, index: int64;

  // Create the Custom Thread with an input list to process.
  constructor TCustomThread.Create(const listToProcess: TStrList;
    startIndex, finishIndex: int64);
  var
    index: int64;
  begin
    // This won't start the threads straight away.
    inherited Create(True);

    // Not to free on terminate.
    //FreeOnTerminate := True;

    // Populate the internal list for the Execute procedure
    for index := startIndex to finishIndex do
    begin
      self.list.Add(listToProcess[index]);
    end;

    // User feedback
    WriteLn('Thread created ', ThreadID);
  end;
  // Enter and leave Critical Section here.
  procedure TCustomThread.Execute;
  var
    index: int64;
    student: TStudent;
  begin
    for index := 0 to self.list.Count - 1 do
    begin
      EnterCriticalSection(customCriticalSection); // --------------- enter cs
      try
        // Add TStudent into TStudentList
        student.Name := list[index];
        student.id := startStudentID;
        finalStudentList.Add(student);
        // Increment student ID by 1
        startStudentID := startStudentID + 1
      finally
        LeaveCriticalSection(customCriticalSection); // ------------- leave cs
      end;
    end;
  end;

  // Main block ////////////////////////////////////////////////////////////////
begin
  try
    // 1. Read input text file and populate input array from a text file
    if not FileExists(ParamStr(1)) then
    begin
      WriteLn(Format('%s does not exist.', [ParamStr(1)]));
      Exit;
    end;

    fileStream := TFileStream.Create(ParamStr(1), fmOpenRead);
    try
      streamReader := TStreamReader.Create(fileStream, 65536, False);
      try
        while not streamReader.EOF do
        begin
          // Add each line into a list
          studentList.Add(streamReader.ReadLine);
        end;
      finally
        streamReader.Free;
      end;
    finally
      fileStream.Free
    end;

    // 2. Init Critical Section as we have threads writing to a shared variable
    InitCriticalSection(customCriticalSection);

    // 3a. set the number of threads in array of TThread
    SetLength(myThreads, maxThreads);
    try
      {
        3b. Now we add threads & assign workloads, using rounding up division.
        - Why? By using the expression Ceil((totalElements + N - 1) div N), we
          ensure that all elements are distributed among the subarrays as evenly
          as possible, with any remaining elements placed in the last subarray.
        - When we divide totalElements by N, we get the quotient of the division.
          However, if totalElements is not evenly divisible by N, there might be
          a remainder.
        - In the context of splitting an array into subarrays, we want each
          subarray to have approximately the same number of elements. Therefore,
          we want to ensure that any remaining elements after dividing
          totalElements by N are included in the last subarray to avoid losing
          data.
        - The expression Ceil((totalElements + N - 1) div N); effectively rounds up
          the division by adding N - 1 to totalElements before performing the
          division. This ensures that any remainder is accounted for in
          the last subarray.
      }
      subArraySize := Math.Ceil((studentList.Count + maxThreads - 1) / maxThreads);

      // Show user feedback
      WriteLn('No of students         : ', IntToStr(studentList.Count));
      WriteLn('Max threads            : ', IntToStr(maxThreads));
      WriteLn('subArray size round up : ', IntToStr(subArraySize));
      WriteLn('---------------------------------');

      {
       3c. Assign workload to each thread by using the following info;
           - source list
           - start index and
           - finish index for a thread
      }
      for index := 1 to maxThreads do
      begin
        myThreads[index - 1] :=
          TCustomThread.Create(studentList, ((index - 1) * subArraySize),
                                            Math.Min(index * subArraySize - 1, studentList.Count - 1));
      end;

      // 4. Start all threads
      WriteLn('Starting threads ...');
      for index := 0 to High(myThreads) do
        myThreads[index].Start;

      // 5. Wait for both threads to finish
      WriteLn('Waiting for threads to finish ...');
      for index := 0 to High(myThreads) do
        myThreads[index].WaitFor;
      WriteLn('All threads are done ...');

      // 6. Show results
      WriteLn('Printing results ...');
      for index := 0 to finalStudentList.Count - 1 do
        WriteLn(finalStudentList[index].Name, ', ', finalStudentList[index].id);

      // Show user feedback
      WriteLn('---------------------------------');
      WriteLn(Format('Output list contains %d items', [finalStudentList.Count]));
      WriteLn('---------------------------------');
    finally
      // 7. Free Critical Section
      DoneCriticalSection(customCriticalSection);
    end;
  except
    on E: Exception do
      WriteLn('Error: ' + E.Message);
  end;
end.
