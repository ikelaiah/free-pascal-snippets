program EX2MultiThread;

{
  # EX2MultiThread

  A simple demo of multi-threading.

  ## Example of an output

  ---------------------
  Started TThread demo
  ---------------------
  Starting a task from the main thread
  Started a task on thread ID 22848
  Started a task on thread ID 24428
  Completed the task from the main thread
  Completed task on thread ID: 22848
  Completed task on thread ID: 24428
  ---------------------
  Finished TThread demo
  Press Enter to quit
  ---------------------
}


{$mode objfpc}{$H+}{$J-}

// 2024-02-08 - paweld 🇵🇱 fixed a memory leak issue on the original code.

uses
  {$ifdef unix}
  cmem, cthreads,
  {$endif}
  Classes,
  SysUtils;

type
  // Create a class based on TThread
  // TTaskThread
  TTaskThread = class(TThread)
  protected
    // Override the Execute procedure of TThread
    procedure Execute; override;
  public
    // Thread constructor with free on terminate
    constructor Create;
  end;

  // The Execute procedure, simulating a task
  procedure TTaskThread.Execute;
  begin
    WriteLn('Started a task on thread ID ', ThreadID);

    Sleep(2000); // Simulating a long-running task.

    WriteLn('Completed task on thread ID: ', ThreadID);
  end;

  // Constructor of TTaskThread
  constructor TTaskThread.Create;
  begin
    // Create as suspended.
    inherited Create(True);
    // Set Free on Terminate to false, so it won't free itself when completed.
    FreeOnTerminate := False;
    // Run thread.
    Start;
  end;

var
  task1, task2: TThread;

begin
  WriteLn('---------------------');
  WriteLn('Started TThread demo');
  WriteLn('---------------------');

  // Create all threads
  task1 := TTaskThread.Create;
  task2 := TTaskThread.Create;

  // Start a task on the main thread
  Writeln('Starting a task from the main thread');
  Sleep(2000); // simulate a task
  Writeln('Completed the task from the main thread');

  // Wait for threads to finish before going back to the main thread.
  task1.WaitFor;
  task2.WaitFor;

  // Free the threads manually
  task1.Free;
  task2.Free;

  WriteLn('---------------------');
  WriteLn('Finished TThread demo');
  WriteLn('Press Enter to quit');
  WriteLn('---------------------');
  ReadLn;
end.
