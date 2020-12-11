unit OptionsDlgM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TOptionsDlg = class(TForm)
    FunctionsGroup: TRadioGroup;
    OKButton: TButton;
    CancelButton: TButton;
    ColorGroup: TRadioGroup;
    RadioGroup1: TRadioGroup;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    OpenMapButton: TButton;
    Edit1: TEdit;
    procedure OKButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure OpenMapButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ColorGroupClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var OptionsDlg: TOptionsDlg;

//----------------------------------------------------------
implementation //-------------------------------------------
//----------------------------------------------------------

uses  FunctionsM,
      ColorM,
      MainM;

{$R *.dfm}
//--------------------------------------------------------
procedure TOptionsDlg.OKButtonClick(Sender: TObject);

begin // reaction on choosing the radio button
  case OptionsDlg.FunctionsGroup.ItemIndex of
       0:FunctionType:=HSV;
       1:FunctionType:=AbsZ;
       2:FunctionType:=ArgZ;
       3:FunctionType:=Whirl;
       4:FunctionType:=ReZ;
       5:FunctionType:=RePlusIm;
       6:FunctionType:=MaxReIm;
       7:FunctionType:=Manhattan;
       8:FunctionType:=AbsReIm;
       9:FunctionType:=ImDivRe;
       10:FunctionType:=ImReDiv;
       11:FunctionType:=saddle;
       12:FunctionType:=SinusX;
       13:FunctionType:=Sinus;
       14:FunctionType:=SinusXY;
       15:FunctionType:=SinusXmY;
       16:FunctionType:=SinXSinY;
       17:FunctionType:=SinXYXY;
       18:FunctionType:=XorY;
       19:FunctionType:=XxorY;
       20:FunctionType:=XshlY;
       21:FunctionType:=XshrY;
       22:FunctionType:=XandY;
       23:FunctionType:=sqrtM;
       24:FunctionType:=plasma;
       25:FunctionType:=ftMax;

  end; {case functions}
  //
  case OptionsDlg.ColorGroup.ItemIndex of
       0:ColorType:=TrueColor;
       1:ColorType:=Direct;
       2:ColorType:=GrayScale;
       3:ColorType:=Pseudo8bit;
       4:ColorType:=BlackAndW;
  end; // case ColorGroup

  ModalResult:=mrOK; // close the form
end;
//----------------------------------------------------------
procedure TOptionsDlg.CancelButtonClick(Sender: TObject);

begin
  //cencel changes
  OptionsDlg.FunctionsGroup.ItemIndex:=ord(FunctionType);
  OptionsDlg.ColorGroup.ItemIndex:=ord(ColorType);
  //
  OptionsDlg.Close;
end;
//-----------------------------------------------------------------------

procedure TOptionsDlg.OpenMapButtonClick(Sender: TObject);


    //i:byte;

begin
   If MainForm.OpenDialog1.Execute
    then
      begin
        ReadMapFile( MainForm.OpenDialog1.FileName);
        // update SearchRec in case of change dir
        FindFirst('*.map',faAnyFile,SearchRec);
        MainForm.OpenDialog1.InitialDir := GetCurrentDir;
        OptionsDlg.Edit1.Text:=MainForm.OpenDialog1.FileName;
        CloseFile(MapFile);
      end; //  If OpenDialog1.Execute then

end;
//-----------------------------------------------------------------------
procedure TOptionsDlg.FormCreate(Sender: TObject);

begin
    OptionsDlg.OpenMapButton.Enabled:=false; // because  ColorType:=TrueColor
    //
    MainForm.OpenDialog1.Title:='Open Fractint palette map file';
    MainForm.OpenDialog1.DefaultExt:='map';
    MainForm.OpenDialog1.Filter:='Fractint palette map files *.map|*.map';
    MainForm.OpenDialog1.InitialDir:=GetCurrentDir;
    MainForm.OpenDialog1.Options:=[ofReadOnly,ofFileMustExist];
    
end;
//--------------------------------------------------------

procedure TOptionsDlg.ColorGroupClick(Sender: TObject);

begin
    case OptionsDlg.ColorGroup.ItemIndex of
       0:OptionsDlg.OpenMapButton.Enabled:=false;
       1:OptionsDlg.OpenMapButton.Enabled:=false;
       2:OptionsDlg.OpenMapButton.Enabled:=false;
       3:OptionsDlg.OpenMapButton.Enabled:=true; // because  ColorType:=Pseudo8bit
       4:OptionsDlg.OpenMapButton.Enabled:=false;
  end; // case ColorGroup
end;
//-----------------------------------------------------------


end.
