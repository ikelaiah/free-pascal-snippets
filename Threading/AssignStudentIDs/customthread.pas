unit CustomThread;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Common;

  // Create a thread class deriving from TThread.
type
  TCustomThread = class(TThread)
  private
    list: TstrList;
    cs:TRTLCriticalSection;
  protected
    procedure Execute; override;
  public
    constructor Create(const criticalSection: TRTLCriticalSection; const listToProcess: TStrList; startIndex, finishIndex: int64);
    destructor Destroy; override;
  end;

implementation

// Create the Custom Thread with an input list to process.
constructor TCustomThread.Create(const criticalSection: TRTLCriticalSection;
                                 const listToProcess: TStrList; startIndex, finishIndex: int64);
var
  index: int64;
begin
  // This won't start the threads straight away.
  inherited Create(True);

  // Not to free on terminate.
  //FreeOnTerminate := True;

  self.cs := criticalSection;

  // Populate the internal list for the Execute procedure
  self.list := TStrList.Create;
  for index := startIndex to finishIndex do
  begin
    self.list.Add(listToProcess[index]);
  end;

  // User feedback
  WriteLn('Thread created ', ThreadID);
end;

destructor TCustomThread.Destroy;
begin
  self.list.Free;
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
    EnterCriticalSection(cs); // -------------------------------------- enter cs
    try
      // Add TStudent into TStudentList
      student.Name := list[index];
      student.id := startStudentID;
      finalStudentList.Add(student);
      // Increment student ID by 1
      startStudentID := startStudentID + 1
    finally
      LeaveCriticalSection(cs); // ------------------------------------ leave cs
    end;
  end;
end;

end.
