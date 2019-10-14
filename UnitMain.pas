unit UnitMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ShellApi, ioutils,
  FileCtrl,
  Vcl.ExtCtrls,
  {这三个单元是必须的}
  ComObj, ActiveX, ShlObj;

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
    btnShortLink: TButton;
    procedure btnReleaseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnBrowsesClick(Sender: TObject);
    procedure btnCClick(Sender: TObject);
    procedure btnAppPathClick(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);
    procedure btnShortLinkClick(Sender: TObject);
    procedure CreateLink(ProgramPath, ProgramArg, LinkPath, Descr: String);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  maxPath = 200; // 定义最大字符串数组长度

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
  ShellExecute(Handle, 'open', 'Explorer.exe', PWideChar(editUnzipTo.Text), nil,
    SW_SHOWNORMAL);
end;

procedure TForm1.btnReleaseClick(Sender: TObject);
var
  param: string;
  s: string;
begin
  if ComboBoxFileName.ItemIndex = -1 then
  begin
    ShowMessage('请选择一个有效的压缩包！');
    exit;
  end;

  s := ExtractFileName(ComboBoxFileName.Text);
  s := s.Substring(0, s.Length - 4);
  s := self.editUnzipTo.Text + '\' + s;
  param := 'x ' + ComboBoxFileName.Text + ' -o' + s + ' -aoa';
  ShellExecute(0, PWideChar('open'), PWideChar('7z.exe'), PWideChar(param), '',
    SW_SHOWNORMAL); // sw_hide);
end;

procedure TForm1.btnShortLinkClick(Sender: TObject);
var
  exeFileName: string;
  tmp: array [0 .. maxPath] of Char;
  pitem: PITEMIDLIST;
  usrDeskTopPath: string;
  s: string;
  v: string;
begin;
  if ComboBoxFileName.ItemIndex = -1 then
  begin
    ShowMessage('请选择一个有效的压缩包！');
    exit;
  end;

  // 计算完整的应用程序名
  s := ExtractFileName(ComboBoxFileName.Text);
  s := s.Substring(0, s.Length - 4);
  s := self.editUnzipTo.Text + '\' + s;
  exeFileName := s + '\Teacher\zntbkt.exe';

  // 获取当前用户桌面的位置
  SHGetSpecialFolderLocation(self.Handle, CSIDL_DESKTOP, pitem);
  setlength(usrDeskTopPath, maxPath);
  shGetPathFromIDList(pitem, PWideChar(usrDeskTopPath));
  usrDeskTopPath := String(PWideChar(usrDeskTopPath));

  v := ExtractFileName(ComboBoxFileName.Text);
  v := v.Substring(0, v.Length - 4);

  CreateLink(exeFileName, // 应用程序完整路径
    '', // 传给应用程序的参数
    usrDeskTopPath + '\智能化同步课堂教师端' + v + '.lnk', // 快捷方式完整路径
    '智能化同步课堂教师端，北京创元企安科技有限公司版权所有' // 备注
    );
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

procedure TForm1.CreateLink(ProgramPath, ProgramArg, LinkPath, Descr: String);
var
  AnObj: IUnknown;
  ShellLink: IShellLink;
  AFile: IPersistFile;
  FileName: WideString;
begin
  if UpperCase(ExtractFileExt(LinkPath)) <> '.LNK' then // 检查扩展名是否正确
  begin
    raise Exception.Create('快捷方式的扩展名必须是 ′′LNK′′!');
    // 若不是则产生异常
  end;
  try
    OleInitialize(nil); // 初始化OLE库，在使用OLE函数前必须调用初始化
    AnObj := CreateComObject(CLSID_ShellLink); // 根据给定的ClassID生成
    // 一个COM对象，此处是快捷方式
    ShellLink := AnObj as IShellLink; // 强制转换为快捷方式接口
    AFile := AnObj as IPersistFile; // 强制转换为文件接口
    // 设置快捷方式属性，此处只设置了几个常用的属性
    ShellLink.SetPath(PChar(ProgramPath)); // 快捷方式的目标文件，一般为可执行文件
    ShellLink.SetArguments(PChar(ProgramArg)); // 目标文件参数
    ShellLink.SetWorkingDirectory(PChar(ExtractFilePath(ProgramPath)));
    // 目标文件的工作目录
    ShellLink.SetDescription(PChar(Descr)); // 对目标文件的描述
    FileName := LinkPath; // 把文件名转换为WideString类型
    AFile.Save(PWChar(FileName), False); // 保存快捷方式
  finally
    OleUninitialize; // 关闭OLE库，此函数必须与OleInitialize成对调用
  end;

end;

end.
