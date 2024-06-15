unit Common;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Generics.Defaults, Generics.Collections, Math;


type
  // A record to hold student information.
  TStudent = record
    Name: string;
    id: integer;
  end;


type
  // A list to hold student records, along with a comparer for
  // sorting the list afterwards.
  TStudentList = specialize TList<TStudent>;
  TStudentListComparer = specialize TComparer<TStudent>;

type
  // A type of string list.
  TStrList = specialize TList<string>;

const
  // Number of maximum threads to use.
  maxThreads: int64 = 4;

var
  // This variable specifies the lowest index for student ID.
  // All threads will be reading from this variable and increase by one
  // for other threads to read from.
  // Hence, reading and increment of this variable MUST be done
  // from within a critical section to avoid race.
  startStudentID: int64 = 200000;

  // A list of TStudent records. All threads will write student names and
  // student IDs into this variable.
  // Hence, writing to this variable MUST be done from within
  // a critical section too.
  finalStudentList: TStudentList;

// Custom comparison function for sorting by name - ascending
function CompareID(const LeftItem, RightItem: TStudent): integer;

implementation

// Custom comparison function for sorting by student id - ascending
function CompareID(const LeftItem, RightItem: TStudent): integer;
begin
  Result := CompareValue(LeftItem.id, RightItem.id);
end;

end.
