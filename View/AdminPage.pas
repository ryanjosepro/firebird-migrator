unit AdminPage;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, NsEditBtn,
  Vcl.CheckLst, Vcl.ExtCtrls;

type
  TFrame1 = class(TFrame)
    CheckVerboseAdmin: TCheckBox;
    RadioGroupMethodAdmin: TRadioGroup;
    CheckListOptionsAdmin: TCheckListBox;
    BoxProtocolAdmin: TComboBox;
    TxtHostAdmin: TEdit;
    TxtPortAdmin: TEdit;
    TxtBackupFileAdmin: TNsEditBtn;
    MemoLogAdmin: TMemo;
    BoxVersionAdmin: TComboBox;
    BtnStartAdmin: TButton;
    TxtDllAdmin: TNsEditBtn;
    RadioGroupConnMethodAdmin: TRadioGroup;
    TxtPasswordAdmin: TEdit;
    LblProtocolAdmin: TLabel;
    LblHostAdmin: TLabel;
    LblPortAdmin: TLabel;
    LblDbAdmin: TLabel;
    LblUserAdmin: TLabel;
    LblPasswordAdmin: TLabel;
    LblVersionAdmin: TLabel;
    TxtDbAdmin: TNsEditBtn;
    TxtUserAdmin: TEdit;
    LblBackupFileAdmin: TLabel;
    LblDllAdmin: TLabel;
    LblLogAdmin: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
