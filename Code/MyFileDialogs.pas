unit MyFileDialogs;

interface

uses
  SysUtils, MyUtils, Vcl.StdCtrls;

type
  TFileDialogs = class
  class procedure OpenFileAll(Sender: TObject);
  class procedure OpenFileFB(Sender: TObject);
  class procedure OpenFileFBK(Sender: TObject);
  class procedure OpenFileDLL(Sender: TObject);
  class procedure OpenFolder(Sender: TObject);

  class procedure SaveFileFB(Sender: TObject);
  class procedure SaveFileFBK(Sender: TObject);
  class procedure SaveFolder(Sender: TObject);
  private
  class procedure OpenFile(Sender: TObject; DisplayName, FileMask: string; IncludeAllFiles: boolean);
  class procedure SaveFile(Sender: TObject; DisplayName, FileMask: string; IncludeAllFiles: boolean);
  end;

implementation

//Load
class procedure TFileDialogs.OpenFileAll(Sender: TObject);
var
  FileName: string;
begin
  if TUTils.OpenFileAll(FileName) then
    (Sender as TEdit).Text := FileName;
end;

class procedure TFileDialogs.OpenFile(Sender: TObject; DisplayName, FileMask: string; IncludeAllFiles: boolean);
var
  FileName: string;
begin
  if TUTils.OpenFile(DisplayName, FileMask, IncludeAllFiles, FileName) then
    (Sender as TEdit).Text := FileName;
end;

class procedure TFileDialogs.OpenFileFB(Sender: TObject);
begin
  OpenFile(Sender, 'Firebird Database (*.FDB)', '*.FDB', true);
end;

class procedure TFileDialogs.OpenFileFBK(Sender: TObject);
begin
  OpenFile(Sender, 'Firebird Backup (*.FBK)', '*.FBK', true);
end;

class procedure TFileDialogs.OpenFileDLL(Sender: TObject);
begin
  OpenFile(Sender, 'Dynamic Link Library (*.DLL)', '*.DLL', true);
end;

class procedure TFileDialogs.OpenFolder(Sender: TObject);
var
  FileName: string;
begin
  if TUTils.OpenFolder(FileName) then
    (Sender as TEdit).Text := FileName;
end;

//Save
class procedure TFileDialogs.SaveFile(Sender: TObject; DisplayName, FileMask: string; IncludeAllFiles: boolean);
var
  FileName: string;
begin
  if TUTils.SaveFile(DisplayName, FileMask, IncludeAllFiles, FileName) then
    (Sender as TEdit).Text := FileName;
end;

class procedure TFileDialogs.SaveFileFB(Sender: TObject);
begin
  SaveFile(Sender, 'Firebird Database (*.FDB)', '*.FDB', false);
end;

class procedure TFileDialogs.SaveFileFBK(Sender: TObject);
begin
  SaveFile(Sender, 'Firebird Backup (*.FBK)', '*.FBK', true);
end;

class procedure TFileDialogs.SaveFolder(Sender: TObject);
var
  FileName: string;
begin
  if TUTils.SaveFolder(FileName) then
    (Sender as TEdit).Text := FileName;
end;

end.
