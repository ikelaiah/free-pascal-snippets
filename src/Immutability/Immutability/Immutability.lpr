program Immutability;

{$mode objfpc}{$H+}{$J-}

const
  gravityEarth:Real = 9.81;

begin
  gravityEarth := 1.625;
  WriteLn('The gravity on the Earth is ', gravityEarth:0:2);
end.

