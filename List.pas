unit List;

interface
Uses Constants;

    Procedure CreateList(var NewList: TList);
    Procedure AddElemList(var List: TList; NewElem: TShortStr);
    Procedure DeleteElemList(var List: TList; DelElem: TShortStr);
    Procedure FreeList(var List: TList);

implementation

    Function IsElemCreated(var List: TList; Elem: TShortStr): Boolean;
    Var
        Pointer: PElem;
        ElemCreated: Boolean;
    begin
        Pointer := List.Head;
        ElemCreated := False;
        While Pointer <> Nil do
        begin
            If Pointer^.Name = Elem then ElemCreated := True;
            Pointer := Pointer^.Next;
        end;
        Result := ElemCreated;
    end;

    Procedure CreateList(var NewList: TList);
    Begin
        NewList.Head := Nil;
        NewList.Tail := Nil;
    end;

    Procedure AddElemList;
    Var
        Pointer: PElem;
    begin
        If not IsElemCreated(List, NewElem) then
        Begin
            New(Pointer);
            Pointer.Name := NewElem;
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

    Procedure DeleteElemList;
    Var
        Pointer, Boof: PElem;
    begin
        Boof := List.Head;
        if Boof.Name = DelElem then
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
            If Pointer^.Name = DelElem then
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

    Procedure FreeList;
    Var
        Pointer, Boof: PElem;
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
