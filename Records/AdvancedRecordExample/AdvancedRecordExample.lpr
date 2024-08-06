program AdvancedRecordExample;

{$mode objfpc}{$H+}{$J-}
{$modeswitch advancedrecords}

type
  TRectangle = record
  private
    FWidth, FHeight: Double;
    procedure SetWidth(Value: Double);
    procedure SetHeight(Value: Double);
    function GetWidth: Double;
    function GetHeight: Double;
  public
    constructor Create(AWidth, AHeight: Double);
    function Area: Double;
    procedure ShowDetails;
    property Width: Double read GetWidth write SetWidth;
    property Height: Double read GetHeight write SetHeight;
  end;

constructor TRectangle.Create(AWidth, AHeight: Double);
begin
  FWidth := AWidth;
  FHeight := AHeight;
end;

procedure TRectangle.SetWidth(Value: Double);
begin
  FWidth := Value;
end;

procedure TRectangle.SetHeight(Value: Double);
begin
  FHeight := Value;
end;

function TRectangle.GetWidth: Double;
begin
  Result := FWidth;
end;

function TRectangle.GetHeight: Double;
begin
  Result := FHeight;
end;

function TRectangle.Area: Double;
begin
  Result := FWidth * FHeight;
end;

procedure TRectangle.ShowDetails;
begin
  WriteLn('Rectangle Width: ', FWidth:0:2);
  WriteLn('Rectangle Height: ', FHeight:0:2);
  WriteLn('Rectangle Area: ', Area:0:2);
end;

var
  Rect: TRectangle;

  { Main Block }
begin
  // Create a rectangle with width 10 and height 5
  Rect := TRectangle.Create(10, 5);

  // Show the details of the rectangle
  Rect.ShowDetails;

  // Pause console
  WriteLn('Press Enter to exit');
  ReadLn;
end.
