program ezthreadsPool;

{$mode objfpc}{$H+}{$J-}
{$modeswitch nestedprocvars}

uses
  {$IFDEF UNIX}
  cmem, cthreads, // Include units for threading support on UNIX systems
  {$ENDIF}
  Classes,
  SysUtils,
  ezthreads, ezthreads.pool; // Include units for thread pool support

// A procedure to test two tasks running in parallel using a thread pool
procedure TestTwoTasks;
var
  LPool: IEZThreadPool;
  LJobOneFinished, LJobTwoFinished: boolean; // Flags to indicate if the jobs are finished

  // A simple parallel job (JobOne)
  procedure JobOne(const AThread: IEZThread);
  begin
    // Simulate some work with a sleep of 100 ms
    Sleep(100);
    // Mark the job as finished
    LJobOneFinished := True;
  end;

  // Another simple parallel job (JobTwo)
  procedure JobTwo(const AThread: IEZThread);
  begin
    // Simulate some work with a sleep of 100 ms
    Sleep(100);
    // Mark the job as finished
    LJobTwoFinished := True;
  end;

begin
  // Initialise flags for checking if both jobs finished
  LJobOneFinished := False;
  LJobTwoFinished := False;

  // Initialise a pool with two worker threads
  LPool := NewEZThreadPool(2);

  // Queue two jobs to the pool
  LPool
    .Queue(@JobOne, nil, nil) // Queue JobOne to the pool
    .Queue(@JobTwo, nil, nil) // Queue JobTwo to the pool
    .Start; // Start the pool, which begins executing the jobs

  // Wait until both jobs finish
  Await(LPool);

  // Write the status to the console
  WriteLn(Format('TestTwoTasks::[success]:%s',
                 [BoolToStr(LJobOneFinished and LJobTwoFinished, True)]));
end;

// Main block
begin
  // Run the demo procedure that tests two tasks in parallel
  TestTwoTasks;

  // Wait for user input to keep the console window open
  WriteLn('Press Enter key to quit');
  ReadLn;
end.
