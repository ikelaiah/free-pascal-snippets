unit Common;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Generics.Defaults, Generics.Collections;

type
  TStudent = record
    Name: string;
    id: integer;
  end;

type
  TStudentList = specialize TList<TStudent>;
  TStudentListComparer = specialize TComparer<TStudent>;

type
  TStrList = specialize TList<string>;

const
  maxThreads: int64 = 4;

var
  // start of student ID to assign
  startStudentID: int64 = 200000;

  // A list of TStudent records
  finalStudentList: TStudentList;

// Custom comparison function for sorting by name - ascending
function CompareName(const LeftItem, RightItem: TStudent): integer;

implementation

// Custom comparison function for sorting by name - ascending
function CompareName(const LeftItem, RightItem: TStudent): integer;
begin
  Result := CompareStr(LeftItem.Name, RightItem.Name);
end;


end.
