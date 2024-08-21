program StudentDataProcessor;

{$mode objfpc}{$H+}{$J-}
{$modeswitch anonymousfunctions}// Enable anonymous functions

type
  TStudent = record
    Name: string;
    Age: integer;
    Score: integer;
  end;

type
  TStudentList = array of TStudent;
  TStudentPredicate = function(student: TStudent): boolean;

var
  studentList: TStudentList;
  student: TStudent;
  filterStudents: function(arr: TStudentList;
  condition: TStudentPredicate): TStudentList;

begin
  // Initialize student data
  SetLength(studentList, 5);

  // Populate student data
  studentList[0].Name := 'Brent';
  studentList[0].Age := 20;
  studentList[0].Score := 85;
  studentList[1].Name := 'Dylan';
  studentList[1].Age := 22;
  studentList[1].Score := 90;
  studentList[2].Name := 'Jared';
  studentList[2].Age := 21;
  studentList[2].Score := 78;
  studentList[3].Name := 'Holly';
  studentList[3].Age := 20;
  studentList[3].Score := 92;
  studentList[4].Name := 'Julie';
  studentList[4].Age := 23;
  studentList[4].Score := 88;

  // Filters a list of students based on a given condition.
  // Returns a new list containing only the students that satisfy the condition.
  filterStudents := function(arr: TStudentList; condition: TStudentPredicate): TStudentList
  var
    resultArr: array of TStudent;
    i: integer;
  begin
    SetLength(resultArr, 0);
    for i := Low(arr) to High(arr) do if condition(arr[i]) then
      begin
        SetLength(resultArr, Length(resultArr) + 1);
        resultArr[High(resultArr)] := arr[i];
      end;
    Result := resultArr;
  end;


  // Using the anonymous function to filter studentList based on conditions
  Writeln('Students with score above 85:');
  for student in filterStudents(studentList, function(student: TStudent): boolean
                                             begin
                                               Result := student.Score > 85;
                                             end) do
    Writeln(student.Name, ' - ', student.Score);

  Writeln('Students aged 21 or below:');
  for student in filterStudents(studentList, function(student: TStudent): boolean
                                             begin
                                               Result := student.Age <= 21;
                                             end) do
    Writeln(student.Name, ' - ', student.Age);

  // Pause the console to view the output
  WriteLn('Press Enter to quit');
  ReadLn;
end.
