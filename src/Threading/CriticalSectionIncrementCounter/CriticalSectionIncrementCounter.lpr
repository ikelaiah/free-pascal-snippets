program CriticalSectionIncrementCounter;

{

  An example adapted from \lazarus\examples\multithreading\multithread_critical
  for CLI.
  This is a simple example using 4 threads to increase a counter (shared
  variable).

  To enable critical sections, set isCriticalSectionEnabled to True.
  To disable critical sections, set isCriticalSectionEnabled to False.

  With critical sections you will always get 4,000,000.
  Without you will see different results on each run.

  Important: In most Unix like systems, the cthread unit must be added
             to the uses section of the .lpr file. Further, cmem is likely to
             be significently faster so add it as well. Due to how the units
             work a sensible order is cmem, cthreads and then perhaps cwstrings.
             But note that heaptrc does not work with cmem so comment it out
             while testing/debugging.
}

{$mode objfpc}{$H+}{$J-}

uses
  {$IFDEF UNIX}
  cmem, cthreads,
  {$ENDIF}
  Classes,
  SysUtils;

type
  TCustomThread = class(TTHread)
  private
    finishedState: boolean;
  public
    procedure Execute; override;
    property isFinished: boolean read finishedState write finishedState;
  end;

const
  // Use Critical Section or not?
  isCriticalSectionEnabled: boolean = True;

var
  criticalSection: TRTLCriticalSection;
  mainCounter: integer;

  procedure TCustomThread.Execute;
  var
    i: integer;
    currentCounter: longint;
  begin
    // Set the finished state to false.
    finishedState := False;

    // Increment the mainCounter.
    // Because the other threads are doing the same, it will frequently happen
    // that 2 (or more) threads read the same number, increment it by one and
    // write the result back, overwriting the result of the other threads.
    for i := 1 to 1000000 do
    begin

      if isCriticalSectionEnabled then
        // 2. Begins the lock.
        //    When this call returns, the calling thread is the only thread
        //    running the code between the EnterCriticalSection call and the
        //    following LeaveCriticalsection call.
        EnterCriticalSection(criticalSection);
      try
        // Read the current mainCounter
        currentCounter := mainCounter;
        // Increment mainCounter by one
        Inc(currentCounter);
        // Write the result back the mainCounter variable
        mainCounter := currentCounter;
      finally
        if isCriticalSectionEnabled then
          // 3. Releases the lock.
          //    Signals that the protected code can be executed by other threads.
          LeaveCriticalSection(criticalSection);
      end;
    end;

    // Once the task for this thread is done, set the finished state to True.
    finishedState := True;
  end;

  {
   This is the routine that increment a counter
  }
  procedure IncrementCounter;
  var
    index: integer;
    threadList: array[1..4] of TCustomThread;
    isAllThreadsFinished:boolean;
  begin
    mainCounter := 0;

    // 1. Initialises a critical section.
    //    This call must be made before either EnterCrititicalSection or
    //    LeaveCriticalSection is used.
    InitCriticalSection(criticalSection);

    // Start the threadList
    for index := Low(threadList) to High(threadList) do
      threadList[index] := TCustomThread.Create(False);

    WriteLn('All threads created ...');

    // Wait till all threadList finished
    repeat
      isAllThreadsFinished := True;
      for index := Low(threadList) to High(threadList) do
        if not threadList[index].isFinished then isAllThreadsFinished := False;
    until isAllThreadsFinished;

    WriteLn('All threads completed ...');

    // Free the threadList
    for index := Low(threadList) to High(threadList) do
      threadList[index].Free;

    WriteLn('All threads are freed ...');

    // 4. Frees the resources associated with a critical section.
    //    After this call neither EnterCrititicalSection nor LeaveCriticalSection
    //    may be used.
    DoneCriticalSection(criticalSection);

    // Show the mainCounter
    WriteLn('Printing the value of shared variable ...');
    WriteLn('Counter = ' + IntToStr(mainCounter));
  end;

// Main block ------------------------------------------------------------------
begin
  // Print status of Critical Section
  if isCriticalSectionEnabled then
    WriteLn('Critical Section: Enabled')
  else
    WriteLn('Critical Section: Disabled');

  // Callt he routine to increment a counter using multi-threading
  IncrementCounter;

  // Pause console
  WriteLn('Press Enter key to exit.');
  ReadLn;
end.
