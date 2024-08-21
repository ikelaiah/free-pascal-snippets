program StaticArrayDemo02;

{$mode objfpc}{$H+}{$J-}

uses
  {$IFDEF UNIX}
  cmem, cthreads,
  {$ENDIF}
  Classes;

type
  TSmallStrArray = array[0..2] of string; // Size is 3

var
  // Create an array var based on a static array type
  osList: TSmallStrArray = ('Linux', 'MacOS', 'Windows');

  // Declare a static array and init values
  browsers: array[0..5] of string = ('Chrome', 'Safari', 'Edge',
                                     'Firefox', 'Opera', 'Vivaldi');

  // An index variable for loops.
  index: integer;

begin

  // Print an element from an array
  WriteLn('First choice of OS is ', osList[0]);
  WriteLn('First choice of browser is ', browsers[0]);

  WriteLn('-- array of operating systems');

  // Print an array of operating systems
  for index := low(osList) to high(osList) do
    WriteLn(osList[index]);

  WriteLn('-- array of browser names');

  // Print an array of operating systems
  for index := low(browsers) to high(browsers) do
    WriteLn(browsers[index]);

  // Pause console
  WriteLn('Press enter key to quit');
  ReadLn;
end.
