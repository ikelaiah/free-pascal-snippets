program SimpleApiWebserver;

// References:
//  - https://medium.com/@marcusfernstrm/create-rest-apis-with-freepascal-441e4aa447b7
//  - https://www.youtube.com/watch?v=9N0cxI1Hp0U
//  - https://wiki.lazarus.freepascal.org/fpWeb_Tutorial#webserver-example

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cmem, cthreads,
  {$ENDIF}
  Classes,
  SysUtils,
  fphttpapp,
  HTTPDefs,
  httproute,
  fpjson,
  jsonparser;

  // Endpoint for getting the current timestamp
  procedure TimestampEndPoint(aRequest: TRequest; aResponse: TResponse);
  var
    json: TJSONObject;
  begin
    json := TJSONObject.Create;
    try
      json.Strings['timestamp'] := FormatDateTime('yyyy-mm-dd hh:nn:ss.z', Now);
      aResponse.Content := json.AsJSON;
      aResponse.Code := 200;
      aResponse.ContentType := 'application/json';
      aResponse.ContentLength := Length(aResponse.Content);
      aResponse.SendContent;
    finally
      json.Free;
    end;

  end;

  // An endpoint accepting a variable
  procedure GreetEndpoint(aRequest: TRequest; aResponse: TResponse);
  var
    json: TJSONObject;
  begin
    json := TJSONObject.Create;
    try
      json.Strings['message'] := 'Hello, ' + aRequest.RouteParams['name'];
      aResponse.Content := json.AsJSON;
      aResponse.Code := 200;
      aResponse.ContentType := 'application/json';
      aResponse.ContentLength := Length(aResponse.Content);
      aResponse.SendContent;
    finally
      json.Free;
    end;
  end;

  // An endpoint to handle unknown requests
  procedure ErrorEndPoint(aRequest: TRequest; aResponse: TResponse);
  begin
    aResponse.Content := '<h1>404!</h1><h3>How did you get here?</h3>';
    aResponse.Code := 404;
    aResponse.ContentType := 'text/html';
    aResponse.ContentLength := Length(aResponse.Content);
    aResponse.SendContent;
  end;


const
  port: integer = 8080;
  isThreaded: boolean = True;

begin

  // Set port
  Application.Port := port;
  // Set multi-threading
  Application.Threaded := isThreaded;

  // Setup routes
  HTTPRouter.RegisterRoute('/api/timestamp', rmGet, @TimestampEndPoint);
  HTTPRouter.RegisterRoute('/api/greet/:name', rmGet, @GreetEndpoint);
  HTTPRouter.RegisterRoute('/404', rmGet, @ErrorEndPoint, True);

  // Initialise and run, with a message
  Application.Initialize;
  WriteLn('== Server is running on port ', port, ' ===');
  Application.Run;

end.
