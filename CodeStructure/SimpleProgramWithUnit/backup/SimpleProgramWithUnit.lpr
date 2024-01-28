program SimpleProgramWithUnit;

{$mode ObjFPC}{$H+}{$J-}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes,
  Areas;

begin
  // Calculate area of a square
  WriteLn('Area of 2.5cm square is ',
          Areas.CalcAreaSquare(2.5): 0: 2,
          ' cm².');

  // Calculate area of a circle
  WriteLn('Area of a circle with r=2.5cm is ', Areas.CalcAreaCircle(2.5):
    0: 2, ' cm².');

  // The following WriteLn will not compile
  // Because shortPI is declared in the private section of the Area unit
  // WriteLn('shortPI is ', Areas.shortPI);

  // Pause console
  WriteLn('Press Enter key to exit ...');
  readln;
end.
