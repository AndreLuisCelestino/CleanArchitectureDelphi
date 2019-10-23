unit Gateway.Saque;

interface

uses
  Intf.Connection;

type
  TSaqueGateway = class
  private
    FDBConnection: IDBConnection;
  public
    constructor Create(aDBConnection: IDBConnection);
    procedure Sacar(const aValor: double);
  end;

implementation

uses
  UseCase.SacarDinheiro, UseCase.IncluirHistorico,
  Defs.Types, Gateway.Persistence;

{ TSaqueGateway }

constructor TSaqueGateway.Create(aDBConnection: IDBConnection);
begin
  FDBConnection := aDBConnection;
end;

procedure TSaqueGateway.Sacar(const aValor: double);
var
  PersistenceGateway: TPersistenceGateway;
  SaqueUseCase: TSacarDinheiroUseCase;
  HistoricoUseCase: TIncluirHistoricoUseCase;
begin
  PersistenceGateway := TPersistenceGateway.Create(FDBConnection);

  SaqueUseCase := TSacarDinheiroUseCase.Create(PersistenceGateway);
  HistoricoUseCase := TIncluirHistoricoUseCase.Create(PersistenceGateway);
  try
    SaqueUseCase.Execute(aValor);
    HistoricoUseCase.Execute(opSaque, aValor);
  finally
    HistoricoUseCase.Free;
    SaqueUseCase.Free;
  end;
end;

end.
