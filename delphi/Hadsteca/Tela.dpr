program Tela;

uses
  Vcl.Forms,
  ufTela in 'UI\ufTela.pas' {fTela};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfTela, fTela);
  Application.Run;
end.
