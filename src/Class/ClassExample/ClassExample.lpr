program ClassExample;

{$mode objfpc}{$H+}{$J-}

type
  // Define the class
  TPerson = class
  private
    FName: string;
    FAge: Integer;
  public
    constructor Create(const AName: string; AAge: integer);
    procedure DisplayInfo;
    property Name: string read FName write FName;
    property Age: Integer read FAge write FAge;
  end;

// Implementation of the constructor
constructor TPerson.Create(const AName: string; AAge: integer);
begin
  FName := AName;
  FAge := AAge;
end;

// Implementation of the method to display information
procedure TPerson.DisplayInfo;
begin
  WriteLn('Name: ', FName);
  WriteLn('Age: ', FAge);
end;

var
  Person: TPerson;

  { Main Block }
begin
  // Create an instance of TPerson
  Person := TPerson.Create('John Doe', 28);

  // Access properties
  Person.Name := 'Waldo Catto';
  Person.Age := 18;

  // Display information
  Person.DisplayInfo;

  // Free the memory used by the instance
  Person.Free;

  // Pause console
  WriteLn('Press enter key to quit');
  ReadLn;
end.
