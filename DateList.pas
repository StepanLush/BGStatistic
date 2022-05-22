unit DateList;

interface

Uses Constants, WinsList;

    Procedure CreateDateList(var NewList: TDateList);
    Procedure AddElemDateList(var List: TDateList; ListData: TDateData; Wins: TWinsList);
    Procedure IncNumOfPlays(var List: TDateList; Elem: TDateTime);
    Procedure AddWinnerDateList(var List: TDateList; Date: TDateTime; Winner: TWinsData);

implementation

    Procedure IncNumOfPlays(var List: TDateList; Elem: TDateTime);
    Var
        DatePointer: PDateRec;
    Begin
        DatePointer := List.Head;
        While DatePointer <> Nil do
        begin
            If Int(DatePointer^.Data.Date) = Int(Elem) then
                Inc(DatePointer.Data.NumOfPlays);
            DatePointer := DatePointer.Next;
        end;
    End;

    Procedure AddWinnerDateList(var List: TDateList; Date: TDateTime; Winner: TWinsData);
    Var
        Pointer: PDateRec;
    Begin
        Pointer := List.Head;
        While Pointer <> Nil do
        begin
            If int(Pointer.Data.Date) = int(Date) then
                AddElemWinsList(Pointer^.Plays, Winner);
            Pointer := Pointer^.Next;
        end;
    End;


    Function IsElemCreated(var List: TDateList; Elem: TDateTime): Boolean;
    Var
        Pointer: PDateRec;
        ElemCreated: Boolean;
    begin
        Pointer := List.Head;
        ElemCreated := False;
        While Pointer <> Nil do
        begin
            If int(Pointer^.Data.Date) = int(Elem) then ElemCreated := True;
            Pointer := Pointer^.Next;
        end;
        Result := ElemCreated;
    end;

    Procedure CreateDateList;
    Begin
        NewList.Head := Nil;
        NewList.Tail := Nil;
    end;

    Procedure AddElemDateList;
    Var
        Pointer: PDateRec;
    begin
        If not IsElemCreated(List, ListData.Date) then
        Begin
            New(Pointer);
            Pointer.Data:= ListData;
            Pointer.Plays := Wins;
            Pointer.Next := Nil;
            With List do
            Begin
                if Tail <> nil then
                    Tail^.Next := Pointer;
                Tail := Pointer;
                If Head = Nil then
                    Head := Pointer;

            End;
        End;
    end;
end.
