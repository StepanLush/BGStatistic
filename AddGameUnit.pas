unit AddGameUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Constants, GamesList, MyList, FileUnit;

type
  TformGameAdd = class(TForm)
    btnAdd: TButton;
    editName: TLabeledEdit;
    editAge: TLabeledEdit;
    editTime: TLabeledEdit;
    editNumOfPlayers: TLabeledEdit;
    btnCancel: TButton;
    procedure btnAddClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure editNameKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure editAgeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure editTimeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure editNumOfPlayersKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure editNameChange(Sender: TObject);
    procedure editAgeChange(Sender: TObject);
    procedure editTimeChange(Sender: TObject);
    procedure editNumOfPlayersChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formGameAdd: TformGameAdd;

implementation
Uses MainUnit;

{$R *.dfm}


procedure TformGameAdd.btnAddClick(Sender: TObject);
Var
    PlayersList: TMyList;
    GameData: TGameData;
begin
    If not IsGmElemCreated(MyGamesList, editName.Text) then
    Begin
        CreateMyList(PlayersList);
        GameData.Name := editName.Text;
        GameData.LastDate := 0;
        GameData.Age := StrToInt(editAge.Text);
        GameData.Time := StrToInt(editTime.Text);
        GameData.NumOfPlayers := StrToInt(editNumOfPlayers.Text);
        AddElemGmList(MyGamesList,GameData, PlayersList);
        MainForm.cbGames.Items.Add(editName.Text);
        SaveGamesList(MyGamesList);
    End;
    Self.ModalResult := mrOk;
end;

Function CheckEdits(var editName, editAge, editTime, editNum: TLabeledEdit):Boolean;
Var
    AreFull: Boolean;
begin
    AreFull := True;
    if (Length(editName.Text) = 0) or (Length(editAge.Text) = 0) or (Length(editTime.Text) = 0) or (Length(editNum.Text) = 0) then
        AreFull := False;
    CheckEdits := AreFull;
end;

Procedure ActivateBtn(var editName, editAge, editTime, editNum: TLabeledEdit; btn: TButton);
Begin
    Btn.Enabled := False;
    if CheckEdits(editName, editAge, editTime, editNum) then
        Btn.Enabled := True;
End;

procedure TformGameAdd.btnCancelClick(Sender: TObject);
begin
    Self.ModalResult := mrCancel;
end;


procedure TformGameAdd.editNameChange(Sender: TObject);
begin
    ActivateBtn(editName, editAge, editTime, editNumOfPlayers, btnAdd);
end;

procedure TformGameAdd.editNameKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    //CheckKey(editName, Key);
end;


procedure TformGameAdd.editAgeChange(Sender: TObject);
begin
    ActivateBtn(editName, editAge, editTime, editNumOfPlayers, btnAdd);
end;

procedure TformGameAdd.editAgeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    //CheckKey(editAge, Key);
end;


procedure TformGameAdd.editTimeChange(Sender: TObject);
begin
    ActivateBtn(editName, editAge, editTime, editNumOfPlayers, btnAdd);
end;

procedure TformGameAdd.editTimeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    //CheckKey(editTime, Key);
end;

procedure TformGameAdd.FormShow(Sender: TObject);
begin
    editName.Text := '';
    editAge.Text := '0';
    editTime.Text := '5';
    editNumOfPlayers.Text := '1';
end;

procedure TformGameAdd.editNumOfPlayersChange(Sender: TObject);
begin
    ActivateBtn(editName, editAge, editTime, editNumOfPlayers, btnAdd);
end;

procedure TformGameAdd.editNumOfPlayersKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    //1CheckKey(editNumOfPlayers, Key);
end;

end.
