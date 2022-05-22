unit MainUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus, Vcl.ComCtrls,
  Vcl.Grids, Vcl.Samples.Calendar, Vcl.OleCtrls, SHDocVw, VclTee.TeeGDIPlus,
  VCLTee.TeEngine, Vcl.ExtCtrls, VCLTee.TeeProcs, VCLTee.Chart, Vcl.CheckLst, FileUnit,CreateCollectionUnit, AddGameUnit,
  Constants, GamesList, CollectionList, PlayerList, DateList, Winslist, LogicalUnit,
  System.Actions, Vcl.ActnList, List, AddPlayUnit, AddPlayerUnit, VCLTee.Series;

type
  TMainForm = class(TForm)
    PageControl1: TPageControl;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    Label1: TLabel;
    lbMyGames: TListBox;
    editSearch: TEdit;
    UpDown1: TUpDown;
    NumEdit: TEdit;
    TimeLabel: TLabel;
    TrackBar1: TTrackBar;
    lTime: TLabel;
    lAge: TLabel;
    Label4: TLabel;
    TrackBar2: TTrackBar;
    Label3: TLabel;
    cbCollection: TComboBox;
    btnNewCollection: TButton;
    btnAddPlay: TButton;
    MonthCalendar1: TMonthCalendar;
    Label7: TLabel;
    cbPlayers: TComboBox;
    btnAddPlayer: TButton;
    TabSheet5: TTabSheet;
    lvDayPlays: TListView;
    radgrPlayer: TRadioGroup;
    lNumOfPlays: TLabel;
    lvPlayerStatistic: TListView;
    Label5: TLabel;
    cbGames: TComboBox;
    lLastPlay: TLabel;
    lNumPlays: TLabel;
    clbPlayers: TCheckListBox;
    Label6: TLabel;
    btnNewGame: TButton;
    ActionList1: TActionList;
    aFillLB: TAction;
    pmenuGames: TPopupMenu;
    popDelete: TMenuItem;
    popAdd: TMenuItem;
    aDeleteGame: TAction;
    aAddGameToCollection: TAction;
    aAddSubPopUp: TAction;
    aRemoveFromCollection: TAction;
    btnDeleteCollection: TButton;
    aDeleteCollection: TAction;
    aFillLVDayPlays: TAction;
    btnDeletePlayer: TButton;
    aDeletePlayer: TAction;
    aShowPlayerSt: TAction;
    aClearStats: TAction;
    chartPlays: TChart;
    Series1: TLineSeries;
    chartPlayer: TChart;
    Series2: TPieSeries;
    aClearGmStats: TAction;
    chartGame: TChart;
    Series3: TPieSeries;
    aShowGameStats: TAction;
    procedure btnNewGameClick(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnNewCollectionClick(Sender: TObject);
    procedure FillLBExecute(Sender: TObject);
    procedure UpDown1Click(Sender: TObject; Button: TUDBtnType);
    procedure editSearchChange(Sender: TObject);
    procedure popDeleteClick(Sender: TObject);
    procedure aDeleteGameExecute(Sender: TObject);
    procedure cbCollectionChange(Sender: TObject);
    procedure aAddGameToCollectionExecute(Sender: TObject);
    procedure aAddSubPopUpExecute(Sender: TObject);
    procedure aRemoveFromCollectionExecute(Sender: TObject);
    procedure aDeleteCollectionExecute(Sender: TObject);
    procedure btnDeleteCollectionClick(Sender: TObject);
    procedure btnAddPlayClick(Sender: TObject);
    procedure aFillLVDayPlaysExecute(Sender: TObject);
    procedure btnAddPlayerClick(Sender: TObject);
    procedure MonthCalendar1Click(Sender: TObject);
    procedure aDeletePlayerExecute(Sender: TObject);
    procedure btnDeletePlayerClick(Sender: TObject);
    procedure cbPlayersChange(Sender: TObject);
    procedure aShowPlayerStExecute(Sender: TObject);
    procedure aClearStatsExecute(Sender: TObject);
    procedure radgrPlayerClick(Sender: TObject);
    procedure cbGamesChange(Sender: TObject);
    procedure aClearGmStatsExecute(Sender: TObject);
    procedure aShowGameStatsExecute(Sender: TObject);
    procedure clbPlayersClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
    Procedure AddSubItem(Menu: TPopupMenu; Pointer: PCollection);
var
  MainForm: TMainForm;


implementation

{$R *.dfm}

Procedure ShowGraf(Series: TChartSeries);
Var
    I, NPlays: Integer;
    Date: TDateTime;
Begin
    Date := Now;
    For I := 0 to 29 do
    begin
        GetNumDayPlays(NPlays, Date-I);
        Series.Delete(I);
        Series.AddXY(Date-I, NPlays, '', clBlack);
    end;
End;



procedure TMainForm.FillLBExecute(Sender: TObject);
begin
    lbMyGames.Items.Clear;
    cbCollection.Text := '';
    FillListBox(lbMyGames, StrToInt(NumEdit.Text),StrToInt(lTime.Caption), StrToInt(lAge.Caption), editSearch.Text);
end;

procedure TMainForm.aAddGameToCollectionExecute(Sender: TObject);
Var
    Point: PCollection;
    p: Pointer;
    Str: String;
begin
    If lbMyGames.ItemIndex <> -1 then
    Begin
        P := Pointer((Sender as TMenuItem).Tag);
        Point := P;
        AddElemList(Point^.Games, lbMyGames.Items[lbMyGames.ItemIndex]);
        SaveCollectionList(MyCollections);
    End;
end;

Procedure AddSubItem(Menu: TPopupMenu; Pointer: PCollection);
Var
    Item: TMenuItem;
Begin
    If Pointer <> Nil then
    Begin
        Item := TMenuItem.Create(Menu);
        Item.OnClick := MainForm.aAddGameToCollectionExecute;
        Item.Caption := Pointer^.Name;
        Item.Tag := UIntPtr(Pointer);
        if Menu.Items.IndexOf(Item) < 0 then
            Menu.Items[1].Add(Item);
    End;
End;

Procedure AddItem(Menu: TPopUpMenu);
Var
    Item: TMenuItem;
Begin
    Item := TMenuItem.Create(Menu);
    Item.Caption := 'Remove';
    Item.OnClick := MainForm.aRemoveFromCollectionExecute;
    Menu.Items.Add(Item);
End;

procedure TMainForm.aAddSubPopUpExecute(Sender: TObject);
Var
    Item: TMenuItem;
    Pointer: PCollection;
begin
    Pointer := MyCollections.Head;
    While Pointer <> Nil do
    begin
        AddSubItem(pmenuGames, Pointer);
        Pointer := Pointer^.Next;
    end;
end;

procedure TMainForm.aClearGmStatsExecute(Sender: TObject);
begin
    lLastPlay.Caption := 'Last play:';
    lNumPlays.Caption := 'Number of plays:';
    clbPlayers.Items.Clear;
    chartGame.Series[0].Clear;
end;

procedure TMainForm.aClearStatsExecute(Sender: TObject);
begin
    lNumOfPlays.Caption := 'Number of plays:';
    lvPlayerStatistic.Columns[0].Caption := '';
    lvPlayerStatistic.Columns[1].Caption := '';
    chartPlayer.Axes.Clear;
    radgrPlayer.ItemIndex := 0;
    chartPlayer.Series[0].Clear;
    lvPlayerStatistic.Items.Clear;
end;

procedure TMainForm.aShowGameStatsExecute(Sender: TObject);
Var
    LastDate: TDateTime;
begin
    LastDate := GetLastDate(cbGames.Text);
    if LastDate <> 0 then
        lLastPlay.Caption := 'Last play:' + DateTimeToStr(LastDate);
    lNumPlays.Caption := 'Number of plays:' + IntToStr(GetNumsOfPlays(cbGames.Text));
end;

procedure TMainForm.aDeleteCollectionExecute(Sender: TObject);
begin
    DeleteElemCollectionList(MyCollections, cbCollection.Text);
    aFillLB.Execute;
    cbCollection.Items.Delete(cbCollection.Items.IndexOf(cbCollection.Text)+1);
    pmenuGames.Items.Delete(2);
    pmenuGames.Items[1].Clear;
    aAddSubPopUp.Execute;
    SaveCollectionList(MyCollections);
end;

procedure TMainForm.aDeleteGameExecute(Sender: TObject);
Var
    Pointer: PCollection;
begin
    If lbMyGames.ItemIndex <> -1 then
    Begin
        DeleteElemGmList(MyGamesList, lbMyGames.Items[lbMyGames.ItemIndex]);
        Pointer := MyCollections.Head;
        While Pointer <> Nil do
        begin
            If Pointer^.Games.Head <> nil then
                DeleteElemList(Pointer^.Games, lbMyGames.Items[lbMyGames.ItemIndex]);
            Pointer := Pointer.Next;
        end;
        If lbMyGames.Items[lbMyGames.ItemIndex] = cbGames.Text then
        Begin
            aClearGmStats.Execute;
            cbGames.Text := '';
        End;
        lbMyGames.Items.Delete(lbMyGames.ItemIndex);
        cbGames.Items.Clear;
        FillGamesCB(cbGames);
        SaveCollectionList(MyCollections);
        SaveGamesList(MyGamesList);
    End;
end;

procedure TMainForm.aDeletePlayerExecute(Sender: TObject);
begin
    DeleteElemPlList(MyPlayers, cbPlayers.Text);
    cbPlayers.Items.Clear;
    cbPlayers.Text := '';
    FillPlayerCB(cbPlayers);
    SavePlayersList(MyPlayers);
    btnDeletePlayer.Enabled := False;
end;

Function AddLVItem(LV: TListView; Pointer: PWins):TListItem;
Begin
    with LV.Items.Add do
    Begin
        Caption := Pointer^.Data.Game;
        SubItems.Add(Pointer^.Data.Winner);
    End;
End;

procedure TMainForm.aFillLVDayPlaysExecute(Sender: TObject);
Var
    Pointer: PDateRec;
    PlaysPointer: PWins;
begin
    lvDayPlays.Items.Clear;
    Pointer := MyGamesDates.Head;
    While Pointer <> Nil do
    begin
        If int(Pointer^.Data.Date) = int(MonthCalendar1.Date) then
        begin
            PlaysPointer := Pointer.Plays.Head;
            While PlaysPointer <> Nil do
            begin
                AddLVItem(lvDayPlays, PlaysPointer);
                PlaysPointer := PlaysPointer.Next;
            end;
        end;
        Pointer := Pointer.Next;
    end;
end;

procedure TMainForm.aRemoveFromCollectionExecute(Sender: TObject);
Var
    Pointer: PCollection;
begin
    Pointer := MyCollections.Head;
    While Pointer <> Nil do
    begin
        If Pointer^.Name = cbCollection.Text then
            DeleteElemList(Pointer^.Games, lbMyGames.Items[lbMyGames.ItemIndex]);
        Pointer := Pointer.Next;
    end;
    lbMyGames.Items.Delete(lbMyGames.ItemIndex);
    SaveCollectionList(MyCollections);
end;

procedure TMainForm.aShowPlayerStExecute(Sender: TObject);
Var
    Pointer: PPlayer;
    NPlays, NWins: Integer;
begin
    Pointer := MyPlayers.Head;
    While Pointer <> nil do
    begin
        if Pointer.Name = cbPlayers.Text then
        begin
            GetNums(Pointer.Games.Head, NPlays, NWins);
            lNumOfPlays.Caption := lNumOfPlays.Caption + IntToStr(NPlays);
            chartPlayer.Series[0].Clear;
            chartPlayer.Series[0].Add(NWins, 'Wins', clGreen);
            chartPlayer.Series[0].Add(NPlays - NWins, 'Losses', clRed);
        end;
        Pointer := Pointer.Next;
    end;
end;

procedure TMainForm.btnAddPlayClick(Sender: TObject);
Var
    DatePointer: PDateRec;
    DateData: TDateData;
    WinsData: TWinsData;
    Wins: TWinsList;
    Test: TPlayerList;
begin
    if formAddPlay.ShowModal = mrOk then
    begin
        // Информация даты
        DateData.Date := MonthCalendar1.Date;
        DateData.NumOfPlays := 0;
        WinsData.Game := formAddPlay.cbGame.Text;
        WinsData.Winner := formAddPlay.cbWinner.Text;
        CreateWinsList(Wins);
        AddElemDateList(MyGamesDates, DateData, Wins);
        AddWinnerDateList(MyGamesDates, DateData.Date, WinsData);
        IncNumOfPlays(MyGamesDates, DateData.Date);
        SaveDateList(MyGamesDates);
        ShowGraf(chartPlays.Series[0]);

        // Информация игр
        AddPlayersToGameList(MyGamesList, formAddPlay.cbGame.Text, formAddPlay.clbPlayers, formAddPlay.cbWinner.Text);
        ResetLastDate(MyGamesList, WinsData.Game, DateData.Date);
        SaveGamesList(MyGamesList);

        // Иформация игроков
        AddGameToPlayerList(MyPlayers, formAddPlay.cbGame.Text, formAddPlay.clbPlayers, formAddPlay.cbWinner.Text);
        Test := MyPlayers;
        SavePlayersList(MyPlayers);

        aFillLVDayPlays.Execute;
        aClearStats.Execute;
        aShowPlayerSt.Execute;
        lvPlayerStatistic.Items.Clear;
        radgrPlayer.ItemIndex := -1;

        aClearGmStats.Execute;
        cbGames.Text := '';
    end;
end;

procedure TMainForm.btnAddPlayerClick(Sender: TObject);
begin
    formAddPlayer.ShowModal;
end;

procedure TMainForm.btnDeleteCollectionClick(Sender: TObject);
begin
    aDeleteCollection.Execute;
    cbCollection.Clear;
    FillCB(cbCollection);
    btnDeleteCollection.Enabled := False;
end;

procedure TMainForm.btnDeletePlayerClick(Sender: TObject);
begin
    aDeletePlayer.Execute;
    aClearStats.Execute;
    radgrPlayer.ItemIndex := -1;
end;

procedure TMainForm.btnNewCollectionClick(Sender: TObject);
begin
    formCreateCollection.ShowModal;
end;

procedure TMainForm.btnNewGameClick(Sender: TObject);
VAr
Test: TGamesList;
begin
    formGameAdd.ShowModal;
    Test := MyGamesList;
    aFillLB.Execute;
end;



procedure TMainForm.cbCollectionChange(Sender: TObject);
begin
    If cbCollection.Text <> '' then
    Begin
        btnDeleteCollection.Enabled := True;
        lbMyGames.Items.Clear;
        if pmenuGames.Items.Count = 2 then
            AddItem(pmenuGames);
        FillCollectionLB(lbMyGames, cbCollection.Text);
    End else
    Begin
        btnDeleteCollection.Enabled := False;
        aFillLB.Execute;
        if pmenuGames.Items.Count = 3 then
            pmenuGames.Items[2].Destroy;
    End;
end;

Procedure FillCLBPlayers(CLB: TCheckListBox; Game: TShortStr);
Var
    Pointer: PGame;
    P: PListElem;
Begin
    Pointer := MyGamesList.Head;
    While Pointer <> Nil do
    begin
        if Pointer.Data.Name = Game then
        begin
            P := Pointer.PlayerList.Head;
            While P <> Nil do
            begin
                CLB.Items.Add(P.Data.Name);
                P := P.Next;
            end;
        end;
        Pointer := Pointer.Next;
    end;
End;

procedure TMainForm.cbGamesChange(Sender: TObject);
begin
    aClearGmStats.Execute;
    FillCLBPlayers(clbPlayers, cbGames.Text);

    if cbGames.Text <> '' then
        aShowGameStats.Execute;
end;

procedure TMainForm.cbPlayersChange(Sender: TObject);
begin
    aClearStats.Execute;
    FillLVPlayerGames(lvPlayerStatistic, cbPlayers.Text);
    lvPlayerStatistic.Columns[0].Caption := 'GAME';
    lvPlayerStatistic.Columns[1].Caption := 'LAST PLAY';
    if cbPlayers.Text <> '' then
    begin
        btnDeletePlayer.Enabled := True;
        aShowPlayerSt.Execute;
    end
    else
    begin
        btnDeletePlayer.Enabled := False;
    end;
end;

Procedure ShowPieDiagr(clb: TCheckListBox; chart: TChartSeries; Game:TShortStr);
Var
   I: Integer;
   Pointer: PGame;
   P: PListElem;
Begin
    Pointer := MyGamesList.Head;
    While Pointer <> Nil do
    begin
        If Pointer.Data.Name = Game then
            Break;
        Pointer := Pointer.Next;
    end;
    For I := 0 to clb.Items.Count - 1 do
    begin
        If clb.Checked[I] = True then
        begin
            P:= Pointer.PlayerList.Head;
            While P <> Nil do
            begin
                if P.Data.Name = clb.Items[I] then
                    chart.Add(P.Data.NumOfWins,clb.Items[I],15000*I);
                P := P.Next;
            end;
        end;
    end;
End;

procedure TMainForm.clbPlayersClick(Sender: TObject);
begin
    chartGame.Series[0].Clear;
    ShowPieDiagr(clbPlayers, chartGame.Series[0],cbGames.Text);
end;

procedure TMainForm.editSearchChange(Sender: TObject);
begin
    aFillLB.Execute;
end;



procedure TMainForm.FormCreate(Sender: TObject);
begin

    CreateGmList(MyGamesList);
    ReadGamesList(MyGamesList);
    FillGamesCB(cbGames);
    aFillLB.Execute;

    CreateCollectionList(MyCollections);
    ReadCollectionList(MyCollections);
    FillCB(cbCollection);
    aAddSubPopUp.Execute;

    CreatePlList(MyPlayers);
    ReadPlayersList(MyPlayers);
    FillPlayerCB(cbPlayers);

    CreateDateList(MyGamesDates);
    ReadDateList(MyGamesDates);

    MonthCalendar1.Date := Now;
    chartPlays.Axes.Bottom.Maximum := Now;
    chartPlayer.Axes.Bottom.Maximum := Now;
    chartPlays.Axes.Bottom.Minimum := Now-30;
    chartPlayer.Axes.Bottom.Minimum := Now - 30;
    ShowGraf(chartPlays.Series[0]);

    aFillLVDayPlays.Execute;
end;


procedure TMainForm.MonthCalendar1Click(Sender: TObject);
begin
    if int(MonthCalendar1.Date) <> int(Now) then
        btnAddPlay.Enabled := False
    else
        btnAddPlay.Enabled := True;
    aFillLVDayPlays.Execute;
end;

procedure TMainForm.popDeleteClick(Sender: TObject);
begin
    aDeleteGame.Execute();
end;



procedure TMainForm.radgrPlayerClick(Sender: TObject);
begin
    lvPlayerStatistic.Clear;
    case radgrPlayer.ItemIndex of
        0:begin
            FillLVPlayerGames(lvPlayerStatistic, cbPlayers.Text);
            lvPlayerStatistic.Columns[0].Caption := 'GAME';
            lvPlayerStatistic.Columns[1].Caption := 'LAST PLAY'
        end;
        1:Begin
            FillLVPlayerPlays(lvPlayerStatistic, cbPlayers.Text);
            lvPlayerStatistic.Columns[0].Caption := 'GAME';
            lvPlayerStatistic.Columns[1].Caption := 'NUMBER OF PLAYS';
        End;
        2:Begin
            FillLVPlayerWins(lvPlayerStatistic, cbPlayers.Text);
            lvPlayerStatistic.Columns[0].Caption := 'GAME';
            lvPlayerStatistic.Columns[1].Caption := 'NUMBER OF WINS';
        end;
    end;
end;

procedure TMainForm.TrackBar1Change(Sender: TObject);
begin
    lTime.Caption := IntToStr(TrackBar1.Position);
    aFillLB.Execute;
end;


procedure TMainForm.TrackBar2Change(Sender: TObject);
begin
    lAge.Caption := IntToStr(TrackBar2.Position);
    aFillLB.Execute;
end;


procedure TMainForm.UpDown1Click(Sender: TObject; Button: TUDBtnType);
begin
    aFillLB.Execute;
end;

end.
