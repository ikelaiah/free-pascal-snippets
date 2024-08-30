program COMInterfaceExample;

{$mode objfpc}{$H+}{$J-}

type
  // Step 1: Define the Interface
  IMyInterface = interface
    ['{12345678-1234-1234-1234-1234567890AB}'] // Unique identifier (GUID) for the interface
    procedure DoSomething;
  end;

  // Step 2: Implement the Interface in a Class
  TMyClass = class(TInterfacedObject, IMyInterface)
  public
    procedure DoSomething;
  end;

procedure TMyClass.DoSomething;
begin
  WriteLn('Doing something...');
end;

var
  MyObject: IMyInterface;
begin
  // Step 3: Use the Interface and Class
  MyObject := TMyClass.Create;
  MyObject.DoSomething;

  // Pause console
  WriteLn('Press enter to quit');
  ReadLn;
end.

