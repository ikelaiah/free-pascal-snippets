program EX1SingleThread;

{$mode objfpc}{$H+}{$J-}

uses
  {$IFDEF UNIX}
  cmem, cthreads,
  {$ENDIF}
  Classes { you can add units after this };

type

  // The TThread class encapsulates the native thread support of the OS.
  // To create a thread, (1) declare a child of the TThread object, ...
  TMyThread = class(TThread)
    // (with a data to work with)
  private
    aString: string;
  protected
    // (2) override the Execute method, and ...
    procedure Execute; override;
  public
    // (3) lastly, you may include a constructor to setup variables
    // for executing this thread.
    constructor Create(isSuspended: boolean; message: string);
  end;

  constructor TMyThread.Create(isSuspended: boolean; message: string);
  begin

    // Call parent's constructor
    // If user pass True, thread won't start automatically
    inherited Create(isSuspended);

    // Assign a data to work with.
    self.aString:=message;

    // Free thread when finished.
    FreeOnTerminate:=True;

  end;

  procedure TMyThread.Execute;
  begin
    // Execute thread, and DO SOMETHING in this thread.

    // Example: if the thread has a data to work with,
    //          use it to achieve a goal.
    WriteLn('Thread ', ThreadID, ' is printing ', self.aString);

    // Example: simulate a long running process.
    Sleep(1000);
  end;

var
  mythread:TMyThread;

// Main block --------------------------------------------------
begin

// Create a thread, suspended
myThread:=TMyThread.Create(True, 'Hello World!');

// Debug line
WriteLn('We are in the main thread');

// Start the thread
myThread.Start;

// Wait until the thread is done before going back to
// the main thread
myThread.WaitFor;

// Debug line
WriteLn('We are in the main thread again');

WriteLn('Press enter key to quit');
ReadLn;

end.
