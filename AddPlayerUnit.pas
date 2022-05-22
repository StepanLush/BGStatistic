unit AddPlayerUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Constants, PlayerList, MyList,
  FileUnit;

type
  TformAddPlayer = class(TForm)
    editNewPlayer: TLabeledEdit;
    btnAdd: TButton;
    btnCancel: TButton;
    procedure btnAddClick(Sender: TObject);
    procedure editNewPlayerChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formAddPlayer: TformAddPlayer;

implementation
Uses MainUnit, AddPlayUnit;

{$R *.dfm}
Procedure ActivateBtn(btn: TButton; Name: TShortStr);
Begin
    if (Length(Name) > 0) then
        btn.Enabled := True
    else
        btn.Enabled := False;
End;

procedure TformAddPlayer.btnAddClick(Sender: TObject);
Var
    Games: TMyList;
begin
    If Not IsElemCreated(MyPlayers, editNewPlayer.Text) then
    Begin
        CreateMyList(Games);
        AddElemPlList(MyPlayers, editNewPlayer.Text, Games);
        MainForm.cbPlayers.Items.Add(editNewPlayer.Text);
        SavePlayersList(MyPlayers);
    End;
end;

procedure TformAddPlayer.editNewPlayerChange(Sender: TObject);
begin
    ActivateBtn(btnAdd, editNewPlayer.Text);
end;



procedure TformAddPlayer.FormShow(Sender: TObject);
begin
    editNewPlayer.Text := '';
end;

end.
