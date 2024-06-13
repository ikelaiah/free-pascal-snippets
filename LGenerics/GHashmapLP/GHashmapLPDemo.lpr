program GHashmapLPDemo;

{$mode objfpc}{$H+}{$J-}

uses
  {$IFDEF UNIX}
  cmem, cthreads,
  {$ENDIF}
  Classes,
  lgHashMap,
  SysUtils;

type
  TDictionary = specialize TGHashMapLP<shortstring, int64>;

var
  dict: TDictionary;
  s:shortstring;

begin

  dict := TDictionary.Create;
  try
    dict.Add('One', 1);
    dict.Add('Two', 2);
    dict.Add('Three', 3);
    dict.Add('Four', 4);


    WriteLn('Printing key-value...');

    for s in dict.Keys do
    begin
      WriteLn('Key: ', s, ' Value: ', dict[s]);
    end;


  finally
    dict.Free;
  end;

  WriteLn('Press enter to exit');
  ReadLn;

end.
