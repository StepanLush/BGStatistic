unit FileUnit;

interface
Uses Constants, PlayerList, GamesList, CollectionList, MyList,List, DateList,WinsList, SysUtils;

    Procedure SavePlayersList(var List: TPlayerList);
    Procedure ReadPlayersList(var List: TPlayerList);
    Procedure SaveGamesList(var List: TGamesList);
    Procedure ReadGamesList(var List: TGamesList);
    Procedure SaveCollectionList(var List: TCollectionList);
    Procedure ReadCollectionList(var List: TCollectionList);
    Procedure SaveDateList(var List: TDateList);
    Procedure ReadDateList(var List: TDateList);

implementation

    // Процедура сохранения списка игроков в файл

    Procedure SavePlayersList(var List: TPlayerList);
    Var
        Pointer1: PPlayer;
        Pointer2: PListElem;
        F: Text;
        Path: String;
    Begin
        Path := ExtractFilePath(ParamStr(0)) + 'Players.txt';
        Assign(F,Path);
        ReWrite(F);
        Pointer1:= List.Head;
        While Pointer1 <> Nil do
        begin
            Writeln(F);
            Writeln(F,Pointer1^.Name);
            Pointer2 := Pointer1^.Games.Head;
            While Pointer2 <> Nil do
            begin
                Writeln(F,Pointer2.Data.Name);
                Writeln(F,Pointer2.Data.NumOfPlays);
                Writeln(F,Pointer2.Data.NumOfWins);
                Pointer2 := Pointer2^.Next;
            end;
            Pointer1 := Pointer1^.Next;
        end;
        CloseFile(F);
    End;

    // Процедура записи данных игроков из файла
    Procedure ReadPlayersList(var List: TPlayerList);
    Var
        PlayerName, Str: TShortStr;
        GamesData: TListData;
        Games: TMyList;
        F: Text;
        Path: String;
    Begin
        Path := ExtractFilePath(ParamStr(0)) + 'Players.txt';
        Assign(F,Path);
        If not FileExists(Path) then
        Begin
            Rewrite(F);
            Close(F);
        End;
        ReSet(F);
        CreatePlList(List);
        Readln(F);
        While not EOF(F) do
        begin
            Readln(F,PlayerName);
            CreateMyList(Games);
            Readln(F,Str);
            While Str <> '' do
            begin
                GamesData.Name := Str;
                Readln(F, Str);
                GamesData.NumOfPlays := StrToInt(Str);
                Readln(F,Str);
                GamesData.NumOfWins := StrToInt(Str);
                AddElemMyList(Games, GamesData);
                Readln(F,Str);
            end;
            AddElemPlList(List, PlayerName, Games);
        end;
        CloseFile(F);
    End;

    // Процедура сохранения списка игр в файл
    Procedure SaveGamesList(var List: TGamesList);
    Var
        Pointer1: PGame;
        Pointer2: PListElem;
        F: Text;
        Path: String;
    Begin
        Path := ExtractFilePath(ParamStr(0)) + 'Games.txt';
        Assign(F,Path);
        Rewrite(F);
        Pointer1:= List.Head;
        While Pointer1 <> Nil do
        begin
            Writeln(F);
            Writeln(F,Pointer1^.Data.Name);
            Writeln(F,Pointer1^.Data.LastDate);
            Writeln(F,Pointer1^.Data.Age);
            Writeln(F,Pointer1^.Data.Time);
            Writeln(F,Pointer1^.Data.NumOfPlayers);
            Pointer2 := Pointer1^.PlayerList.Head;
            While Pointer2 <> Nil do
            begin
                Writeln(F,Pointer2^.Data.Name);
                Writeln(F,IntToStr(Pointer2^.Data.NumOfPlays));
                Writeln(F,IntToStr(Pointer2^.Data.NumOfWins));
                Pointer2 := Pointer2^.Next;
            end;
            Pointer1 := Pointer1^.Next;
        end;
        CloseFile(F);
    End;

    Procedure ReadGamesList(var List: TGamesList);
    Var
        GameData: TGameData;
        Str: TShortStr;
        Players: TMyList;
        PlayerData: TListData;
        F: Text;
        Path: String;
    Begin
        Path := ExtractFilePath(ParamStr(0)) + 'Games.txt';
        Assign(F,Path);
        If not FileExists(Path) then
        Begin
            Rewrite(F);
            Close(F);
        End;
        Reset(F);
        CreateGmList(List);
        Readln(F);
        While not EOF(F) do
        begin
            Readln(F,GameData.Name);
            Readln(F,GameData.LastDate);
            Readln(F,GameData.Age);
            Readln(F,GameData.Time);
            Readln(F,GameData.NumOfPlayers);
            CreateMyList(Players);
            Readln(F,Str);
            While Str <> '' do
            begin
                PlayerData.Name := Str;
                Readln(F,Str);
                PlayerData.NumOfPlays := StrToInt(Str);
                Readln(F,Str);
                PlayerData.NumOfWins := StrToInt(Str);
                AddElemMyList(Players, PlayerData);
                Readln(F,Str);
            end;
            AddElemGmList(List, GameData, Players);
        end;
        CloseFile(F);
    End;

    Procedure SaveCollectionList(var List: TCollectionList);
    Var
        Pointer1: PCollection;
        Pointer2: PElem;
        F: Text;
        Path: String;
    Begin
        Path := ExtractFilePath(ParamStr(0)) + 'Collections.txt';
        Assign(F,Path);
        Rewrite(F);
        Pointer1:= List.Head;
        While Pointer1 <> Nil do
        begin
            Writeln(F);
            Writeln(F,Pointer1^.Name);
            Pointer2 := Pointer1^.Games.Head;
            While Pointer2 <> Nil do
            begin
                Writeln(F,Pointer2^.Name);
                Pointer2 := Pointer2^.Next;
            end;
            Pointer1 := Pointer1^.Next;
        end;
        CloseFile(F);
    End;

    Procedure ReadCollectionList(var List: TCollectionList);
    Var
        CollectionName, GameName, Str: TShortStr;
        Games: TList;
        F: Text;
        Path: String;
    Begin
        Path := ExtractFilePath(ParamStr(0))+'Collections.txt';
        If not FileExists(Path) then
        Begin
            FileCreate(Path);
            Exit
        End;
        Assign(F,Path);
        Reset(F);
        CreateCollectionList(List);
        Readln(F);
        While not EOF(F) do
        begin
            Readln(F,CollectionName);
            CreateList(Games);
            Readln(F,Str);
            While Str <> '' do
            begin
                GameName := Str;
                AddElemList(Games, GameName);
                Readln(F,Str);
            end;
            AddElemCollectionList(List, CollectionName, Games);
        end;
        CloseFile(F);
    End;


    // Работа с списками дат

    Procedure SaveDateList(var List: TDateList);
    Var
        Pointer1: PDateRec;
        Pointer2: PWins;
        F: Text;
        Path: String;
    Begin
        Path := ExtractFilePath(ParamStr(0))+'GamesDates.txt';
        Assign(F,Path);
        Rewrite(F);
        Pointer1:= List.Head;
        While Pointer1 <> Nil do
        begin
            Writeln(F);
            Writeln(F, Pointer1^.Data.Date);
            Writeln(F, Pointer1^.Data.NumOfPlays);
            Pointer2 := Pointer1^.Plays.Head;
            While Pointer2 <> Nil do
            begin
                Writeln(F, Pointer2^.Data.Game);
                Writeln(F, Pointer2^.Data.Winner);
                Pointer2 := Pointer2^.Next;
            end;
            Pointer1 := Pointer1^.Next;
        end;
        CloseFile(F);
    End;

    Procedure ReadDateList(var List: TDateList);
    Var
        Str: TShortStr;
        Winners: TWinsList;
        DateData: TDateData;
        PlaysData: TWinsData;
        F: Text;
        Path: String;
    Begin
        Path := ExtractFilePath(ParamStr(0))+'GamesDates.txt';
        Assign(F,Path);
        If not FileExists(Path) then
        Begin
            Rewrite(F);
            Close(F);
        End;
        Reset(F);
        CreateDateList(List);
        Readln(F);
        While not EOF(F) do
        begin
            Readln(F,DateData.Date);
            Readln(F,DateData.NumOfPlays);
            CreateWinsList(Winners);
            Readln(F,Str);
            While Str <> '' do
            begin
                PlaysData.Game := Str;
                Readln(F,Str);
                PlaysData.Winner  := Str;
                AddElemWinsList(Winners, PlaysData);
                Readln(F,Str);
            end;
            AddElemDateList(List, DateData, Winners);
        end;
        CloseFile(F);
    End;
end.
