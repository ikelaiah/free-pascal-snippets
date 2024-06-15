unit CustomThread;

{$mode ObjFPC}{$H+}{$J-}

interface

uses
  Classes, SysUtils, Common;

  // Create a thread class deriving from TThread.
type
  // The TThread class encapsulates the native thread support of the OS.
  // To create a thread, (1) declare a child of the TThread object, ...
  TCustomThread = class(TThread)
    // (with a data to work with)
  private
    // A TStrList to store the input array for this thread, along with
    // a variable to store an instance of critical section.
    list: TStrList;
    cs:TRTLCriticalSection;
  protected
    // (2) override the Execute method, and ...
    procedure Execute; override;
  public
    // (3) include a constructor to setup variables for executing this thread.
    constructor Create(const criticalSection: TRTLCriticalSection;
                       const listToProcess: TStrList;
                       const startIndex, finishIndex: int64);
    // (4) lastly, include  destructor to free the TStrList of this thread.
    destructor Destroy; override;
  end;

implementation

// Create the Custom Thread with an input list to process.
constructor TCustomThread.Create(const criticalSection: TRTLCriticalSection;
                                 const listToProcess: TStrList;
                                 const startIndex, finishIndex: int64);
var
  index: int64;
begin
  // Call parent's constructor
  // If user pass True, thread won't start automatically
  inherited Create(True);

  // Free threads on terminate.
  FreeOnTerminate := True;

  // Assign critical section
  self.cs := criticalSection;

  // Populate the internal list for the Execute procedure
  self.list := TStrList.Create;
  for index := startIndex to finishIndex do
  begin
    self.list.Add(listToProcess[index]);
  end;

  // User feedback
  WriteLn('Thread created with id: ', ThreadID);
end;

destructor TCustomThread.Destroy;
begin
  // Free the TStrList.
  self.list.Free;
  // Call parents' Destroy.
  inherited Destroy;
end;

// Enter and leave Critical Section here.
procedure TCustomThread.Execute;
var
  index: int64;
  student: TStudent;
begin
  for index := 0 to self.list.Count - 1 do
  begin
    EnterCriticalSection(cs); // --------------------------------- enter cs
    try
      // Add student - ID pair as TStudent, then add into TStudentList
      //   1. Get the name from the list with allocated index
      student.Name := list[index];
      //   2. Get the starting student ID from
      student.id := startStudentID;
      //   3. Add TStudent into TStudentList (the main block does the init)
      finalStudentList.Add(student);
      // After a student - ID pair is added, increment the current student ID by 1
      startStudentID := startStudentID + 1
    finally
      LeaveCriticalSection(cs); // ------------------------------- leave cs
    end;
  end;
end;

end.
