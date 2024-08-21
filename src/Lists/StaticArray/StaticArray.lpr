program StaticArrayExample;

{$mode objfpc}{$H+}{$J-}

uses
  Generics.Collections;

type
  strListHelper = specialize TArrayHelper<string>;

var
  // Declaring a list of 6 elements
  strList: array[0..5] of string = ('Zero', 'Twenty', 'Thirty', 'Forty', 'Sixty', 'Fifty');
  i: integer;

begin
  // Printing out length
  WriteLn('The length is ', Length(strList));

  // Printing out list
  WriteLn('-- Original list ---');
  for i := 0 to High(strList) do WriteLn(strList[i]);

  // Modifying the first element
  // strList[0] will become 'Zero One'
  strList[0] := strList[0] + ' One';

  // Sorting ascending by default
  WriteLn('-- Sorting list ---');
  strListHelper.Sort(strList);

  // Printing out the modified list
  WriteLn('-- Sorted list ---');
  for i := 0 to High(strList) do WriteLn(strList[i]);

  // Pausing console, user can continue by pressing enter key
  ReadLn;
end.
