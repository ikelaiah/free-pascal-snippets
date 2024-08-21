program RemoveTrailingChars;

{$mode objfpc}{$H+}{$J-}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes;

var
  cities: array of string = ('Sydney', 'Melbourne', 'Surabaya', 'Malang');
  city, line: string;

begin

  // Building a sentence using the array of string.
  line := 'I have been to the following cities: ';
  for city in cities do
    line := line + city + ', ';

  // Now, line has a trailing comma and a space at the end.
  WriteLn(line);

  // Here is a trick to remove additional characters at the end of a string
  // by Gustavo 'Gus' Carreno,  2024-03-16 @ 14:42.
  // Simply use SetLength(str, length(str) - n_chars_to_remove);
  // Source: https://discord.com/channels/570025060312547359/896807098518732901/1218403991092985877
  SetLength(line, length(line) - 2);

  // Finally, just add a dot.
  line := line + '.';
  WriteLn(line);

  // Pause console
  ReadLn;
end.
