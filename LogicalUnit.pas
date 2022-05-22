unit LogicalUnit;

interface


Uses System.SysUtils, Constants, Vcl.StdCtrls,Vcl.Menus, GamesList,Vcl.ComCtrls, Vcl.CheckLst,MyList;
    Procedure FillListBox(LB: TListBox;NumOfPl, Time, Age: Integer; SearchName: TShortStr);
    Procedure FillCB(CB: TComboBox);
    Procedure FillCollectionLB(LB: TListBox; Collection: TShortStr);
    Procedure FillPlayerCB(CB: TComboBox);
    Procedure FillGamesCB(CB: TComboBox);
    Procedure ResetLastDate(var List: TGamesList; Name: TShortStr; Date: TDateTime);
    Procedure AddPlayersToGameList(var List: TGamesList; Game: TShortStr; Players: TCheckListBox;  Winner: TShortStr);
    Procedure AddGameToPlayerList(var List: TPlayerList; Game: TShortStr; Players: TCheckListBox; Winner: TShortStr);
    Procedure GetNums(Pointer: PListElem; var NPlays: Integer;var NWins: Integer);
    Procedure GetNumDayPlays(var NPlays: Integer; Date: TDateTime);
    Procedure FillLVPlayerGames(LV: TListView; Player: TShortStr);
    Procedure FillLVPlayerWins(LV: TListView; Player: TShortStr);
    Procedure FillLVPlayerPlays(LV: TListView; Player: TShortStr);
    Function GetLastDate(Game: TShortStr): TDateTime;
    Function GetNumsOfPlays(Game: TShortStr): Integer;

