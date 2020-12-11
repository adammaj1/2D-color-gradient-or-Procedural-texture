object BitmapProperitiesDlg: TBitmapProperitiesDlg
  Left = 348
  Top = 161
  BorderStyle = bsDialog
  Caption = 'BitmapProperitiesDlg'
  ClientHeight = 433
  ClientWidth = 520
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    520
    433)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 505
    Height = 225
    Shape = bsFrame
  end
  object Label1: TLabel
    Left = 24
    Top = 32
    Width = 130
    Height = 13
    Caption = 'BitmapWidth=szerokosc=X '
  end
  object Label2: TLabel
    Left = 24
    Top = 80
    Width = 141
    Height = 13
    Caption = 'Bitmapa.Height=Wysokosc=Y'
  end
  object Label3: TLabel
    Left = 24
    Top = 280
    Width = 162
    Height = 13
    Caption = 'Pixel Format = pf32bit = True Color'
  end
  object Label4: TLabel
    Left = 376
    Top = 40
    Width = 50
    Height = 13
    Caption = 'w pixelach'
  end
  object WHRatioLabel: TLabel
    Left = 32
    Top = 158
    Width = 167
    Height = 13
    Caption = 'Widht/Height ratio integer ( piksele)'
  end
  object OKBtn: TButton
    Left = 47
    Top = 388
    Width = 75
    Height = 25
    Caption = 'OK and Paint'
    Default = True
    ModalResult = 1
    TabOrder = 0
    OnClick = OKBtnClick
  end
  object CancelBtn: TButton
    Left = 135
    Top = 388
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object Default: TButton
    Left = 232
    Top = 388
    Width = 81
    Height = 25
    Caption = 'Default'
    TabOrder = 2
    OnClick = DefaultClick
  end
  object BtmpWidthEdit: TEdit
    Left = 208
    Top = 32
    Width = 121
    Height = 21
    Anchors = [akTop, akRight]
    AutoSelect = False
    TabOrder = 3
    Text = '100'
    OnKeyPress = BtmpWidthEditKeyPress
  end
  object BtmpHeightEdit: TEdit
    Left = 208
    Top = 72
    Width = 121
    Height = 21
    TabOrder = 4
    Text = '100'
    OnKeyPress = BtmpHeightEditKeyPress
  end
  object ValueIWHRSText: TStaticText
    Left = 309
    Top = 163
    Width = 89
    Height = 17
    Caption = 'ValueIWHRSText'
    TabOrder = 5
  end
end
