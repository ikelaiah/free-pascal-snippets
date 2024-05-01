unit Common;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, lgVector;

type
  TStudent = record
    Name: string;
    id: integer;
  end;

type
  TStudentList = specialize TGLiteVector<TStudent>;
  TStrList = specialize TGLiteVector<string>;

var
  startStudentID: int64 = 200000;
  finalStudentList: TStudentList;

implementation

end.
