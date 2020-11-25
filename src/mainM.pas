unit mainM;

{jêzyk: object Pascal
kompilator: VER ?
IDE: Borland Delphi 7.0 personal edition
styl programowania: obiektowy
metoda : wizualna (RAD)
biblioteki: standardowe =  VCL
OS: windows 98 SE
hardware: PC}
{ autor: Adam Majewski
        adammaj1@o2.pl   }
//  http://republika.pl/fraktal/
// wa³brzych 2005.05.07


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls, ExtDlgs, ComCtrls, StdCtrls,
  TypInfo;// getEnumName;

type TMainForm = class(TForm)
      ScrollBox1: TScrollBox;
      Image1: TImage;
      SavePictureDialog1: TSavePictureDialog;
      // Menu
      MainMenu1: TMainMenu;
        //
        File1: TMenuItem;
          Saveas1: TMenuItem;
        //
        Options1: TMenuItem;
        //
        Area1: TMenuItem;
        //
        help1: TMenuItem;
             About1: TMenuItem;
      //
    StatusBar1: TStatusBar;
    info1: TMenuItem;
    Help2: TMenuItem;
    OpenDialog1: TOpenDialog;



    // Main Window's procedures
    procedure FormCreate(Sender: TObject);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);

    // Menu File
     procedure Saveas1Click(Sender: TObject);
     //
     procedure Options1Click(Sender: TObject);
    //
    procedure Area1Click(Sender: TObject);
    //
    procedure help1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure info1Click(Sender: TObject);
    //keyboard
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

   //



   end;
   // ---------- TMainForm = class(TForm) ---------

 var   MainForm: TMainForm;

implementation

uses  // moje moduly
      bmpM, // var bitmapa,pLinia32bit
      BitmapDlgM,
      OptionsDlgM,
      FunctionsM,
      ColorM; //



{$R *.dfm}
//----------------------------------------------------
//----------- Main Window ------------------------------
//-----------------------------------------------------------

procedure TMainForm.FormCreate(Sender: TObject);

begin
    MainForm.WindowState:=wsMaximized;
    //to see bitmap greater then form
    MainForm.ScrollBox1.Align:=alClient;
    MainForm.Image1.AutoSize:=True;
    //
    bitmapa := TBitmap.Create;	{ construct the bitmap object }
    bitmapa.Width:=300;
    bitmapa.Height:=300;
    bitmapa.PixelFormat:=pf32bit;
    //
    BitmapProperitiesDlg.DefaultBtmProper;
    //
    FunctionType:=HSV;
    ColorType:=TrueColor;
    Draw(FunctionType,ColorType); // draw on the offscreen bitmap
    //display the bitmap on the screen
    MainForm.Image1.Picture.Graphic:=bitmapa;
    //
    SetupPPalette;
    //
    OpenDialog1.Title:='Open Fractint palette map file';
    OpenDialog1.DefaultExt:='map';
    openDialog1.Filter := 'Fractint palette map files *.map|*.map';
    openDialog1.InitialDir := GetCurrentDir;
    openDialog1.Options := [ofReadOnly,ofFileMustExist];

    //
    MainForm.Image1.Canvas.TextOut(10,10,'this program is for pf32bit mode = true color');
    //
    MainForm.StatusBar1.Panels.Items[0].Text:='k= ';
    MainForm.StatusBar1.Panels.Items[2].Text:='FunctionType:=';
    MainForm.StatusBar1.Panels.Items[3].Width:=20;
    MainForm.StatusBar1.Panels.Items[3].Text:=IntToStr(ord(FunctionType));
    MainForm.StatusBar1.Panels.Items[4].Width:=100;
    MainForm.StatusBar1.Panels.Items[4].Text:=getEnumName(typeInfo(TFunctionType),Ord(FunctionType) );
    MainForm.StatusBar1.Panels.Items[5].Width:=65;
    MainForm.StatusBar1.Panels.Items[5].Text:='ColorType:=';
    MainForm.StatusBar1.Panels.Items[6].Width:=20;
    MainForm.StatusBar1.Panels.Items[6].Text:=IntToStr(ord(ColorType));
    MainForm.StatusBar1.Panels.Items[7].Text:=getEnumName(typeInfo(TColorType),Ord(ColorType) );

end;
//\------------------------------------
 procedure TMainForm.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
  var center:TPoint;
      k,kMin,kMax:integer;
begin

  center.X:=bitmapa.Width div 2;
  center.Y:=bitmapa.Height div 2;
  //
  setup(FunctionType,kMin,kMax);
  k:=Projection(center,bitmapa.Height,X,Y,FunctionType);
  //MainForm.StatusBar1.Panels.Items[0].Text:='k= ';
  MainForm.StatusBar1.Panels.Items[1].Text:=IntToStr(k);


end; //-------------------------------

procedure TMainForm.FormKeyDown(Sender: TObject; var Key: Word;
            Shift: TShiftState);
