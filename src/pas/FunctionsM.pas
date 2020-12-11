unit FunctionsM;
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

Interface // ***************************************************************
   uses Graphics, // type TColor
        Forms,    // TForm
        Math,     // function Max ,ArcCosH
        SysUtils,
        windows, //function RGB
        ColorM;


  // kolejnosc ma znaczenie ; poatrz optionsDlgM
  Type TFunctionType=(HSV=0,
                      AbsZ,
                      ArgZ,
                      Whirl, //spin,vortex
                      ReZ,

                      RePlusIm,
                      MaxReIm,
                      manhattan,
                      AbsReIm,
                      ImDivRe,

                      ImReDiv,
                      saddle,
                      sinusX,
                      Sinus,
                      SinusXY,
                      sinusXmY,
                      SinXSinY,
                      sinXYXY,
                      XorY,
                      XxorY,
                      XshlY,
                      XshrY,
                      XandY,
                      sqrtM,
                      Plasma,
                      ftMax);// the last type

       //
       {TInfo=record
                _ColorType:TColorType;
                _FunctionType:TFunctionType;
                Name:string;
             end;}


   Procedure Setup(FunctionType: TFunctionType;var kMin, kMax:integer);
   Procedure Draw(FunctionType:TFunctionType;ColorType:TColorType);
   Function Projection(center:TPoint;height:integer;x,y:integer;FunctionType:TFunctionType):integer;
   //
   var  FunctionType: TFunctionType;


Implementation  //*********************************************************

  uses mainM, bmpM;
  // ColorM;


 //----------------------------------------------------------------------
 Procedure Setup(FunctionType:TFunctionType;var kMin, kMax:integer);
  var  center:TPoint;
  begin
     kMin:=0;
     //
     center.X:=bitmapa.Width div 2;
     center.Y:=bitmapa.Height div 2;
     //
     case FunctionType of
            AbsZ:      kmax:=round(sqrt(2*sqr(center.X)));   //circles
            ArgZ:      kmax:=361; //   degrees from 0 to 360 = full turn
            ReZ:       kMax:=bitmapa.Height;
            saddle:    kMax:=5000;
            MaxReIm:   kMax:=center.x;
            AbsReIm:   kMaX:=bitmapa.Height;  //biomorph , change the number
            ImDivRe:   kMax:=bitmapa.Height;
            Sinus:     kMax:=bitmapa.Height;
            manhattan: kMax:=4*sqr(center.y);
            ImReDiv:   kMax:=1000;
            whirl:     kMax:=360; // degrees = full turn
            ftMax:     kMax:=10;
            else       kMax:=bitmapa.Height;
          end; // case
  end;

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Function Projection(center:TPoint;height:integer;x,y:integer;FunctionType:TFunctionType):integer;
  // F: C --> R
  //var r:extended; //radius
  begin

     case FunctionType of
            HSV:        result:= Point2Color(X,y);
            AbsZ:       result:=round(sqrt(sqr(X-center.X)+sqr(y-center.Y)));
            ArgZ:       result:=round(RadToDeg(Pi+ArcTan2(y-center.Y,center.X-x)));
            Whirl:      result:=round(sqrt(sqr(X-center.X)+sqr(y-center.Y))+RadToDeg(2*Pi+ArcTan2(y-center.Y,center.X-x)));
            ReZ:        result:=y ;  // horizontal lines
            Saddle:     result:=abs(sqr(x-center.X)-round(sqr(y-center.y) / 2)) ;
            RePlusIm:   result:=y+x;
            MaxReIm:    result:=max(abs(center.x-x),abs(center.Y-y)); // or
            AbsReIm:    result:=abs((center.x-x)*(center.Y-y));           // biomorph
            ImDivRe:    result:=floor(tan((center.Y-y) / (center.X-x+0.000001)));  //
            ImReDiv:    result:=y+x+(100*y div (x+1));
            manhattan:  result:=sqr(abs(center.X-x)+abs(center.Y-y));                                                              // ClientHeight*(sin+1)/2= [0,ClientHeight]

            sinusX:     result:=round(bitmapa.Width*sin(Pi*DegToRad(x)));
            Sinus:      result:=y+round(height*(sin(Pi*DegToRad(x))+1)/8);
            // sin   is in  [-1,+1]
            // (sin+1)      [0,2]
            // (sin+1)/2    [0,1]
            SinusXY:    result:=y+round(height*(sin(Pi*DegToRad(x + y))+1)/8);
            SinusXmY:   result:=y+round(height*(sin(Pi*DegToRad(x*y))+1)/8);
            SinXSinY:   result:=round(
                              (height
                              *
                              (2+sin(Pi*DegToRad(y)) + sin(Pi*DegToRad(x))))
                              /4
                              );//try to change numerical values
            sinXYXY:     result:=round
                              (
                                height
                                *
                                (2+sin(Pi*DegToRad(y)) + sin(Pi*DegToRad(x))+sin(Pi*DegToRad(x+y)))/8
                                );
            XorY:         result:=x or  y;
            XxorY:        result:=x xor y;
            XshlY:        result:=x shl y;
            XshrY:        result:=x shr y;
            XandY:        result:=x and y;
            sqrtM:        result:=round(sqrt(x*y)) ;
            ftMax:        result:=Round((center.Y-y) / sqr(center.X -x + 0.0001));
            plasma: result:=round(bitmapa.Width*sin(Pi*DegToRad(x)));
            else          result:=y; //
          end; // case
  end;

  //--------------------------------------------------------------
   Procedure Draw(FunctionType:TFunctionType;ColorType:TColorType);
    var x,y:integer;
        //r:integer;
        kolor:TColor;//integer;
        k, //index do wyboru koloru
        kmin,kMax:integer;
        center:TPoint;
    begin
        //
        center.X:=bitmapa.Width div 2;
        center.Y:=bitmapa.Height div 2;
        // oblicza kMIn i kMax
        setup(FunctionType,kMin,kMax);




            for y:=0 to bitmapa.height-1 do
              begin
                pLinia32bit:=bitmapa.ScanLine[y];
                for x:=0 to bitmapa.width-1 do
                  begin

                  //
                  k:= Projection(center,bitmapa.Height,x,y,FunctionType);
                  //zmienia kolor piksela
                  case ColorType of
                    TrueColor: if FunctionType=HSV then kolor:=k else kolor:=Rainbow(kMin,kMAx,k mod kmax);
                    Direct:    kolor:=k;
                    GrayScale: kolor:=GrayScaleF(Round((k*256) div kmax));
                    Pseudo8bit:kolor:=GivePseudo8bitColor(k mod 255);
                    BlackAndW: if odd(k) then kolor:=clBlack
                                         else kolor:=clWhite;
                  end; // case  TypKOloru }

                    //RGBA
                    plinia32bit[x].r:=GetRValue(kolor);
                    plinia32bit[x].g:=GetGValue(kolor);
                    plinia32bit[x].b:=GetBValue(kolor);
                  end; //for x
               end; // for y


  end; // procedure --------------



END.
