program CreateThreadsCriticalSection;

{
 This program generates combination of letters (A-Z) and numbers (0-4)
 using 2 threads, into a shared output variable.

 To achieve the task, the program uses the following classes:
    - TThread -- for managing the threads
    - TRTLCriticalSection -- for ensuring only one thread modify
      a shared variable at one time.

 Algorithm:
    - The first thread processes A-M. The second, N-Z.
    - Each thread add numbers (0-4) next to the assigned letters
    - Wait until all task is done then sort results.
    - Print results on screen.
}

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cmem
  , cthreads
  {$ENDIF}
  Classes,
  SysUtils,
  Math,
  Generics.Defaults,
  Generics.Collections;

type
  TStringHelper = specialize TArrayHelper<shortstring>;

  // Create a thread class deriving from TThread.
type
  TCustomThread = class(TThread)
  private
    list: array of shortstring;
  protected
    procedure Execute; override;
  public
    constructor Create(const listToProcess: array of shortstring);
  end;

  // All the variables and procedures to get the job done.
var
  customCriticalSection: TRTLCriticalSection;
  allLetters: array of shortstring = ('A', 'B', 'C', 'D', 'E', 'F',
    'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S',
    'T', 'U', 'V', 'W', 'X', 'Y', 'Z');
  outputList, slicedList: array of shortstring;
  myThreads: array of TThread;
  index: int64;

  // The procedure that update the main list of string (shared variable)
  procedure UpdateMainList(const newString: shortstring);
  begin
    // Increase the length of the array by 1
    SetLength(outputList, Length(outputList) + 1);
    // Assign the new item to the last element of the array
    outputList[Length(outputList) - 1] := newString;
  end;

  // Create the Custom Thread with an input list to process.
  constructor TCustomThread.Create(const listToProcess: array of shortstring);
  var
    index: int64;
  begin
    // This won't start the threads straight away.
    inherited Create(True);

    // Not to free on terminate.
    //FreeOnTerminate := True;

    // Populate the internal list for the Execute procedure
    SetLength(self.list, length(listToProcess));
    for index := 0 to high(listToProcess) do
    begin
      self.list[index] := listToProcess[index];
    end;
    WriteLn('Thread created ', ThreadID);
  end;

  // The actual task to execute for each task.
  // Enter and leave Critical Section here.
  procedure TCustomThread.Execute;
  var
    index, indexOuter: int64;
  begin
    for indexOuter := 0 to 4 do
      for index := 0 to High(list) do
      begin
        EnterCriticalSection(customCriticalSection); // --------------- enter cs
        try
          UpdateMainList(self.list[index] +
                         IntToStr(indexOuter) +
                         ' - from ThreadID ' +
                         IntToStr(ThreadID));
        finally
          LeaveCriticalSection(customCriticalSection); // ------------- leave cs
        end;
      end;
  end;

  // Main block ////////////////////////////////////////////////////////////////
begin

  // Init Critical Section
  InitCriticalSection(customCriticalSection);

  // Init output length
  SetLength(outputList, 0);

  // Init temp list var
  SetLength(slicedList, 0);

  // Add threads & assign workloads
  WriteLn('Adding threads ...');
  SetLength(myThreads, 2);

  slicedList := Copy(allLetters, 0, length(allLetters) div 2);
  myThreads[0] := TCustomThread.Create(slicedList);

  slicedList := Copy(allLetters, 13, length(allLetters) div 2);
  myThreads[1] := TCustomThread.Create(slicedList);

  // Start all threads
  WriteLn('Starting threads ...');
  for index := 0 to High(myThreads) do
    myThreads[index].Start;

  // Wait for both threads to finish
  WriteLn('Waiting threads');
  for index := 0 to High(myThreads) do
    myThreads[index].WaitFor;
  WriteLn('All threads are done ...');

  // Sorting
  WriteLn('Sort results ...');
  TStringHelper.Sort(outputList);

  // Show results
  WriteLn('Printing results ...');
  for index := 0 to High(outputList) do
    WriteLn(outputList[index]);

  WriteLn(Format('Output arrays contains %d items', [length(outputList)]));

  // Free Critical Section
  DoneCriticalSection(customCriticalSection);
end.
