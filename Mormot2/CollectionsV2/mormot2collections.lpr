program mormot2collections;

{$mode objfpc}{$H+}{$modeSwitch advancedRecords}

uses
  {$IFDEF UNIX}
  cmem, cthreads,
  {$ENDIF}
  SysUtils,
  Classes,
  mormot.core.collections;

const
  MAX = 100000;

var
  i: integer;
  li: specialize IList<integer>;

begin
  // Create using a factory method
  // URL - https://blog.synopse.info/?post/2021/12/19/mORMot-2-Generics-and-Collections
  li := Collections.specialize NewList<integer>; // Need specialize here.

  // Set capacity of list
  li.Capacity := MAX;

  // populate with some data
  for i := 0 to MAX do
    li.Add(i);

  // Print result to screen
  for i in li do
    WriteLn(li[i]);

  ReadLn;
end. // no need to set li := nil or write any try..finally Free end; block
