program MormotKeyValueDemo;

{$mode objfpc}{$H+}{$modeswitch advancedrecords}

uses
  {$IFDEF UNIX}
  cmem, cthreads,
  {$ENDIF}
  Classes,
  SysUtils,
  mormot.core.collections;

type
  TDictionary = specialize IKeyValue<string, int64>;
  TDPair = specialize TPair<string, int64>;

var
  dict: TDictionary;
  pair: TDPair;
  aVal: int64;

begin

  dict := Collections.specialize NewKeyValue<string, int64>;
  aVal := 0;

  // Populate
  dict.Add('one', 1);
  dict.Add('two', 2);
  dict.Add('three', 3);
  dict.Add('four', 4);

  // Print the content
  for pair in dict do
    WriteLn('Key: ', pair.Key, ' Value: ', pair.Value);

  // Get a value
  WriteLn('The value of key one is ', dict.GetItem('one'));

  // Get value
  dict.TryGetValue('three', aVal);
  WriteLn('The value of key three is ', aVal);

  // Get value
  dict.TryGetValue('four', aVal);
  WriteLn('The value of key four is ', aVal);

end.
