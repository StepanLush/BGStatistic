program BGStatistics;

{$R *.dres}

uses
  Vcl.Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  Constants in 'Units\Types\Constants.pas',
  GamesList in 'Units\Types\GamesList.pas',
  MyList in 'Units\Types\MyList.pas',
  PlayerList in 'Units\Types\PlayerList.pas',
  List in 'Units\Types\List.pas',
  DateList in 'Units\Types\DateList.pas',
  CollectionList in 'Units\Types\CollectionList.pas',
  FileUnit in 'Units\FileUnit.pas',
  WinsList in 'Units\Types\WinsList.pas',
  AddGameUnit in 'Units\Forms\AddGameUnit.pas' {formGameAdd},
  CreateCollectionUnit in 'Units\Forms\CreateCollectionUnit.pas' {formCreateCollection},
  LogicalUnit in 'Units\LogicalUnit.pas',
  AddPlayUnit in 'Units\Forms\AddPlayUnit.pas' {formAddPlay},
  AddPlayerUnit in 'Units\Forms\AddPlayerUnit.pas' {formAddPlayer};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TformGameAdd, formGameAdd);
  Application.CreateForm(TformCreateCollection, formCreateCollection);
  Application.CreateForm(TformAddPlay, formAddPlay);
  Application.CreateForm(TformAddPlayer, formAddPlayer);
  Application.Run;
end.
