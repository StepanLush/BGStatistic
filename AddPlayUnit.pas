unit AddPlayUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.CheckLst, Constants, AddGameUnit, AddPlayerUnit;

type
  TformAddPlay = class(TForm)
    lGame: TLabel;
    cbGame: TComboBox;
    lWinner: TLabel;
    cbWinner: TComboBox;
    clbPlayers: TCheckListBox;
    lPlayers: TLabel;
    btnAdd: TButton;
    btnCancel: TButton;
    bntNewGame: TButton;
    btnNewPlayer: TButton;
    procedure btnAddClick(Sender: TObject);
    procedure cbGameChange(Sender: TObject);
    procedure cbWinnerChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure bntNewGameClick(Sender: TObject);
    procedure btnNewPlayerClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formAddPlay: TformAddPlay;

implementation

Uses mainUnit;
{$R *.dfm}

Procedure FillGamesCB(CB: TComboBox);
Var
    Pointer: PGame;
Begin
    Pointer := MyGamesList.Head;
    While Pointer <> Nil do
    begin
        CB.Items.Add(Pointer^.Data.Name);
        Pointer := Pointer.Next;
    end;
End;

Procedure FillPlayers(CB: TComboBox; CLB: TCheckListBox);
Var
    Pointer: PPlayer;
begin
    Pointer := MyPlayers.Head;
    While Pointer <> Nil do
    begin
        CB.Items.Add(Pointer^.Name);
        CLB.Items.Add(Pointer^.Name);
        Pointer := Pointer^.Next;
    end;
end;

Procedure ActivateBtn(btn: TButton; Game, Winner: TShortStr);
Begin
    if (Length(Game) > 0) and (Length(Winner) > 0) then
        btn.Enabled := True
    else
        btn.Enabled := False;
End;

procedure TformAddPlay.bntNewGameClick(Sender: TObject);
begin
    if formGameAdd.ShowModal = mrOk then
    begin
        cbGame.Items.Add(formGameAdd.editName.Text);
        MainForm.lbMyGames.Items.Add(formGameAdd.editName.Text);
    end;
end;

procedure TformAddPlay.btnAddClick(Sender: TObject);
begin
    clbPlayers.Checked[clbPlayers.Items.IndexOf(cbWinner.Text)] := True;
    Self.ModalResult := mrOk;
end;

procedure TformAddPlay.btnNewPlayerClick(Sender: TObject);
begin
    if formAddPlayer.ShowModal = mrOk then
    begin
        cbWinner.Items.Add(formAddPlayer.editNewPlayer.Text);
        clbPlayers.Items.Add(formAddPlayer.editNewPlayer.Text);
    end;
end;

procedure TformAddPlay.cbGameChange(Sender: TObject);
begin
    ActivateBtn(btnAdd, cbGame.Text, cbWinner.Text);
end;

procedure TformAddPlay.cbWinnerChange(Sender: TObject);
Var
    I: Integer;
begin
    I := clbPlayers.Items.IndexOf(cbWinner.Text);
    if I > -1 then
        clbPlayers.Checked[I] := True;
    ActivateBtn(btnAdd, cbGame.Text, cbWinner.Text);
end;

procedure TformAddPlay.FormShow(Sender: TObject);
begin
    cbGame.Items.Clear;
    cbGame.Text := '';
    cbWinner.Items.Clear;
    cbWinner.Text := '';
    clbPlayers.Items.Clear;
    FillGamesCB(cbGame);
    FillPlayers(cbWinner, clbPlayers);
end;

end.
