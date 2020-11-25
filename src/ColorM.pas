unit ColorM;
 {language: object Pascal
compiler: VER ?
IDE: Borland Delphi 7.0 personal edition
style: objective
method : vizual (RAD)
library: standard =  VCL
OS: windows 98 SE
hardware: PC}
{ author of the module : Adam Majewski         adammaj1@o2.pl  http://republika.pl/fraktal/ }
//
// FUNCTION HSVtoColor is from UNIT HSVLibrary;  efg, July 1999 www.efg2.com/lab
// Function Rainbow  Witold J.Janik; WJJ@CAD.PL
//
// pl - wa³brzych 2005.01.11

interface
 uses Graphics, // type TColor
        Forms,    // TForm
        Math,     // function Max ,ArcCosH
        SysUtils,
        windows; //function RGB


  //
  Type TColorType=(TrueColor=0,GrayScale,direct,Pseudo8bit,BlackAndW);
  Type PseudoColor= record _R,_G,_B:byte end;
  //
  FUNCTION HSVtoColor (CONST H,S,V:  INTEGER):  TColor;
  Function Point2Color(iX,iY:integer):TColor;
  Function Rainbow(iMin, iMax, i: Integer): TColor;
  Function GrayScaleF(i:byte):TColor;
  Function GivePseudo8bitColor(k:byte):TColor;
  Procedure SetupPPalette;
  Procedure ReadMapFile(FileName:string);
  //

// ----------------------------------------------------
var PseudoPalette:Array [0..255] of pseudoColor;
    ColorType:  TColorType;
    MapFile:TextFile;
    SearchRec:TSearchRec; // 
//-------------------------------------------------------------------------
implementation //--------------------------------------------------------
//--------------------------------------------------------------------------
  uses mainM, bmpM;

  FUNCTION HSVtoColor (CONST H,S,V:  INTEGER):  TColor;

  // from UNIT HSVLibrary;
// efg, July 1999
// www.efg2.com/lab
//
// Copyright 1999, All Rights Reserved.
// May be used freely for non-commercial purposes.
 // Integer Routines

  // Floating point fractions, 0..1, replaced with integer values, 0..255.
  // Use integer conversion ONLY for one-way, or a single final conversions.
  // Use floating-point for converting reversibly.
  //
  //  H = 0 to 360 (corresponding to 0..360 degrees around hexcone)
  //      0 (undefined) for S = 0
  //  S = 0 (shade of gray) to 255 (pure color)
  //  V = 0 (black) to 255 (white)

  //--------------------------------------------
  ////////////////////////////////////////////////////////////////////////////

    CONST
      divisor:  INTEGER = 255*60;
    VAR
      f    :  INTEGER;
      hTemp:  INTEGER;
      p,q,t:  INTEGER;
      VS   :  INTEGER;
  BEGIN
    IF   S = 0
    THEN RESULT := RGB(V, V, V)  // achromatic:  shades of gray
    ELSE BEGIN                              // chromatic color
      IF   H = 360
      THEN hTemp := 0
      ELSE hTemp := H;

      f     := hTemp MOD 60;     // f is IN [0, 59]
      hTemp := hTemp DIV 60;     // h is now IN [0,6)

      VS := V*S;
      p := V - VS DIV 255;                 // p = v * (1 - s)
      q := V - (VS*f) DIV divisor;         // q = v * (1 - s*f)
      t := V - (VS*(60 - f)) DIV divisor;  // t = v * (1 - s * (1 - f))

      CASE hTemp OF
        0:   RESULT := RGB(V, t, p);
        1:   RESULT := RGB(q, V, p);
        2:   RESULT := RGB(p, V, t);
        3:   RESULT := RGB(p, q, V);
        4:   RESULT := RGB(t, p, V);
        5:   RESULT := RGB(V, p, q);
        ELSE RESULT := RGB(0,0,0)  // should never happen;
                                              // avoid compiler warning
      END
    END
  END {HSVtoRGBTriple};

 //-------------------------------------------------------------------
Function Point2Color(iX,iY:integer):TColor;

var h,s:integer;
    center:Tpoint;
    radius:integer;
    v:integer;

begin
  //
  v:=255;
  //
  center.x:=Bitmapa.Width div 2;
  center.Y:=bitmapa.Height div 2;
  //
  radius:=round(sqrt(sqr(iX-center.X)+sqr(iy-center.Y)));
  if radius< center.y
    then {HSV circle}
          begin
            h:=round(RadToDeg(Pi+ArcTan2(iy-center.Y,center.X-ix))); // angle
            s:=round(radius*256/center.y);
            Point2Color:=HSVtoColor(h,s,v);
          end // if radius ...
      else  Point2Color:=clBlack; {black background }
end;//----- Function Point2Color ------------


//------------------------------------------------------------
  Function Rainbow(iMin, iMax, i: Integer): TColor;
   // Witold J.Janik; WJJ@CAD.PL
   // Funkcja Rainbow draws
  // rainbow while  [i] changes form [iMin] to [iMax]
  // thx for  Andrzeja W¹sika from [pl.comp.lang.delphi]
  //  http://4programmers.net/view.php?id=201
  //----------------------------------------------------
  // comments by  Adam Majewski
  // ka¿da sk³adowa RGB zmienia siê od 0 do 255(od $00 do $FF), czyli ma 256 mo¿liwych stanow
  //dzielimy palete na 6 paskow
  // gdyz oprocz:
  //        B&W czyli ($000000) & ($FFFFFF) oraz
  //        gray: r=g=b,
  //        (które nie wystêpuj¹ w têczy)
  //istnieje tylko 6 skrajnosci:
  //                3 kolory podstawowe: red ($FF0000), Green ($00FF00), Dark Blue ($0000FF)
  //                3 kolory mieszane: yellow ($FFFF00), fioletowy ($FF00FF), Light Blue ($00FFFF)
  //-----
  // i zmienia siê od iMin do iMax
  // m zmienia sie od 0 (dla i=iMin) do 6 (dla i=iMax)
  // mt zmienia siê od 0 do 255
  // trunc(mt) zmienia siê od 0 przez 1,2,3,4 do 5 (ma 6 wartosci}
  //--------------------------------------------------------------------------
  var
    m: Double; //odsetek ( u³amek)  * 6
    r, g, b,   // RGB parts of color
    mt: Byte;  // (decimal part of number m)* 255
    // trunc(m)= integer part of number m
  begin
    m := (i - iMin)/(iMax - iMin + 1)* 6;
    mt := round(frac(m)*$FF);
    case Trunc(m) of
      0: begin //from red ($FF0000) to yellow ($FFFF00)
            R := $FF;
            G := mt;
            B := 0;
          end;
      1: begin  // from yellow ($FFFF00) to green ($00FF00)
            R := $FF - mt;
            G := $FF;
            B := 0;
          end;
      2: begin  //from green ($00FF00) to light blue($00FFFF)
            R := 0;
            G := $FF;
            B := mt;
          end;
      3: begin // from light blue($00FFFF) to dark blue($0000FF)
            R := 0;
            G := $FF - mt;
            B := $FF;
          end;
      4: begin // from dark blue  ($0000FF) to violet ($FF00FF)
            R := mt;
            G := 0;
            B := $FF;
          end;
      5: begin  // from violet ($FF00FF) to red ($FF0000)
            R := $FF;
            G := 0;
            B := $FF - mt;
          end;
    end; // case

    Result := rgb(R,G,B);
end; //************      Function rainbow   *********************************
Function GrayScaleF(i:byte):TColor;

  begin
    result:=rgb(i,i,i);
  end;

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Function GivePseudo8bitColor(k:byte):TColor;
  begin
  //   r*$1000+g*$100+b;
    result:=$1000*PseudoPalette[k]._R+$100* PseudoPalette[k]._G+PseudoPalette[k]._B;
  end;
//-------------------------------------------
Procedure SetupPPalette;
  //Setup pseudopallette for Pseudo8bit color mode
var i:byte;
    a,b,c:single;
    m,n,o:integer;
    j,k,l:single;
begin
    //pallette that wraps around
    { maxColor / 2*Pi * frequency}
    j:=255/360*3;
    k:=255/360*2;
    l:=255/360;
    //
    a:=0;
    b:=0;
    c:=0;
    //
    For i:=0 to 255 do
          begin
            m:=Round(a);
            n:=round(b);
            o:=round(c);
            //
            PseudoPalette[i]._R:=round(256*abs(sin(m*pi/180)));
            PseudoPalette[i]._G:=round(256*abs(sin(n*pi/180)));
            PseudoPalette[i]._B:=round(256*abs(sin(o*pi/180)));
            //
            a:=a+j;
            b:=b+k;
            c:=c+l;
          end; //
end;
// ----------------------------------------------------------
Procedure ReadMapFile(FileName:string);
var  i:byte;
begin
  AssignFile(MapFile,FileName);
  Reset(MapFile); // open file only for read
  i:=0;
  While not Eof(MapFile) do
    begin
      // files with commentary #
      // or empty lines are not allowed buy this procedure
      ReadLn(MapFile, PseudoPalette[i]._R,PseudoPalette[i]._G,PseudoPalette[i]._B);
      inc(i);
    end; // While not Eof(PalFile)
end;
//--------------------------------------

end.