implementation

    Function GetLastDate(Game: TShortStr): TDateTime;
    Var
        Pointer: PGame;
    Begin
        Pointer := MyGamesList.Head;
        While Pointer <> Nil do
        begin
            if Pointer.Data.Name = Game then
                Result := Int(Pointer.Data.LastDate);
            Pointer := Pointer.Next;
        end;
    End;

    Procedure FillLVPlayerGames(LV: TListView; Player: TShortStr);
    Var
        PPointer: PPlayer;
        GPointer: PListElem;
    Begin
        PPointer:= MyPlayers.Head;
        While PPointer <> Nil do
        begin
            If PPointer.Name = Player then
            begin
                GPointer := PPointer.Games.Head;
                While GPointer <> Nil do
                begin
                    with LV.Items.Add do
                    Begin
                        Caption := GPointer.Data.Name;
                        SubItems.Add(DateTimeToStr(GetLastDate(GPointer.Data.Name)));
                    End;
                    GPointer := GPointer.Next;
                end;
            end;
            PPointer := PPointer.Next;
        end;
    End;

    Procedure FillLVPlayerPlays(LV: TListView; Player: TShortStr);
    Var
        PPointer: PPlayer;
        GPointer: PListElem;
    Begin
        PPointer:= MyPlayers.Head;
        While PPointer <> Nil do
        begin
            If PPointer.Name = Player then
            begin
                GPointer := PPointer.Games.Head;
                While GPointer <> Nil do
                begin
                    with LV.Items.Add do
                    Begin
                        Caption := GPointer.Data.Name;
                        SubItems.Add(IntToStr(GPointer.Data.NumOfPlays));
                    End;
                    GPointer := GPointer.Next;
                end;
            end;
            PPointer := PPointer.Next;
        end;
    End;

    Procedure FillLVPlayerWins(LV: TListView; Player: TShortStr);
    Var
        PPointer: PPlayer;
        GPointer: PListElem;
    Begin
        PPointer:= MyPlayers.Head;
        While PPointer <> Nil do
        begin
            If PPointer.Name = Player then
            begin
                GPointer := PPointer.Games.Head;
                While GPointer <> Nil do
                begin
                    with LV.Items.Add do
                    Begin
                        Caption := GPointer.Data.Name;
                        SubItems.Add(IntToStr(GPointer.Data.NumOfWins));
                    End;
                    GPointer := GPointer.Next;
                end;
            end;
            PPointer := PPointer.Next;
        end;
    End;

    Function GetNumsOfPlays(Game: TShortStr): Integer;
    Var
        Num: Integer;
        Pointer: PDateRec;
        PGames: PWins;
    Begin
        Num := 0;
        Pointer := MyGamesDates.Head;
        While Pointer <> Nil do
        begin
            PGames := Pointer.Plays.Head;
            while PGames <> Nil do
            begin
                if PGames.Data.Game = Game then
                    Inc(Num);
                PGames := PGames.Next;
            end;
            Pointer := Pointer.Next;
        end;
        Result := Num;
    End;

    Procedure GetNums(Pointer: PListElem; var NPlays: Integer;var NWins: Integer);
    Begin
        NPlays := 0;
        NWins := 0;
        While Pointer <> Nil do
        begin
            NPlays := NPlays + Pointer.Data.NumOfPlays;
            NWins := NWins + Pointer.Data.NumOfWins;
            Pointer := Pointer.Next;
        end;
    End;

    Procedure ResetLastDate(var List: TGamesList; Name: TShortStr; Date: TDateTime);
    Var
        Pointer: PGame;
    Begin
        Pointer := List.Head;
        While pointer <> Nil do
        begin
            If Pointer.Data.Name = Name then
                Pointer.Data.LastDate := int(Date);
            Pointer := Pointer^.Next;
        end;
    End;

    Procedure FillListBox(LB: TListBox;NumOfPl, Time, Age: Integer; SearchName: TShortStr);
    Var
        Pointer: PGame;
    Begin
        Pointer := MyGamesList.Head;
        While Pointer <> Nil do
        begin
            If ((Pos(SearchName, Pointer^.Data.Name)<>0) or (Length(SearchName)= 0)) and (Time <= Pointer^.Data.Time) and
            (Age >= Pointer^.Data.Age) and (NumOfPl <= Pointer.Data.NumOfPlayers) then
                LB.Items.Add(Pointer^.Data.Name);

            Pointer := Pointer^.Next;
        end;
    End;

    Procedure FillCB(CB: TComboBox);
    Var
        Pointer: PCollection;
    Begin
        Pointer := MyCollections.Head;
        While Pointer <> Nil do
        Begin
            CB.Items.Add(Pointer^.Name);
            Pointer := Pointer^.Next;
        End;
    End;

    Procedure FillPlayerCB(CB: TComboBox);
    Var
        Pointer: PPlayer;
    Begin
        Pointer := MyPlayers.Head;
        While Pointer <> Nil do
        Begin
            CB.Items.Add(Pointer^.Name);
            Pointer := Pointer^.Next;
        End;
    End;

    Procedure FillGamesCB(CB: TComboBox);
    Var
        Pointer: PGame;
    Begin
        Pointer := MyGamesList.Head;
        While Pointer <> Nil do
        Begin
            CB.Items.Add(Pointer^.Data.Name);
            Pointer := Pointer^.Next;
        End;
    End;

    Procedure FillCollectionLB(LB: TListBox; Collection: TShortStr);
    Var
        Pointer1: PCollection;
        Pointer2: PElem;
    Begin
        Pointer1 := MyCollections.Head;
        While Pointer1 <> Nil do
        begin
            if Pointer1.Name = Collection then
            begin
                POinter2 := Pointer1^.Games.Head;
                while Pointer2 <> Nil do
                begin
                    LB.Items.Add(Pointer2^.Name);
                    Pointer2 := Pointer2^.Next;
                end;
                Break;
            end;
            Pointer1 := Pointer1^.Next;
        end;
    End;

    Procedure IncNumOfPlays(Pointer: PListElem);
    Begin
        While Pointer <> Nil do
        begin
            Inc(Pointer.Data.NumOfPlays);
            Pointer := Pointer.Next;
        end;
    End;

    Procedure IncPlayerWins(Pointer: PListElem; Name: TShortStr);
    Begin
        while Pointer <> Nil do
        begin
            If Pointer.Data.Name = Name then
                Inc(Pointer.Data.NumOfWins);
            Pointer := Pointer.Next;
        end;
    End;

    Procedure AddPlayersToGameList(var List: TGamesList; Game: TShortStr; Players: TCheckListBox; Winner: TShortStr);
    Var
        Pointer: PGame;
        I: Integer;
        Data: TListData;
    Begin
        Pointer:= List.Head;
        While Pointer <> Nil do
        begin
            If Pointer.Data.Name = Game then
            begin
                For I := 0 to Players.Items.Count-1 do
                begin
                    if Players.Checked[I] = True then
                    begin
                        Data.Name := Players.Items[I];
                        Data.NumOfPlays := 0;
                        Data.NumOfWins := 0;
                        AddElemMyList(Pointer.PlayerList, Data);
                    end;
                end;
                IncNumOfPlays(Pointer.PlayerList.Head);
                IncPlayerWins(Pointer.PlayerList.Head, Winner);
            end;
            Pointer := Pointer.Next;
        end;
    End;


    Procedure AddGameToPlayerList(var List: TPlayerList; Game: TShortStr; Players: TCheckListBox; Winner: TShortStr);
    Var
        Pointer: PPlayer;
        I: Integer;
        Data: TListData;
    Begin
        Pointer:= List.Head;
        While Pointer <> Nil do
        begin
            For I := 0 to Players.Items.Count-1 do
            begin
                if (Players.Checked[I] = True) and (Players.Items[I] = Pointer.Name) then
                begin
                    Data.Name := Game;
                    Data.NumOfPlays := 0;
                    Data.NumOfWins := 0;
                    AddElemMyList(Pointer.Games, Data);
                    IncNumOfPlays(Pointer.Games.Head);
                    if Pointer.Name = Winner then
                        IncPlayerWins(Pointer.Games.Head, Game);
                end;
            end;
            Pointer := Pointer.Next;
        end;
    End;

    Procedure GetNumDayPlays(var NPlays: Integer; Date: TDateTime);
    Var
        Pointer: PDateRec;
    Begin
        NPlays := 0;
        Pointer:= MyGamesDates.Head;
        While Pointer <> Nil do
        begin
            If int(Pointer.Data.Date) = int(Date) then
                NPlays := NPlays + Pointer.Data.NumOfPlays;
            Pointer := Pointer.Next;
        end;
    End;
end.
