unit UnitMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ShellApi, ioutils, FileCtrl,
  Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    btnRelease: TButton;
    Label1: TLabel;
    Label2: TLabel;
    editUnzipTo: TEdit;
    ComboBoxFileName: TComboBox;
    btnC: TButton;
    btnBrowses: TButton;
    btnAppPath: TButton;
    btnOpen: TButton;
    procedure btnReleaseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnBrowsesClick(Sender: TObject);
    procedure btnCClick(Sender: TObject);
    procedure btnAppPathClick(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnAppPathClick(Sender: TObject);
begin
  editUnzipTo.Text := ExtractFileDir(Application.ExeName);
end;

procedure TForm1.btnBrowsesClick(Sender: TObject);
var
  strPath: string; // 用户选定后的目录
begin
  strPath := '';
  if (SelectDirectory('Release to...', '', strPath)) then
  begin
    self.editUnzipTo.Text := strPath;
  end;
end;

procedure TForm1.btnCClick(Sender: TObject);
begin
  self.editUnzipTo.Text := 'C:';
end;

procedure TForm1.btnOpenClick(Sender: TObject);
begin
  ShellExecute(Handle,'open','Explorer.exe', PWideChar(editUnzipTo.Text), nil, SW_SHOWNORMAL);
end;

procedure TForm1.btnReleaseClick(Sender: TObject);
var
  param: string;
  s: string;
begin
  s := ExtractFileName(ComboBoxFileName.Text);
  s := s.Substring(0, s.Length - 4);
  s := self.editUnzipTo.Text + '\' + s;
  param := 'x ' + ComboBoxFileName.Text + ' -o' + s + ' -aoa';
  shellexecute(0, PWideChar('open'), PWideChar('7z.exe'), PWideChar(param), '', SW_SHOWNORMAL); //sw_hide);

//  Winexec(PAnsiChar('cmd'), SW_SHOWNORMAL );
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  files: TArray<string>;
  i: Integer;
begin
  editUnzipTo.Text := ExtractFileDir(Application.ExeName);
  files := TDirectory.GetFiles(editUnzipTo.Text, '*.zip');
  for i := 0 to Length(files) - 1 do
  begin
    ComboBoxFileName.Items.Add(files[i]);
  end;
end;


end.
