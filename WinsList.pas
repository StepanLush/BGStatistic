unit WinsList;

interface
Uses Constants;

    Procedure CreateWinsList(var NewList: TWinsList);
    Procedure AddElemWinsList(var List: TWinsList; ListData: TWinsData);
    Procedure FreeWinsList(var List: TWinsList);

implementation

    Procedure CreateWinsList;
    Begin
        NewList.Head := Nil;
        NewList.Tail := Nil;
    end;

    Procedure AddElemWinsList;
    Var
        Pointer: PWins;
    begin
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

    Procedure FreeWinsList;
    Var
        Pointer, Boof: PWins;
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
