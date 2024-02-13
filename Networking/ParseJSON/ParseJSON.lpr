program ParseJSON;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes,
  // For making web requests
  opensslsockets,
  fphttpclient,
  // For parsing JSON data
  fpjson,
  jsonparser;

var
  url: string = 'https://dummyjson.com/users?limit=3'; // endpoint to get JSON mock data
  rawJson: string;       // a var to store raw JSON data
  arrayJson: TJSONArray; // a var for processing an array of JSON objects
  enumJson: TJSONEnum;   // an enum type for looping JSON arrays
  objJson: TJSONObject;  // a var for manipulating a JSON object

begin
  // Get the raw JSON data
  WriteLn('Contacting ', url, ' ...');
  rawJson := TFPHTTPClient.SimpleGet(url);


  // Next, get the users array as TJSONArray;
  // 1. convert the raw JSON data to TJSONData,
  // 2. find data called "users" (a JSON array as per dummyjson's structure) and
  // 3. cast as TJSONArray
  arrayJson := TJSONArray(GetJSON(rawJson).FindPath('users'));

  // Loop using the TJSONEnum
  for enumJson in arrayJson do
  begin
    // Cast the enum value (TJSONData) to TJSONObject
    objJson := TJSONObject(enumJson.Value);

    // Output a few pieces of data as example.
    WriteLn('id   : ', objJson.FindPath('id').AsString);
    WriteLn('name : ', objJson.FindPath('firstName').AsString, ' ', objJson.FindPath('lastName').AsString);
    WriteLn('phone: ', objJson.FindPath('phone').AsString);
    WriteLn('city : ', objJson.FindPath('address.city').AsString);
    WriteLn('state: ', objJson.FindPath('address.state').AsString);
    WriteLn('---');
  end;

  // Pause console
  WriteLn('Press enter key to exit...');
  ReadLn;
end.
