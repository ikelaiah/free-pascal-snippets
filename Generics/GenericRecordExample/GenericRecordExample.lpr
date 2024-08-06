program GenericRecordExample;

{$mode objfpc}{$H+}{$J-}
{$modeswitch advancedrecords}

type
  // Define a generic record TPair
  generic TPair<T1, T2> = record
    First: T1;
    Second: T2;
    constructor Create(AFirst: T1; ASecond: T2);
  end;

  constructor TPair.Create(AFirst: T1; ASecond: T2);
  begin
    First := AFirst;
    Second := ASecond;
  end;

type
  // Create types based on TPair
  TIntegerStringPair = specialize TPair<integer, string>;
  TRealBoolPair = specialize TPair<real, boolean>;
  {
   Alternatively, use `specialize` directly in the var section.

   ```
   var
     intStrPair:specialize TPair<integer, string>;
     realBoolPair:specialize TPair<real, boolean>;
   ```

   And use specialize again when you initialise the variables

   ```
   begin
     // ...
     intStrPair := specialize TPair<integer, string>.Create(10, 'Ten');
     realBoolPair := specialize TPair<double, boolean>.Create(3.14, True);
     // ...
  end.
  ```
  }

var
  intStrPair: TIntegerStringPair;
  realBoolPair: TRealBoolPair;

// Main block
begin
  intStrPair := TIntegerStringPair.Create(10, 'Ten');
  realBoolPair := TRealBoolPair.Create(3.14, True);

  Writeln('intStrPair  : (', intStrPair.First, ', ', intStrPair.Second, ')');
  Writeln('realBoolPair: (', realBoolPair.First: 0: 2, ', ', realBoolPair.Second, ')');

  // Pause console
  WriteLn('Press Enter to quit');
  ReadLn;
end.
