program Rainbow;

uses
  Forms,
  mainM in 'mainM.pas' {MainForm},
  bmpM in 'bmpM.pas',
  BitmapDlgM in 'BitmapDlgM.pas' {BitmapProperitiesDlg},
  OptionsDlgM in 'OptionsDlgM.pas' {OptionsDlg},
  FunctionsM in 'FunctionsM.pas',
  ColorM in 'ColorM.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Rainbow';
  Application.HelpFile := 'doc\Help.hlp';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TBitmapProperitiesDlg, BitmapProperitiesDlg);
  Application.CreateForm(TOptionsDlg, OptionsDlg);
  Application.Run;
end.
