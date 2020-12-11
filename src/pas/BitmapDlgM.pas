unit BitmapDlgM;


 {jêzyk: object Pascal
kompilator: VER ?
IDE: Borland Delphi 7.0 personal edition
styl programowania: obiektowy
metoda : wizualna (RAD)
biblioteki: standardowe =  VCL
OS: windows 98 SE
hardware: PC}
{ autor: Adam Majewski
        adammaj@mp.pl   }
// wa³brzych 19.03.20004

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,  Buttons, ExtCtrls, Mask,
      Dialogs; // ShowMessage

type
  TBitmapProperitiesDlg = class(TForm)
  // przyciski
    OKBtn: TButton;
    CancelBtn: TButton;
    Default: TButton;
  //
    Bevel1: TBevel;
  //
    BtmpWidthEdit: TEdit;
    BtmpHeightEdit: TEdit;
  //
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    WHRatioLabel: TLabel;
    ValueIWHRSText: TStaticText;
    //eWHRatioSText: TStaticText;
    //ValueEWHRSText: TStaticText;
    //DistortionSText: TStaticText;
    //ValueDistorsionSText: TStaticText;
  // procedury
    procedure DefaultBtmProper;
    //
    Procedure WpiszDaneDoTEdit;
    Procedure WyswietlInformacje;
    Procedure WczytajDaneZTEdit;
    //
    procedure FormCreate(Sender: TObject);
    // kontrola wprowadzania danych
    procedure BtmpWidthEditKeyPress(Sender: TObject; var Key: Char);
    procedure BtmpHeightEditKeyPress(Sender: TObject; var Key: Char);
    //

    procedure DefaultClick(Sender: TObject);
    //
    procedure OKBtnClick(Sender: TObject);
  end; // type TBitmapProperitiesDlg



var
  BitmapProperitiesDlg: TBitmapProperitiesDlg;


Implementation // ===================================================================================================================

uses MainM, // main window
      bmpM, // var  bitmapa, pLinia32bit, obszar
      ColorM,
      FunctionsM; // procedure rysuj

{$R *.dfm}

//---------------------------------------------------------------------------------------------------------------
 procedure TBitmapProperitiesDlg.DefaultBtmProper;
  Begin
     With Obszar.iObszar do {zmieniane przez okno Bitmapa}
                 begin
                    //
                    Left  :=  0;
                    Right :=bitmapa.Width-1;
                    Bottom:=  0;
                    Top   :=bitmapa.Height-1;
                    //
                  //  Bitmapa.Width  := Right - Left   + 1;	        { assign the initial width... }
                  //  Bitmapa.Height := Top   - Bottom + 1;          { ...and the initial height }
                end; //  With Obszar.iObszar

     //
     Bitmapa.PixelFormat:= pf32bit;
  End;
//-------------------------------------------------------------------------

Procedure TBitmapProperitiesDlg.WPiszDaneDoTEdit;
  Begin
     with obszar.eObszar,Obszar.iObszar do
        begin
          BtmpWidthEdit.Text:=IntToStr(Right-Left+1);
          BtmpHeightEdit.Text:=IntToStr(Top-Bottom+1);

        end;
  End;

//----------------------------------------------------------------------------
Procedure TBitmapProperitiesDlg.WyswietlInformacje;
  Begin
    with obszar.eObszar,Obszar.iObszar do
        begin

          // integer WH ratio
          ValueIWHRSText.caption:=FloatToStr((Right-Left+1)/(Top-Bottom+1));
          //  extended WH ratio
          //ValueEWHRSText.Caption:=FloatToStr((eRight-eLeft)/(eTop-eBottom));
          //  distorsion = eWHr/iWHr
         // ValueDistorsionSText.Caption:= FloatToStr(((eRight-eLeft)/(eTop-eBottom))/((Right-Left+1)/(Top-Bottom+1)));
        end;
  End;
// -------------------------------------------------------------------------------------
Procedure TBitmapProperitiesDlg.WczytajDaneZTEdit;
  Begin
     //okresla cechy bitmapy
    Bitmapa.Width:=StrToInt(BtmpWidthEdit.Text);
    Bitmapa.Height:=StrToInt(BtmpHeightEdit.Text);

    //
    With Obszar.iObszar do {zmieniane przez okno Bitmapa}
                 begin
                    Left  :=  0;
                    Right :=Bitmapa.Width - 1;
                    Bottom:=  0;
                    Top   :=Bitmapa.Height - 1;

                end; //  With Obszar.iObszar
    //aby pozosta³e procedury wczyta³y nowe dane ze zmiennej obszar
    MainForm.Image1.Picture.Graphic:=Bitmapa;
  End;

//------------------------------------------------------------------------------------
procedure TBitmapProperitiesDlg.FormCreate(Sender: TObject);
  // wpisuje wstepne ustalenia do okna dialogowego
  begin
     DefaultBtmProper;
     WpiszDaneDoTEdit;
     WyswietlInformacje;
  End;

//---------------------------------------------------------------------------------
// kontrola wprowadzania danych w oknach edycyjnych
//  only allows positive integers to be entered into the TEdit component

procedure TBitmapProperitiesDlg.BtmpWidthEditKeyPress(Sender: TObject;
  var Key: Char);
Begin
   if not (Key in [#8, '0'..'9']) then
      begin //Backspace is #8.
            ShowMessage('Z³y znak. Moze byc tylko dodatnia liczba calkowita ');
            Key := #0; //Pass in #0 to disregard the key after it's use.
      end;

End;
// ----------------------------------------------------------------------------------------
procedure TBitmapProperitiesDlg.BtmpHeightEditKeyPress(Sender: TObject;
  var Key: Char);
Begin
   if not (Key in [#8, '0'..'9']) then
      begin //Backspace is #8.
            ShowMessage('Z³y znak. Moze byc tylko dodatnia liczba calkowita');
            Key := #0; //Pass in #0 to disregard the key after it's use.
      end;

End; //




// --------------------------------------------------------------------------------------------------------------

procedure TBitmapProperitiesDlg.DefaultClick(Sender: TObject);
  Begin
     DefaultBtmProper;
     //
     WpiszDaneDOTEdit;
     WyswietlInformacje;

  End;  //  procedure TBitmapProperitiesDlg.DefaultClick
  // -------------------------------------------------------------------------------------------
procedure TBitmapProperitiesDlg.OKBtnClick(Sender: TObject);
  begin  {wczytuje wartosci z okna dialogowego }
    WczytajDaneZTEdit;
    // uaktualnia informacje tekstowe w oknie dialogowym
    WyswietlInformacje;

    //rysuje z nowymi danymi
    Draw(FunctionType,ColorType);
    //
    MainForm.Image1.Picture.Graphic:=bitmapa;
   // MainForm.Rysuj1Click(Sender);   //

  
  End; // procedure TBitmapProperitiesDlg.OKBtnClick(


END.
