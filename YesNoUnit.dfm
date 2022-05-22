object YNForm: TYNForm
  Left = 0
  Top = 0
  Caption = '!'
  ClientHeight = 164
  ClientWidth = 328
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 56
    Top = 24
    Width = 3
    Height = 13
  end
  object YesButton: TButton
    Left = 24
    Top = 99
    Width = 105
    Height = 46
    Caption = 'Yes'
    TabOrder = 0
    OnClick = YesButtonClick
  end
  object NameButton: TButton
    Left = 192
    Top = 99
    Width = 105
    Height = 46
    Caption = 'No'
    TabOrder = 1
    OnClick = NameButtonClick
  end
end
