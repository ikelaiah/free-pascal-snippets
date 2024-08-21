program ezthreadsSimple;

{$mode objfpc}{$H+}{$J-}

uses
  {$IFDEF UNIX}
  cmem, cthreads, // Include units for threading support on UNIX systems
  {$ENDIF}
  Classes,
  SysUtils,
  ezthreads;

  // Method to be executed by Thread A
  procedure MethodA(const AThread: IEZThread);
  begin
    // Simulate some important work in Thread A
    WriteLn('TestThread::ThreadA starting');
    Sleep(1000); // Simulate work with a 1-seconds delay
    WriteLn('TestThread::ThreadA finished');
  end;

  // Method to be executed by Thread B
  procedure MethodB(const AThread: IEZThread);
  begin
    // Simulate some important work in Thread B
    WriteLn('TestThread::ThreadB starting');
    Sleep(1000); // Simulate work with a 1-second delay
    WriteLn('TestThread::ThreadB finished');
  end;

var
  LThreadA, LThreadB: IEZThread; // Declare thread variables

  // Main Block
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
    .Setup(@MethodB) // Assign MethodB to Thread B
    .Start;          // Start Thread B

  // Wait for all threads to complete
  Await;

  // Wait for user input to keep the console window open
  WriteLn('Press Enter key to quit');
  ReadLn;
end.
