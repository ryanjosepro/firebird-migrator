object Frame1: TFrame1
  Left = 0
  Top = 0
  Width = 800
  Height = 458
  TabOrder = 0
  DesignSize = (
    800
    458)
  object LblProtocolAdmin: TLabel
    Left = 583
    Top = 56
    Width = 45
    Height = 13
    Anchors = [akTop, akRight]
    Caption = 'Protocolo'
    ExplicitLeft = 587
  end
  object LblHostAdmin: TLabel
    Left = 395
    Top = 102
    Width = 22
    Height = 13
    Anchors = [akTop, akRight]
    Caption = 'Host'
    ExplicitLeft = 399
  end
  object LblPortAdmin: TLabel
    Left = 583
    Top = 102
    Width = 26
    Height = 13
    Anchors = [akTop, akRight]
    Caption = 'Porta'
    ExplicitLeft = 587
  end
  object LblDbAdmin: TLabel
    Left = 5
    Top = 6
    Width = 46
    Height = 13
    Caption = 'Database'
  end
  object LblUserAdmin: TLabel
    Left = 3
    Top = 102
    Width = 36
    Height = 13
    Caption = 'Usu'#225'rio'
  end
  object LblPasswordAdmin: TLabel
    Left = 3
    Top = 150
    Width = 30
    Height = 13
    Caption = 'Senha'
  end
  object LblVersionAdmin: TLabel
    Left = 395
    Top = 4
    Width = 33
    Height = 13
    Anchors = [akTop, akRight]
    Caption = 'Vers'#227'o'
    ExplicitLeft = 397
  end
  object LblBackupFileAdmin: TLabel
    Left = 5
    Top = 52
    Width = 89
    Height = 13
    Caption = 'Arquivo de backup'
  end
  object LblDllAdmin: TLabel
    Left = 395
    Top = 150
    Width = 11
    Height = 13
    Anchors = [akTop, akRight]
    Caption = 'Dll'
    ExplicitLeft = 399
  end
  object LblLogAdmin: TLabel
    Left = 3
    Top = 247
    Width = 17
    Height = 13
    Caption = 'Log'
  end
  object CheckVerboseAdmin: TCheckBox
    Left = 736
    Top = 196
    Width = 62
    Height = 17
    Anchors = [akTop, akRight]
    Caption = 'Verbose'
    Checked = True
    State = cbChecked
    TabOrder = 0
  end
  object RadioGroupMethodAdmin: TRadioGroup
    Left = 676
    Top = 266
    Width = 122
    Height = 112
    Anchors = [akTop, akRight, akBottom]
    Caption = 'M'#233'todo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemIndex = 0
    Items.Strings = (
      'Backup'
      'Restore')
    ParentFont = False
    TabOrder = 1
  end
  object CheckListOptionsAdmin: TCheckListBox
    Left = 3
    Top = 196
    Width = 669
    Height = 50
    Columns = 4
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemHeight = 18
    Items.Strings = (
      'IgnoreChecksum'
      'IgnoreLim'
      'MetadataOnly'
      'NoGarbageCollect'
      'OldDescriptions'
      'NonTransportable'
      'Convert'
      'Expand')
    ParentFont = False
    TabOrder = 2
  end
  object BoxProtocolAdmin: TComboBox
    Left = 583
    Top = 75
    Width = 215
    Height = 21
    Anchors = [akTop, akRight]
    Enabled = False
    ItemIndex = 0
    TabOrder = 3
    Text = 'Local'
    Items.Strings = (
      'Local'
      'TCPIP'
      'NetBEUI'
      'SPX')
  end
  object TxtHostAdmin: TEdit
    Left = 395
    Top = 121
    Width = 182
    Height = 21
    Anchors = [akTop, akRight]
    Enabled = False
    TabOrder = 4
    Text = 'localhost'
  end
  object TxtPortAdmin: TEdit
    Left = 583
    Top = 121
    Width = 215
    Height = 21
    Anchors = [akTop, akRight]
    Enabled = False
    TabOrder = 5
    Text = '3050'
  end
  object TxtBackupFileAdmin: TNsEditBtn
    Left = 3
    Top = 71
    Width = 390
    Height = 21
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000232E0000232E00000000000000000001FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF72A6C04287AA
      4287AA4287AA4287AA4287AA4287AA4287AA4287AA4287AA4287AA4287AA4287
      AA72A6C0FFFFFFFFFFFF4F96B96AB7DA82CCED82CCED82CCED82CCED82CCED82
      CCED82CCED82CCED82CCED82CCED83CDEE5DA5C8BFD6E2FFFFFF5DA4C856AACE
      80CBEA7EC9E97EC9E97EC9E97EC9E97EC9E97EC9E97EC9E97EC9E97EC9E97EC9
      E970BBDC91BDD3FFFFFF62A9CC44A1CB8AD3EF83CDEB83CDEB83CDEB83CDEB83
      CDEB83CDEB83CDEB83CDEB83CDEB83CDEB87CFEC6CACCDFEFEFE66ADD052B0D7
      85D2ED89D2EE89D2EE89D2EE89D2EE89D2EE89D2EE89D2EE89D2EE89D2EE89D2
      EE90D8F16CB3D5E2EFF66AB1D474CAE875CAE890D8F28FD7F18FD7F18FD7F18F
      D7F18FD7F18FD7F18FD7F18FD7F18FD7F191D8F279C3E2B9DCEC6DB4D78FDDF4
      63C0E5A8EEFAA8EEFAA8EEFAA8EEFAA8EEFAA8EEFAA8EEFAA8EEFAA8EEFAA8EE
      FAA8EEFA96DDF18EC8E571B8DAA6ECFC64C2E94FB5E24DB4E24CB3E14BB2E049
      B1DF48B0DF47AEDE45ADDD44ACDD46AEDF389FD27EC2E49ED1EB74BADDABF0FE
      A4E9FCA2E7FB9FE5FA9CE3F89AE1F797DEF694DCF491D9F38ED7F18BD4F090D8
      F374BADDFFFFFFFFFFFF77BDDFADF1FFA6EBFDA4E9FCA2E7FB9FE5FA9CE3F89A
      E1F797DEF694DCF491D9F38ED7F193DAF477BDDFFFFFFFFFFFFF7ABFE1B0F4FF
      ADF1FFABF0FEA9EEFDA7ECFCA5EAFBA2E8FAA0E6F99DE3F89AE1F798DFF699E0
      F77ABFE1FFFFFFFFFFFF9DD1EA7CC1E37CC1E37CC1E37CC1E37CC1E37CC1E3FE
      FEFDF5F5EEEBEBDDFEC941F4B62E7CC1E39DD1EAFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFD1E9F57EC3E57EC3E57EC3E57EC3E57EC3E5D1E9
      F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
    TabOrder = 6
  end
  object MemoLogAdmin: TMemo
    Left = 3
    Top = 266
    Width = 667
    Height = 184
    Anchors = [akLeft, akTop, akRight, akBottom]
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 7
  end
  object BoxVersionAdmin: TComboBox
    Left = 395
    Top = 20
    Width = 403
    Height = 26
    Anchors = [akTop, akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemIndex = 0
    ParentFont = False
    TabOrder = 8
    Text = 'Firebird 2.1.7.18553'
    Items.Strings = (
      'Firebird 2.1.7.18553'
      'Firebird 2.5.8.27089'
      'Firebird 3.0.4.33054'
      'Firebird 4.0.0.19630')
  end
  object BtnStartAdmin: TButton
    Left = 676
    Top = 384
    Width = 122
    Height = 66
    Anchors = [akRight, akBottom]
    Caption = 'Iniciar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
  end
  object TxtDllAdmin: TNsEditBtn
    Left = 395
    Top = 169
    Width = 403
    Height = 21
    Anchors = [akTop, akRight]
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000232E0000232E00000000000000000001FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF72A6C04287AA
      4287AA4287AA4287AA4287AA4287AA4287AA4287AA4287AA4287AA4287AA4287
      AA72A6C0FFFFFFFFFFFF4F96B96AB7DA82CCED82CCED82CCED82CCED82CCED82
      CCED82CCED82CCED82CCED82CCED83CDEE5DA5C8BFD6E2FFFFFF5DA4C856AACE
      80CBEA7EC9E97EC9E97EC9E97EC9E97EC9E97EC9E97EC9E97EC9E97EC9E97EC9
      E970BBDC91BDD3FFFFFF62A9CC44A1CB8AD3EF83CDEB83CDEB83CDEB83CDEB83
      CDEB83CDEB83CDEB83CDEB83CDEB83CDEB87CFEC6CACCDFEFEFE66ADD052B0D7
      85D2ED89D2EE89D2EE89D2EE89D2EE89D2EE89D2EE89D2EE89D2EE89D2EE89D2
      EE90D8F16CB3D5E2EFF66AB1D474CAE875CAE890D8F28FD7F18FD7F18FD7F18F
      D7F18FD7F18FD7F18FD7F18FD7F18FD7F191D8F279C3E2B9DCEC6DB4D78FDDF4
      63C0E5A8EEFAA8EEFAA8EEFAA8EEFAA8EEFAA8EEFAA8EEFAA8EEFAA8EEFAA8EE
      FAA8EEFA96DDF18EC8E571B8DAA6ECFC64C2E94FB5E24DB4E24CB3E14BB2E049
      B1DF48B0DF47AEDE45ADDD44ACDD46AEDF389FD27EC2E49ED1EB74BADDABF0FE
      A4E9FCA2E7FB9FE5FA9CE3F89AE1F797DEF694DCF491D9F38ED7F18BD4F090D8
      F374BADDFFFFFFFFFFFF77BDDFADF1FFA6EBFDA4E9FCA2E7FB9FE5FA9CE3F89A
      E1F797DEF694DCF491D9F38ED7F193DAF477BDDFFFFFFFFFFFFF7ABFE1B0F4FF
      ADF1FFABF0FEA9EEFDA7ECFCA5EAFBA2E8FAA0E6F99DE3F89AE1F798DFF699E0
      F77ABFE1FFFFFFFFFFFF9DD1EA7CC1E37CC1E37CC1E37CC1E37CC1E37CC1E3FE
      FEFDF5F5EEEBEBDDFEC941F4B62E7CC1E39DD1EAFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFD1E9F57EC3E57EC3E57EC3E57EC3E57EC3E5D1E9
      F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
    TabOrder = 10
  end
  object RadioGroupConnMethodAdmin: TRadioGroup
    Left = 395
    Top = 56
    Width = 182
    Height = 40
    Anchors = [akTop, akRight]
    Caption = 'M'#233'todo de Conex'#227'o'
    Columns = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemIndex = 0
    Items.Strings = (
      'Rede'
      'Embedded')
    ParentFont = False
    TabOrder = 11
  end
  object TxtPasswordAdmin: TEdit
    Left = 3
    Top = 169
    Width = 390
    Height = 21
    PasswordChar = '*'
    TabOrder = 12
    Text = 'masterkey'
  end
  object TxtDbAdmin: TNsEditBtn
    Left = 3
    Top = 25
    Width = 390
    Height = 21
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000232E0000232E00000000000000000001FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF72A6C04287AA
      4287AA4287AA4287AA4287AA4287AA4287AA4287AA4287AA4287AA4287AA4287
      AA72A6C0FFFFFFFFFFFF4F96B96AB7DA82CCED82CCED82CCED82CCED82CCED82
      CCED82CCED82CCED82CCED82CCED83CDEE5DA5C8BFD6E2FFFFFF5DA4C856AACE
      80CBEA7EC9E97EC9E97EC9E97EC9E97EC9E97EC9E97EC9E97EC9E97EC9E97EC9
      E970BBDC91BDD3FFFFFF62A9CC44A1CB8AD3EF83CDEB83CDEB83CDEB83CDEB83
      CDEB83CDEB83CDEB83CDEB83CDEB83CDEB87CFEC6CACCDFEFEFE66ADD052B0D7
      85D2ED89D2EE89D2EE89D2EE89D2EE89D2EE89D2EE89D2EE89D2EE89D2EE89D2
      EE90D8F16CB3D5E2EFF66AB1D474CAE875CAE890D8F28FD7F18FD7F18FD7F18F
      D7F18FD7F18FD7F18FD7F18FD7F18FD7F191D8F279C3E2B9DCEC6DB4D78FDDF4
      63C0E5A8EEFAA8EEFAA8EEFAA8EEFAA8EEFAA8EEFAA8EEFAA8EEFAA8EEFAA8EE
      FAA8EEFA96DDF18EC8E571B8DAA6ECFC64C2E94FB5E24DB4E24CB3E14BB2E049
      B1DF48B0DF47AEDE45ADDD44ACDD46AEDF389FD27EC2E49ED1EB74BADDABF0FE
      A4E9FCA2E7FB9FE5FA9CE3F89AE1F797DEF694DCF491D9F38ED7F18BD4F090D8
      F374BADDFFFFFFFFFFFF77BDDFADF1FFA6EBFDA4E9FCA2E7FB9FE5FA9CE3F89A
      E1F797DEF694DCF491D9F38ED7F193DAF477BDDFFFFFFFFFFFFF7ABFE1B0F4FF
      ADF1FFABF0FEA9EEFDA7ECFCA5EAFBA2E8FAA0E6F99DE3F89AE1F798DFF699E0
      F77ABFE1FFFFFFFFFFFF9DD1EA7CC1E37CC1E37CC1E37CC1E37CC1E37CC1E3FE
      FEFDF5F5EEEBEBDDFEC941F4B62E7CC1E39DD1EAFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFD1E9F57EC3E57EC3E57EC3E57EC3E57EC3E5D1E9
      F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
    TabOrder = 13
  end
  object TxtUserAdmin: TEdit
    Left = 3
    Top = 121
    Width = 390
    Height = 21
    TabOrder = 14
    Text = 'SYSDBA'
  end
end
