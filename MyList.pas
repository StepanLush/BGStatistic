unit MyList;

interface

Uses Constants;

    Procedure CreateMyList(var NewList: TMyList);
    Procedure AddElemMyList(var List: TMyList; ListData: TListData);
    Procedure DeleteElemMyList(var List: TMyList; DelElem: TShortStr);
    Procedure FreeMyList(Var List: TMyList);

implementation
    Function IsElemCreated(var List: TMyList; Elem: TShortStr): Boolean;
    Var
        Pointer: PListElem;
        ElemCreated: Boolean;
    begin
        Pointer := List.Head;
        ElemCreated := False;
        While Pointer <> Nil do
        begin
            If Pointer^.Data.Name = Elem then ElemCreated := True;
            Pointer := Pointer^.Next;
        end;
        Result := ElemCreated;
    end;

    Procedure CreateMyList;
    Begin
        With NewList do
        Begin
            Head := Nil;
            Tail := Nil;
        End;
    end;

    Procedure AddElemMyList;
    Var
        Pointer: PListElem;
    begin
        If not IsElemCreated(List, ListData.Name) then
        Begin
            New(Pointer);
            Pointer.Data := ListData;
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

    Procedure DeleteElemMyList;
    Var
        Pointer, Boof: PListElem;
    begin
        Boof := List.Head;
        if Boof.Data.Name = DelElem then
        begin
            List.Head := Boof.Next;
            if Boof = List.Tail then
                List.Tail := nil;
            Dispose(Boof);
            Exit
        end;
        While(Boof <> Nil) do
        begin
            Pointer := Boof^.Next;
            If Pointer^.Data.Name = DelElem then
            begin
                if Pointer = List.Tail then
                    List.Tail := Boof;
                Boof^.Next := Pointer.Next;
                Dispose(Pointer);
                Break
            end;
            Boof := Pointer;
        end;
    end;

    Procedure FreeMyList;
    Var
        Pointer, Boof: PListElem;
    Begin
        Pointer := List.Head;
        Boof := Pointer;
        While Boof <> Nil do
        begin
            Boof := Pointer^.Next;
            Dispose(Pointer);
            Pointer := Boof;
        end;
        List.Head := Nil;
        List.Tail := Nil;
    End;
end.
