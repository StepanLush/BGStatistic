unit CreateCollectionUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Constants, List, CollectionList,
  FileUnit;

type
  TformCreateCollection = class(TForm)
    btnCreate: TButton;
    btnCancel: TButton;
    editCollection: TLabeledEdit;
    procedure editCollectionChange(Sender: TObject);
    procedure btnCreateClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formCreateCollection: TformCreateCollection;

implementation
Uses MainUnit, LogicalUnit;

{$R *.dfm}

procedure TformCreateCollection.btnCancelClick(Sender: TObject);
begin
    Self.ModalResult := mrCancel;
end;

procedure TformCreateCollection.btnCreateClick(Sender: TObject);
Var
    Games: TList;
    Test: TCollectionList;
begin
    CreateList(Games);
    If not IsElemCreated(MyCollections, editCollection.Text) then
    Begin
        AddElemCollectionList(MyCollections, editCollection.Text, Games);
        AddSubItem(MainForm.pmenuGames, MyCollections.Tail);
        SaveCollectionList(MyCollections);
        MainForm.cbCollection.Items.Clear;
        MainForm.cbCollection.Items.Add('');
        FillCB(MainForm.cbCollection);
    End;
    Self.ModalResult := mrOk;
end;

procedure TformCreateCollection.editCollectionChange(Sender: TObject);
begin
    btnCreate.Enabled := False;
    if Length(editCollection.Text) <> 0 then
        btnCreate.Enabled := True;
end;



procedure TformCreateCollection.FormShow(Sender: TObject);
begin
    editCollection.Text := '';
end;

end.
