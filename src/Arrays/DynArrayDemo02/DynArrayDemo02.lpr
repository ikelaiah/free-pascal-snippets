program DynArrayDemo02;

{$mode objfpc}{$H+}{$J-}

uses
  {$IFDEF UNIX}
  cmem, cthreads,
  {$ENDIF}
  Classes;

type
  TStringArray = array of string;

var
  // Create an array var based on a dynamic array type
  shoppingList: TStringArray = ('Corn Flakes', 'Eggs', 'Tea', 'Milk',
                                'Cheese', 'Tzatziki', 'Sausages', 'Olives',
                                'Bread', 'Garlic');

  // Declare a dynamic array and initialise values
  tofuList: array of string = ('Kinu-dofu', 'Momen-dofu',
                               'Iburi-dofu', 'Yuba');

  tempStr: string; // a string placeholder for loops.

begin

  WriteLn('-- array of shopping items');

  // Print the string array
  for tempStr in shoppingList do
    WriteLn(tempStr);

  WriteLn('-- array of japanese tofu names');

  // Print the string array
  for tempStr in tofuList do
    WriteLn(tempStr);

  // Pause console
  WriteLn('-------------------');
  WriteLn('Press enter to quit');
  ReadLn;
end.
