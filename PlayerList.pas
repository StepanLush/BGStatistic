unit PlayerList;

interface
Uses Constants, MyList;


    Procedure CreatePlList(var NewList: TPlayerList);
    Procedure AddElemPlList(var List: TPlayerList; Name: TShortStr; Games: TMyList);
    Procedure DeleteElemPlList(var List: TPlayerList; DelElem: TShortStr);
    Function IsElemCreated(var List: TPlayerList; Elem: TShortStr): Boolean;

implementation
    Function IsElemCreated(var List: TPlayerList; Elem: TShortStr): Boolean;
    Var
        Pointer: PPlayer;
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

    Procedure CreatePlList;
    Begin
        With NewList do
        Begin
            Head := Nil;
            Tail := Nil;
        End;
    end;

    Procedure AddElemPlList;
    Var
        Pointer: PPlayer;
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

    Procedure DeleteElemPlList;
    Var
        Pointer, Boof: PPlayer;
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
                FreeMyList(Pointer.Games);
                Dispose(Pointer);
                Break
            end;
            Boof := Pointer;
        end;
    end;


end.
