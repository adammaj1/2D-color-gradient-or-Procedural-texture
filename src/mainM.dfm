object MainForm: TMainForm
  Left = 430
  Top = 100
  Width = 870
  Height = 640
  Caption = 'Rainbow version 20051021'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object ScrollBox1: TScrollBox
    Left = 0
    Top = 0
    Width = 862
    Height = 574
    Align = alClient
    TabOrder = 0
    object Image1: TImage
      Left = 13
      Top = 13
      Width = 618
      Height = 423
      AutoSize = True
      OnMouseMove = Image1MouseMove
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 574
    Width = 862
    Height = 20
    Panels = <
      item
        Width = 50
      end
      item
        Width = 100
      end
      item
        Width = 80
      end
      item
        Width = 50
      end
      item
        Width = 50
      end
      item
        Width = 50
      end
      item
        Width = 50
      end
      item
        Width = 80
      end
      item
        Width = 250
      end>
  end
  object MainMenu1: TMainMenu
    Left = 664
    Top = 488
    object File1: TMenuItem
      Caption = 'File'
      object Saveas1: TMenuItem
        Caption = 'Save as 24 bpp bmp'
        OnClick = Saveas1Click
      end
    end
    object Options1: TMenuItem
      Caption = 'Options'
      OnClick = Options1Click
    end
    object Area1: TMenuItem
      Caption = 'Area'
      OnClick = Area1Click
      object TMenuItem
      end
    end
    object help1: TMenuItem
      Caption = 'help'
      OnClick = help1Click
      object info1: TMenuItem
        Caption = 'info'
        OnClick = info1Click
      end
      object About1: TMenuItem
        Caption = 'About'
        OnClick = About1Click
      end
      object Help2: TMenuItem
        Caption = 'Help'
      end
    end
  end
  object SavePictureDialog1: TSavePictureDialog
    Left = 736
    Top = 488
  end
  object OpenDialog1: TOpenDialog
    Left = 792
    Top = 488
  end
end
