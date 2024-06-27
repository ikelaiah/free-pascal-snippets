program CriticalSectionIncrementCounter;

{
A demo adapted from \lazarus\examples\multithreading\multithread_critical for CLI.
This is a simple example using 4 threads to increase a counter.

To enable critical sections, set isCriticalSectionEnabled to True.
To disable critical sections, set isCriticalSectionEnabled to False.

With critical sections you will always get 4,000,000.
Without you will see different results on each run and depending on your
system.

Important: In most (all?) Unix like systems, the cthread unit must be added
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
  customCriticalSection: TRTLCriticalSection;
  mainCounter: integer;

  procedure TCustomThread.Execute;
  var
    i: integer;
    currentCounter: longint;
  begin
    // Set the finished state to false.
    finishedState := False;

    // Increment the mainCounter.
    // Because the other threads are doing the same, it will frequently happen,
    // that 2 (or more) threads read the same number, increment it by one and
    // write the result back, overwriting the result of the other threads.
    for i := 1 to 1000000 do
    begin
      if isCriticalSectionEnabled then EnterCriticalSection(customCriticalSection);
      try
        // Read the current mainCounter
        currentCounter := mainCounter;
        // Increment mainCounter by one
        Inc(currentCounter);
        // Write the result back the mainCounter variable
        mainCounter := currentCounter;
      finally
        if isCriticalSectionEnabled then LeaveCriticalSection(customCriticalSection);
      end;
    end;

    // Once the task for this thread is done, set the finished state to True.
    finishedState := True;
  end;

  procedure IncrementCounter;
  var
    i: integer;
    Threads: array[1..4] of TCustomThread;
  begin
    mainCounter := 0;

    // Create the CriticalSection
    InitCriticalSection(customCriticalSection);

    // Start the threads
    for i := Low(Threads) to High(Threads) do
      Threads[i] := TCustomThread.Create(False);

    WriteLn('All threads created ...');

    // Wait till all threads finished
    {repeat
      AllFinished := True;
      for i := Low(Threads) to High(Threads) do
        if not Threads[i].isFinished then AllFinished := False;
    until AllFinished;}

    // Wait for the threads to finish
    for i := Low(Threads) to High(Threads) do
      Threads[i].WaitFor;

    WriteLn('All threads completed ...');

    // Free the threads
    for i := Low(Threads) to High(Threads) do
      Threads[i].Free;

    WriteLn('All threads are freed ...');

    // Free the CriticalSection
    DoneCriticalSection(customCriticalSection);

    // Show the mainCounter
    WriteLn('Printing the value of shared variable ...');
    WriteLn('Counter = ' + IntToStr(mainCounter));
  end;

begin
  // Print status of Critical Section
  if isCriticalSectionEnabled then
    WriteLn('Critical Section: Enabled')
  else
    WriteLn('Critical Section: Disabled');

  // Count using multi-threading
  IncrementCounter;

  // Pause console
  WriteLn('Press Enter key to exit.');
  ReadLn;
end.
