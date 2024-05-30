program Console;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uCor in 'Hadsteca\uCor.pas';

var
  LCor: TCor;
  LOriginal, LInvertida: cardinal;
begin
  try
    { TODO -oUser -cConsole Main : Insert code here }

    LCor := TCor.Create(nil);
    try
      LOriginal := $009595FF;
      LInvertida := LCor.InverterHexadecimalBitABit(LOriginal);

      Writeln(Format('Original: $%.8x', [LOriginal]));
      Writeln(Format('Invertida: $%.8x', [LInvertida]));

    finally
      LCor.Free;
    end;

    Writeln('');
    Writeln('');
    Writeln('--------------------------------------------------------------------------------');

    Writeln('Pressione Enter para continuar...');
    Readln;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
