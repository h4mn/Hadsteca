unit uCor;

interface

uses
  System.Classes;

type
  TCor = class(TComponent)
  private
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    function InverterHexadecimalBitABit(ACorABRG: cardinal): cardinal;

  published
    { published declarations }
  end;

implementation


{ TCor }

function TCor.InverterHexadecimalBitABit(ACorABRG: cardinal): cardinal;
var
  LInvertido: cardinal;
  i: Integer;
begin
  LInvertido := 0;

  for i := 0 to SizeOf(ACorABRG) * 8 - 1 do
  begin
    if (ACorABRG and (2 shl i)) = 0 then
      LInvertido := LInvertido or (2 shl i);
  end;

  Result := LInvertido;
end;

end.
