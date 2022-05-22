unit CollectionList;

interface
Uses Constants, List;

    Procedure CreateCollectionList(var NewList: TCollectionList);
    Procedure AddElemCollectionList(var List: TCollectionList; Name: TShortStr; Games: TList);
    Procedure DeleteElemCollectionList(var List: TCollectionList; DelElem: TShortStr);
    Function IsElemCreated(var List: TCollectionList; Elem: TShortStr): Boolean;

implementation
    Function IsElemCreated(var List: TCollectionList; Elem: TShortStr): Boolean;
    Var
        Pointer: PCollection;
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

    Procedure CreateCollectionList;
    Begin
        With NewList do
        Begin
            Head := Nil;
            Tail := Nil;
        End;
    end;

    Procedure AddElemCollectionList;
    Var
        Pointer: PCollection;
    begin
        New(Pointer);
        Pointer.Name := Name;
        Pointer.Games := Games;
        Pointer.Next := Nil;
        With List do
        Begin
            if Tail <> nil then
                Tail^.Next := Pointer;
            Tail := Pointer;
            If Head = Nil then
                Head := Pointer;
        End;
    end;

    Procedure DeleteElemCollectionList;
    Var
        Pointer, Boof: PCollection;
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
                FreeList(Pointer.Games);
                Dispose(Pointer);
                Break
            end;
            Boof := Pointer;
        end;
    end;

end.
