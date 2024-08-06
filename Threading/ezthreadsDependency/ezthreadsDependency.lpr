program ezthreadsDependency;

{$mode objfpc}{$H+}{$J-}
{$modeswitch nestedprocvars}

uses
  {$IFDEF UNIX}
  cmem, cthreads, // Include units for threading support on UNIX systems
  {$ENDIF}
  Classes,
  SysUtils,
  ezthreads;

{
  This example demonstrates a scenario where one thread (B) depends
  on another thread (A) to finish before it can proceed. The main thread
  waits for both threads (A) and (B) to complete using the await mechanism.
}
  procedure TestThreadDependency;
  var
    LThreadA, LThreadB: IEZThread; // Declare thread variables

  // Method to be executed by Thread A
    procedure MethodA(const AThread: IEZThread);
    begin
      // Simulate some important work in Thread A
      WriteLn('TestThreadDependency::ThreadA starting');
      Sleep(1000); // Simulate work with a 1-second delay
      WriteLn('TestThreadDependency::ThreadA finished');
    end;

    // Method to be executed by Thread B
    procedure MethodB(const AThread: IEZThread);
    var
      LID: string;
    begin
      LID := AThread['id']; // Retrieve the ID of Thread A

      // Indicate that Thread B is starting
      WriteLn('TestThreadDependency::ThreadB starting');

      // Wait until Thread A has completed its execution
      Await(LID);

      // Indicate that Thread B has finished
      WriteLn('TestThreadDependency::ThreadB finished');
    end;

  begin
    // Initialize both threads
    LThreadA := NewEZThread;
    LThreadB := NewEZThread;

    // Setup and start Thread A
    LThreadA
      .Setup(@MethodA) // Assign MethodA to Thread A
      .Start;          // Start Thread A

    // Setup Thread B to wait for Thread A to finish before starting its task
    LThreadB
      .AddArg('id', LThreadA.Settings.Await.GroupID) // Pass the GroupID of Thread A to Thread B
      .Setup(@MethodB) // Assign MethodB to Thread B
      .Start;          // Start Thread B

    // Wait for all threads to complete
    Await;
  end;

begin
  // Execute the thread dependency test
  TestThreadDependency;
  // Wait for user input to keep the console window open
  ReadLn;
end.
