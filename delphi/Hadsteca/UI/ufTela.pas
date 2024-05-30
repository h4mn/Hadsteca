unit ufTela;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls;

type
  TfTela = class(TForm)
    Shape1: TShape;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fTela: TfTela;

implementation

{$R *.dfm}

procedure TfTela.FormShow(Sender: TObject);
begin
  Shape1.Brush.Color := ColorToRGB($009595FF);
end;

end.
