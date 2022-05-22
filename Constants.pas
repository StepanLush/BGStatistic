unit Constants;

interface


Type
    TShortStr = String[20];

    // Список игр в которые играл, либо список игравших
    PListElem = ^TListElem;
    TListData = Record       // 28
        Name: TShortStr;
        NumOfPlays: Integer;
        NumOfWins: Integer;
    End;
    TListElem = Record
        Data: TListData;
        Next: PListElem
    End;
    TMyList = Record
        Head: PListElem;
        Tail: PListElem;
    End;

    // Список только с именем
    PElem = ^TElem;
    TElem = Record
        Name: TShortStr;
        Next: PElem;
    End;
    TList = Record
        Head: PElem;
        Tail: PElem;
    End;

    // Запись игрока с играми в которые он играл
    PPlayer = ^TPlayer;
    TPlayer = Record
        Name: TShortStr;
        Games: TMyList;
        Next: PPlayer;
    End;
    TPlayerList = Record
        Head: PPlayer;
        Tail: PPlayer;
    End;

    // Список игр и победителей
    PWins = ^TWinsRec;
    TWinsData = Record     // 40
        Game: TShortStr;
        Winner: TShortStr;
    End;
    TWinsRec = Record
        Data: TWinsData;
        Next: PWins;
    End;
    TWinsList = Record
        Head: PWins;
        Tail: PWins;
    End;

    // Список коллекций
    PCollection = ^TCollection;
    TCollection = Record
        Name: TShortStr;
        Games: TList;
        Next: PCollection;
    End;
    TCollectionList = Record
        Head: PCollection;
        Tail: PCollection;
    End;

    // Список дат
    PDateRec = ^TDateRec;
    TDateData = Record    // 10
        Date: TDateTime;
        NumOfPlays: Integer;
    End;
    TDateRec = Record
        Data: TDateData;
        Plays: TWinsList;
        Next: PDateRec;
    End;
    TDateList = Record
        Head: PDateRec;
        Tail: PDateRec;
    End;

    // Список игр для поиска
    PGame = ^TGame;
    TGameData = Record     // 38
        Name: TShortStr;
        LastDate: TDateTime;
        Age: Integer;
        Time: Integer;
        NumOfPlayers: Integer;
    End;
    TGame = Record
        Data: TGameData;
        PlayerList: TMyList;
        Next: PGame;
    End;
    TGamesList = Record
        Head: PGame;
        Tail: PGame;
    End;


    TArrStr = Array of TShortStr;


Var
    MyGamesList: TGamesList;
    MyCollections: TCollectionList;
    MyPlayers: TPlayerList;
    MyGamesDates: TDateList;


implementation

end.
