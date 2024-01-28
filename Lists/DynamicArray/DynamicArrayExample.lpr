program DynamicArrayExample;

{$mode objfpc}
{$H+}
{$modeswitch arrayoperators}

uses
  Generics.Collections;

type
  strListHelper= specialize TArrayHelper<string>;

var
  strList: array of string;
  i: integer;

begin

  // Set the length of the string
  SetLength(strList, 3);

  // Populating the content, of length 3
  strList := ['Zero', 'Twenty', 'Thirty'];

  // Append a literal array to the list
  // Now the length is 6!
  strList := strList + ['Forty', 'Sixty', 'Fifty'];

  // Printing out length
  WriteLn('The length is ', Length(strList));

  // Printing out list
  WriteLn('-- Original list ---');
  for i := Low(strList) to High(strList) do WriteLn(strList[i]);

  // Modifying the first element
  // strList[0] will become 'Zero One'
  strList[0] := strList[0] + ' One';

  // Sorting the array
  WriteLn('-- Sorting list ---');
  strListHelper.Sort(strList);

  // Printing out the modified list
  WriteLn('-- Sorted list ---');
  for i := Low(strList) to High(strList) do WriteLn(strList[i]);

  // Pausing console
  // user can continue by pressing enter key
  ReadLn;
end.
