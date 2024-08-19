program AnonymousFuncSimple;

{$mode objfpc}{$H+}{$J-}
{$modeswitch anonymousfunctions}  // Enable anonymous functions

uses
  SysUtils, Classes;

type
  TFunc = function: integer;

var
  proc: TProcedure;     // Declared in SysUtils
  func: TFunc;
  notify: TNotifyEvent; // Declared in Classes

begin

  // Anonymous procedure with a single argument
  procedure(const aArg: string)
  begin
    Writeln(aArg);
  end('Hello World');

  // Assigning an anonymous procedure to the 'proc' variable
  proc := procedure
          begin
            Writeln('Foobar');
          end;
  proc;

  // Assigning an anonymous procedure to the 'notify' event
  notify := procedure(aSender: TObject)
            begin
              Writeln(HexStr(Pointer(aSender)));
            end;
  notify(Nil);

  // Assigning an anonymous function to the 'func' variable
  func := function MyRes : integer
          begin
            Result := 42;
          end;
  Writeln(func);

  // Pause the console to view the output
  WriteLn('Press Enter to quit');
  ReadLn;
end.
