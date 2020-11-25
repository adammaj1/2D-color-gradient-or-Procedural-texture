object OptionsDlg: TOptionsDlg
  Left = 390
  Top = 163
  Width = 856
  Height = 713
  Caption = 'Options'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object FunctionsGroup: TRadioGroup
    Left = 16
    Top = 8
    Width = 241
    Height = 633
    Caption = 'Functions'
    ItemIndex = 0
    Items.Strings = (
      'HSV        = circles'
      'Abs(z)     = circles ( color = radius )'
      'Arg(Z)     = circles (color = phase, angle )'
      'Whirl'
      'Re(z)      = horizontal lines ( color = y = Im )'
      'Re + Im    = diagonal lines'
      'Max(Re,Im) = squers'
      'Manhattan  = turned squeres'
      'Abs(Re*Im) = biomorph'
      'Im div  Re    = 100*y div (x+1))'
      'ImReDiv    = y+x+(100*y div (x+1))'
      'saddle'
      'sinusX     = sinus (x)'
      'Sinus      = sinus(x)'
      'SinusXY    = sinux(X+Y)'
      'SinusXmY   = sinus(x*y)'
      'SinXSinY   = sin(x) + sin(y)'
      'SinXYXY    = sin(X)+sin(y)+Sin(x+y)'
      'or               = x or y  '
      'xor             = x xor y   '
      'shl             = x shl y'
      'shr            = x shr y'
      'and          =  x and y  '
      'sqrtM        = sqrt( x * y )'
      'plasma'
      'test ')
    TabOrder = 0
  end
  object OKButton: TButton
    Left = 16
    Top = 648
    Width = 241
    Height = 33
    Caption = 'OK and Draw'
    TabOrder = 1
    OnClick = OKButtonClick
  end
  object CancelButton: TButton
    Left = 464
    Top = 640
    Width = 113
    Height = 33
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = CancelButtonClick
  end
  object ColorGroup: TRadioGroup
    Left = 264
    Top = 16
    Width = 273
    Height = 337
    Caption = 'Type of Color'
    ItemIndex = 0
    Items.Strings = (
      'True Color  (RGBA = 16 mln of colours)'
      'Direct ( color = index)'
      'GrayScale ( 256 shades from white to black)'
      'Pseudo8bit ( 256 colors from fractint map file)'
      'Black and White ( 2 colors = 1 bit per pixel)')
    TabOrder = 3
    OnClick = ColorGroupClick
  end
  object RadioGroup1: TRadioGroup
    Left = 560
    Top = 24
    Width = 273
    Height = 329
    Caption = 'Type of Rainbow'
    TabOrder = 4
  end
  object RadioButton1: TRadioButton
    Left = 584
    Top = 80
    Width = 113
    Height = 17
    Caption = 'RadioButton1'
    TabOrder = 5
  end
  object RadioButton2: TRadioButton
    Left = 592
    Top = 144
    Width = 113
    Height = 17
    Caption = 'RadioButton2'
    TabOrder = 6
  end
  object RadioButton3: TRadioButton
    Left = 592
    Top = 208
    Width = 113
    Height = 17
    Caption = 'RadioButton3'
    TabOrder = 7
  end
  object RadioButton4: TRadioButton
    Left = 592
    Top = 288
    Width = 113
    Height = 17
    Caption = 'RadioButton4'
    TabOrder = 8
  end
  object RadioButton5: TRadioButton
    Left = 128
    Top = 376
    Width = 1
    Height = 33
    Caption = 'RadioButton5'
    TabOrder = 9
  end
  object OpenMapButton: TButton
    Left = 272
    Top = 464
    Width = 265
    Height = 49
    Caption = 'Open PaletteMap File'
    Enabled = False
    TabOrder = 10
    OnClick = OpenMapButtonClick
  end
  object Edit1: TEdit
    Left = 272
    Top = 384
    Width = 553
    Height = 21
    TabOrder = 11
    Text = 'Edit1'
  end
end