begin
     //change function type
     if Shift=[ssShift]
      then
        case key of
          VK_UP: if ColorType<>low(ColorType)
                    then ColorType:=Pred(ColorType)
                    else ColorType:=High(ColorType); // loop
          VK_DOWN: if  ColorType<>High(ColorType)
                      then ColorType:=succ(ColorType)
                      else ColorType:=low(ColorType); //loop
        end// case
      else
        case Key of
          VK_UP: if  FunctionType<>low(functionType)
            then FunctionType:=Pred(FunctionType)
            else FunctionType:=high(functionType); //loop
          //--------------------------------
          VK_DOWN:if  FunctionType<>high(functionType)
            then FunctionType:= succ(FunctionType)
            else FunctionType:=low(functionType);//loop
          //----------------------
          VK_Left: //  Fractint palette map files
             begin
              if FindNext(SearchRec) = 0

                then
                  begin
                    ReadMapFile(SearchRec.Name);
                    //Draw;
                    MainForm.StatusBar1.Panels[8].Text:= SearchRec.Name
                  end //if FindNext(SearchRec) = 0 then ...

                else
                  if FindFirst('*.map',faAnyFile,SearchRec) =0
                      then // loop
                        begin
                          ReadMapFile(SearchRec.Name);
                          //Draw;
                          //Form1.Caption:= SearchRec.Name
                        end
                      else ShowMessage('No *.map file in the current directory');
               end;

        end; //case

     // draw new function on the offscreen bitmap
     Draw(FunctionType,ColorType);
    //display the bitmap on the screen
    MainForm.Image1.Picture.Graphic:=bitmapa;
    //change the item index in groups of Options Dlg form ( window)
    OptionsDlg.FunctionsGroup.ItemIndex:=ord(functionType);
    OptionsDlg.ColorGroup.ItemIndex:=ord(ColorType);
    //
    //status bar info
    MainForm.StatusBar1.Panels.Items[3].Text:=IntToStr(ord(FunctionType));
    MainForm.StatusBar1.Panels.Items[4].Text:=getEnumName(typeInfo(TFunctionType),Ord(FunctionType) );
    MainForm.StatusBar1.Panels.Items[6].Text:=IntToStr(ord(ColorType));
    MainForm.StatusBar1.Panels.Items[7].Text:=getEnumName(typeInfo(TColorType),Ord(ColorType) );
end;


//------------------------------------------------------------------------------
// ---------------  menu  ---------------------------------------------------
//--------------------------------------------------------------------------

//------------- subMenu File -------------------------------------------
procedure TMainForm.SaveAs1Click(Sender: TObject);
  begin
    SavePictureDialog1.Filter:='Bitmap  (*.bmp)|*.bmp';
        SavePictureDialog1.DefaultExt:='bmp';
        SavePictureDialog1.InitialDir:='';
        if SavePictureDialog1.Execute then
             // zapisuje bitmapê
            Image1.Picture.SaveToFile(SavePictureDialog1.FileName);

  end;
  //----------------
procedure TMainForm.Options1Click(Sender: TObject);
begin

   // display the dialog form
   OptionsDlg.ShowModal;
   // if OK buttom is pressed
   if optionsDlg.ModalResult=mrOk
    then Draw(FunctionType,ColorType); // draw on the offscreen bitmap
    //diplay the bitmap on the screen
    MainForm.Image1.Picture.Graphic:=bitmapa;
    //status bar info
    MainForm.StatusBar1.Panels.Items[3].Text:=IntToStr(ord(FunctionType));
    MainForm.StatusBar1.Panels.Items[4].Text:=getEnumName(typeInfo(TFunctionType),Ord(FunctionType) );
    MainForm.StatusBar1.Panels.Items[6].Text:=IntToStr(ord(ColorType));
    MainForm.StatusBar1.Panels.Items[7].Text:=getEnumName(typeInfo(TColorType),Ord(ColorType) );
    MainForm.StatusBar1.Panels.Items[8].Text:=MainForm.OpenDialog1.FileName;
end;






//---------------------------------------------------------
//-------------------------- Menu Area -----------------------------
//--------------------------------------------------------------



procedure TMainForm.Area1Click(Sender: TObject);
begin
     BitmapProperitiesDlg.ShowModal;
end;
//----------------------------------------------------
//------------------  Menu Help ------------------------]
//------------------------------------------------------------------
procedure TMainForm.help1Click(Sender: TObject);
begin

   //Application.HelpCommand(1,1);
end;





procedure TMainForm.About1Click(Sender: TObject);
begin
ShowMessage(
  'programming language: object Pascal'+char(13)+
  'compiler: VER ?'+char(13)+
  'IDE: Borland Delphi 7.0 personal edition http://www.borland.com'+char(13)+
  'style: objective'+char(13)+
  'method : vizual (RAD)'+char(13)+
  'library: standard =  VCL  '+char(13)+
  'OS: windows 98 SE '+char(13)+
  'hardware: PC '+char(13)+
  'licence: GPL'+char(13)+
  'language: english'+char(13)+
  'author of the program : Adam Majewski '+char(13)+
  'adammaj1-at-o2-dot-pl  http://republika.pl/fraktal/ '+char(13)+
  'thx for :'+char(13)+
  'FUNCTION HSVtoColor is from UNIT HSVLibrary;  efg, July 1999 www.efg2.com/lab '+char(13)+
  'Function Rainbow  Witold J.Janik;  '+char(13)+
  'plasma by Relsoft - Q Basic -cult magazine vol.4 issue 1 http://qbcm/hybd.net/issues/4-1/ '+char(13)
   +char(13)
   +char(13)+
  'pl - wa³brzych 2005.05.07'+char(13));
end;


procedure TMainForm.info1Click(Sender: TObject);
begin
   ShowMessage(
    'This program is for 32 bit color mode = True Color = pf32bit'+char(13)+
    'other modes are not tested'+char(13)+
    'but one can use fractint palette map files in pseudo 8 bit color mode,'+char(13)+
    'or use pseudo 1 bit color mode.'+char(13)+
    '----------------'+char(13)+
    'To change the function use: arrow up/down keys or menu'+char(13)+
    '----------------'+char(13)+
    'To change the color type use: shift+arrow up/down keys or menu'+char(13)+
     '----------------'+char(13)+
    'To change palette: first change tho color type to pseudo8bit '+char(13)+
    'and then click button open_palette_map_file and change the directory'+char(13)+
    'for that in which you store palette map files, click ok_and_draw button'+char(13)+
    'then change palette by using: left arrow button');
end;
// ----------------------------------------------------------------------




procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FindClose(searchRec);
end;

END.
