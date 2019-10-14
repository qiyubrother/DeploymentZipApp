object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Deployment App'
  ClientHeight = 151
  ClientWidth = 634
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    634
    151)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 60
    Height = 13
    Caption = 'Zip FileName'
  end
  object Label2: TLabel
    Left = 8
    Top = 56
    Width = 70
    Height = 13
    Caption = 'Deployment to'
  end
  object btnRelease: TButton
    Left = 8
    Top = 110
    Width = 75
    Height = 25
    Caption = 'Release'
    TabOrder = 0
    OnClick = btnReleaseClick
  end
  object editUnzipTo: TEdit
    Left = 8
    Top = 75
    Width = 549
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
  end
  object ComboBoxFileName: TComboBox
    Left = 8
    Top = 27
    Width = 618
    Height = 21
    Style = csDropDownList
    Anchors = [akLeft, akTop, akRight]
    DropDownCount = 20
    TabOrder = 2
  end
  object btnC: TButton
    Left = 65
    Top = 55
    Width = 41
    Height = 19
    Caption = 'C:'
    TabOrder = 3
    OnClick = btnCClick
  end
  object btnBrowses: TButton
    Left = 559
    Top = 73
    Width = 67
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Browse...'
    TabOrder = 4
    OnClick = btnBrowsesClick
  end
  object btnAppPath: TButton
    Left = 105
    Top = 55
    Width = 41
    Height = 19
    Caption = '.'
    TabOrder = 5
    OnClick = btnAppPathClick
  end
  object btnOpen: TButton
    Left = 89
    Top = 110
    Width = 75
    Height = 25
    Caption = 'Open '
    TabOrder = 6
    OnClick = btnOpenClick
  end
  object btnShortLink: TButton
    Left = 170
    Top = 110
    Width = 167
    Height = 25
    Caption = 'Create Short Link To Desktop'
    TabOrder = 7
    OnClick = btnShortLinkClick
  end
end
