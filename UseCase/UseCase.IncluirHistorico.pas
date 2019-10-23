unit UseCase.IncluirHistorico;

interface

uses
  Defs.Types, Intf.Persistence;

type
  TIncluirHistoricoUseCase = class
  private
    FPersistence: IPersistence;
  public
    constructor Create(aSaquePersistence: IPersistence);
    procedure Execute(const aTipoOperacao: TTipoOperacao; const aValor: double);
  end;

implementation

uses
  System.SysUtils, Entity.Historico;

{ TIncluirHistoricoUseCase }

constructor TIncluirHistoricoUseCase.Create(
  aSaquePersistence: IPersistence);
begin
  FPersistence := aSaquePersistence;
end;

procedure TIncluirHistoricoUseCase.Execute(
  const aTipoOperacao: TTipoOperacao; const aValor: double);
var
  Historico: THistorico;
  Operacao: string;
  Descricao: string;
begin
  Historico := THistorico.Create;
  try
    case aTipoOperacao of
      opSaque: Operacao := 'saque';
      opDeposito: Operacao := 'depósito';
    end;

    Descricao := Format(
      'Uma operação de %s no valor de %.2f foi realizada',
      [Operacao, aValor]);

    Historico.DataEvento := FormatDateTime('mm/dd/yyyy', Date);
    Historico.Descricao := Descricao;

    FPersistence.SalvarHistorico(Historico);
  finally
    Historico.Free;
  end;
end;

end.
