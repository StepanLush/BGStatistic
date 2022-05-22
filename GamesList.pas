unit GamesList;

interface

Uses Constants, MyList;

    Procedure CreateGmList(var NewList: TGamesList);
    Procedure AddElemGmList(var List: TGamesList; ListData: TGameData; PlayerList: TMyList);
    Procedure DeleteElemGmList(var List: TGamesList; DelElem: TShortStr);
    Function IsGmElemCreated(var List: TGamesList; Elem: TShortStr): Boolean;

implementation
    Function IsGmElemCreated(var List: TGamesList; Elem: TShortStr): Boolean;
    Var
        Pointer: PGame;
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

    Procedure CreateGmList;
    Begin
        With NewList do
        Begin
            Head := Nil;
            Tail := Nil;
        End;
    end;

    Procedure AddElemGmList;
    Var
        Pointer: PGame;
    begin
        New(Pointer);
        Pointer.Data := ListData;
        Pointer.PlayerList := PlayerList;
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

    Procedure DeleteElemGmList;
    Var
        Pointer, Boof: PGame;
    begin
        Boof := List.Head;
        if Boof.Data.Name = DelElem then
        begin
            List.Head := Boof.Next;
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
                FreeMyList(Pointer.PlayerList);
                Dispose(Pointer);
                Break
            end;
            Boof := Pointer;
        end;
    end;


end.
