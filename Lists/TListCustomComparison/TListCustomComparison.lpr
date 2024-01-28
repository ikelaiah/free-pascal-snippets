program TListCustomComparison;

{$mode objfpc}{$H+}{$modeSwitch advancedRecords}

uses
  Generics.Defaults,
  Generics.Collections,
  SysUtils,
  Math;

type
  TStudent = record
  var
    Name: string;
    age: byte;
    location: string;
  public
    constructor Create(newName: string; newAge: byte; newLocation: string);
    function ToString: string;
  end;

  constructor TStudent.Create(newName: string; newAge: byte; newLocation: string);
  begin
    self.Name := newName;
    self.age := newAge;
    self.location := newLocation;
  end;

  function TStudent.ToString: string;
  begin
    Result := 'Row data: ' + self.Name + ' ' + IntToStr(self.age) + ' ' + self.location;
  end;

type
  TStudentList = specialize TList<TStudent>;
  TStudentListComparer = specialize TComparer<TStudent>;


  // Custom comparison function for sorting by name - ascending
  function CompareName(constref LeftItem, RightItem: TStudent): integer;
  begin
    Result := CompareStr(LeftItem.Name, RightItem.Name);
  end;

  // Custom comparison function for sorting by age - ascending
  function CompareAge(constref LeftItem, RightItem: TStudent): integer;
  begin
    Result := CompareValue(LeftItem.age, RightItem.age);
  end;

var
  studentList: TStudentList;
  i: integer;

begin
  // Create a new generic list
  studentList := TStudentList.Create;
  try
    // Add some elements to the list by using Add or AddRange
    studentList.Add(TStudent.Create('Asher Mo', 10, 'Sydney'));
    studentList.AddRange(
      [TStudent.Create('Kezia Mo', 10, 'Sydney'),
      TStudent.Create('Irene Mo', 11, 'Sydney'),
      TStudent.Create('Jonah Mo', 12, 'Sydney'),
      TStudent.Create('Bob Yell', 13, 'Melbourne'),
      TStudent.Create('Luke Earthwalker', 9, 'Canberra')]
      );

    // Printing list on console
    WriteLn('-- Original list ------');
    for i := 0 to studentList.Count - 1 do
      Writeln(studentList[i].ToString);

    // Sort by TStudent.name
    studentList.Sort(TStudentListComparer.construct(@CompareName));

    // Iterate through the list
    WriteLn('-- Sorted by name ------');
    for i := 0 to studentList.Count - 1 do
      Writeln(studentList[i].ToString);

    // Sort by TStudent.age
    studentList.Sort(TStudentListComparer.construct(@CompareAge));

    // Iterate through the list
    WriteLn('-- Sorted by age ------');
    for i := 0 to studentList.Count - 1 do
      Writeln(studentList[i].ToString);

  finally
    // Free the memory used by the list
    studentList.Free;

  end;

  // Pausing console
  ReadLn;
end.
