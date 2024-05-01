program AssignStudentIDs;

{
 This program read a list of student names, and assign a student ID for each
 student using N threads, into a shared output variable.

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
  streamex, Common, CustomThread;

  // All the variables and procedures to get the job done.
var
  customCriticalSection: TRTLCriticalSection;
  fileStream: TFileStream;
  streamReader: TStreamReader;
  studentList: TStrList;
  myThreads: array of TThread;
  subArraySize, index: int64;

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
        3b. Now we add threads & assign workloads, using rounding up division --
            Ceil((totalElements + N - 1) div N).
            - When we divide totalElements by N, we get the quotient of the
              division. However, if totalElements is not evenly divisible by N,
              there might be a remainder.
            - In the context of splitting an array into subarrays, we want
              each subarray to have approximately the same number of elements.
              Therefore, we want to ensure that any remaining elements after
              dividing totalElements by N are included in the last subarray to
              avoid losing data.
            - The expression Ceil((totalElements + N - 1) div N); effectively
              rounds up the division by adding N - 1 to totalElements before
              performing the division. **This ensures that any remainder is
              accounted for in the last subarray**.
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
          TCustomThread.Create(customCriticalSection,
                               studentList,
                               ((index - 1) * subArraySize),
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
