unit bmpM;

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
//  http://republika.pl/fraktal/
// wa³brzych 19.03.2004
interface

uses Graphics, //TBitmap
     Types; //TRect

Type    Trgba=record b,g,r,a:byte end; // kolor 32 bitowy
        //pozioma linia obrazu, zawieraj¹ca kolor punktów (x,y) : Y=const
        TrgbaArray = array [0 .. MaxInt div SizeOf(Trgba)-1] of Trgba;
        PrgbaArray=^TrgbaArray;
        //-----------------------------------
         TePoint = record   eX, eY: extended;  end;   {TPoint with double coordinates}

         TeRect = record   eLeft, eTop, eRight, eBottom: extended;  end;

          TObszar = record iObszar:TRect;
                            eObszar:TeRect;
                    end;
        //-------------------------------------------------------

var  bitmapa:Tbitmap;
     pLinia32bit: PrgbaArray;
     //
     obszar:TObszar;

implementation

end.
