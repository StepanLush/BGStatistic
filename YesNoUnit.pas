unit YesNoUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TYNForm = class(TForm)
    Label1: TLabel;
    YesButton: TButton;
    NameButton: TButton;
    procedure YesButtonClick(Sender: TObject);
    procedure NameButtonClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  YNForm: TYNForm;

implementation

{$R *.dfm}



procedure TYNForm.NameButtonClick(Sender: TObject);
begin
    YNForm.Close;
end;

procedure TYNForm.YesButtonClick(Sender: TObject);
begin
    YNForm.Close;
end;

end.
