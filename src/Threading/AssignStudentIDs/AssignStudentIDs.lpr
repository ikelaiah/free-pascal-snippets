program AssignStudentIDs;

{
 This program assigns student ID to each name from a text file by
 using N number of threads.

 Pre-requisite

    - TThread for managing the threads.
    - TRTLCriticalSection for ensuring only one thread can modify a shared
      variable at one time.
    - Input text file containing a list of names. For example;

    Alyssa Morgan
    Declan Hayes
    Nora Patel
    Miles Thompson
    Sienna Larson
    Kellan Rivera
    Camille Chang
    Jensen Park
    Amara Singh
    Holden Myers
    Elise Howard
    Luca Griffin
    Reagan Patel
    Kian Gallagher
    Mara Nguyen
    ...
    ...

 Algorithm

    - Read the text file into an array.
      - All threads will read from the same array, but at differing start and
        finish indexes. This depends on the number of max threads.
    - Assign workloads to each thread.
      - Specify the start and finish indexes to each thread.
      - Will use the rounding up division method to ensure near-equal division
        of workload for each thread.
    - Wait for the threads to finish and then free them.
    - Sort the final student list
    - Print results on screen.

 Sample Output

   $ ./AssignStudentIDs.exe student-names.txt
   No of students         : 200
   Max threads            : 4
   subArray size round up : 51
   ---------------------------------
   Thread created 25040
   Thread created 26324
   Thread created 11972
   Thread created 26028
   Starting threads ...
   Waiting for threads to finish ...
   All threads are done ...
   Printing results ...
   Alyssa Morgan, 200000
   Declan Hayes, 200001
   Nora Patel, 200002
   Miles Thompson, 200003
   Sienna Larson, 200004
   Kellan Rivera, 200005
   Camille Chang, 200006
   Jensen Park, 200007
   Amara Singh, 200008
   Holden Myers, 200009
   Elise Howard, 200010
   Luca Griffin, 200011
   Reagan Patel, 200012
   ...
   ...

}

{$mode objfpc}{$H+}{$J-}

uses
  {$IFDEF UNIX}
  cmem, cthreads,
  {$ENDIF}
  Classes,
  SysUtils,
  Math,
  streamex,
  Common,
  CustomThread;

  // All the variables and procedures to get the job done.
var
  // Critical Section preventing threads accessing a variable at the same time.
  customCriticalSection: TRTLCriticalSection;

  // TStreams for reading files
  fileStream: TFileStream;
  streamReader: TStreamReader;

  // A temporary list to hold student names from a text file
  strList: TStrList;

  // An array of threads
  myThreads: array of TThread;

  // Variables for calculating subarray size for each thread
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

    strList := TStrList.Create;
    finalStudentList := TStudentList.Create;
    try
      fileStream := TFileStream.Create(ParamStr(1), fmOpenRead);
      try
        streamReader := TStreamReader.Create(fileStream, 65536, False);
        try
          while not streamReader.EOF do
          begin
            // Add each line into a list
            strList.Add(streamReader.ReadLine);
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
        subArraySize := Math.Ceil((strList.Count + maxThreads - 1) / maxThreads);

        // Show user feedback
        WriteLn('No of students         : ', IntToStr(strList.Count));
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
          myThreads[index - 1] := TCustomThread.Create(customCriticalSection,
                                                       strList,
                                                       ((index - 1) * subArraySize),
                                                       Math.Min(index * subArraySize - 1, strList.Count - 1));
        end;

        // 4. Start all threads
        WriteLn('Starting threads ...');
        for index := 0 to High(myThreads) do
          myThreads[index].Start;

        // 5. Wait for both threads to finish and free
        WriteLn('Waiting for threads to finish ...');
        for index := 0 to High(myThreads) do
          begin
            myThreads[index].WaitFor;
            myThreads[index].Free;
          end;
        WriteLn('All threads are done ...');

        // 6. Sort by student ID
        finalStudentList.Sort(TStudentListComparer.construct(@CompareID));

        // 7. Show results
        WriteLn('Printing results ...');
        for index := 0 to finalStudentList.Count - 1 do
          WriteLn(finalStudentList[index].Name, ', ', finalStudentList[index].id);

        // 8. Show user feedback
        WriteLn('---------------------------------');
        WriteLn(Format('Output list contains %d items', [finalStudentList.Count]));
        WriteLn('---------------------------------');
      finally
        // 7. Free Critical Section
        DoneCriticalSection(customCriticalSection);
      end;
    finally
      finalStudentList.Free;
      strList.Free;
    end;

  except
    on E: Exception do
      WriteLn('Error: ' + E.Message);
  end;
end.
