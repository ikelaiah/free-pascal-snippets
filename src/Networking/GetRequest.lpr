program GetRequest;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes,
  // For making web requests
  opensslsockets,
  fphttpclient;


var
  url: string = 'https://dummyjson.com/users?limit=3'; // endpoint to get JSON mock data
  rawJson: string; // a var to store raw JSON data

begin
  // Get the raw JSON data
  WriteLn('Contacting ', url, ' ...');
  rawJson := TFPHTTPClient.SimpleGet(url);

  // Display JSON on console
  WriteLn(rawJson);

  // Pause console
  WriteLn('Press enter key to exit...');
  ReadLn;
end.
