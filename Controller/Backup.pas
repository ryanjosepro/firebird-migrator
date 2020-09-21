unit Backup;

interface

uses
  System.SysUtils, System.Variants, System.Classes, FireDAC.Phys.FB, FireDAC.Phys.IBBase;

type
  TBackup = class
  private
    FBDriverLink: TFDPhysFBDriverLink;
    Backup: TFDIBBackup;
  public

  end;

implementation

end.
