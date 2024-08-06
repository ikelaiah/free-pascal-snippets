program FuncRefDigitalCircuitSimulator;

{$mode objfpc}{$H+}{$J-}
{$modeswitch functionreferences}

uses
  SysUtils;

type
  // Define a function reference type that takes booleans and return a boolean
  TLogicGate = reference to function(A, B: boolean): boolean;

  // Define the AND logic gate function
  function ANDGate(A, B: boolean): boolean;
  begin
    Result := A and B;
  end;

  // Define the OR logic gate function
  function ORGate(A, B: boolean): boolean;
  begin
    Result := A or B;
  end;

  // Define the XOR logic gate function
  function XORGate(A, B: boolean): boolean;
  begin
    Result := A xor B;
  end;

  // Procedure to simulate a digital circuit using a given logic gate
  procedure SimulateCircuit(Gate: TLogicGate; A, B: boolean);
  begin
    // Print the result of applying the logic gate to A and B
    WriteLn(BoolToStr(Gate(A, B), True));
  end;

begin
  // Simulate the circuit with the AND gate and inputs True and False
  SimulateCircuit(@ANDGate, True, False);  // Outputs: FALSE

  // Simulate the circuit with the OR gate and inputs True and False
  SimulateCircuit(@ORGate, True, False);   // Outputs: TRUE

  // Simulate the circuit with the XOR gate and inputs True and False
  SimulateCircuit(@XORGate, True, False);  // Outputs: TRUE

  // Pause the console to view the output
  WriteLn('Press Enter to quit');
  ReadLn;
end.
