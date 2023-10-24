unit debugger;

interface

uses
  System.Classes, System.SysUtils, System.Generics.Collections,
  System.Generics.Defaults;

type
  TDebugger = class(TComponent)
  private
    FInstanced: boolean;

  public
    { public declarations }
    constructor Create;

  end;

//N�o � poss�vel fazer helper de TEnumerators tipados
//  TDictionaryHelper = class helper for TDictionary<string, string>
//    procedure Save(const pFileName: string);
//  end;

var
  GDebug: TDebugger;

implementation

{ TDebugger }

constructor TDebugger.Create;
begin
  FInstanced := true;
end;

initialization

GDebug := TDebugger.Create;

finalization

FreeAndNil(GDebug);

end.
