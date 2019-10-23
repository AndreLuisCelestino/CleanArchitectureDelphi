unit Gateway.Deposito;

interface

uses
  Intf.Connection;

type
  TDepositoGateway = class
  private
    FDBConnection: IDBConnection;
  public
    constructor Create(aDBConnection: IDBConnection);
    procedure Depositar(const aValor: double);
  end;

implementation

uses
  UseCase.RealizarDeposito, UseCase.IncluirHistorico,
  Defs.Types, Gateway.Persistence;

{ TSaqueGateway }

constructor TDepositoGateway.Create(aDBConnection: IDBConnection);
begin
  FDBConnection := aDBConnection;
end;

procedure TDepositoGateway.Depositar(const aValor: double);
var
  PersistenceGateway: TPersistenceGateway;
  DepositoUseCase: TRealizarDepositoUseCase;
  HistoricoUseCase: TIncluirHistoricoUseCase;
begin
  PersistenceGateway := TPersistenceGateway.Create(FDBConnection);

  DepositoUseCase := TRealizarDepositoUseCase.Create(PersistenceGateway);
  HistoricoUseCase :=  TIncluirHistoricoUseCase.Create(PersistenceGateway);
  try
    DepositoUseCase.Execute(aValor);
    HistoricoUseCase.Execute(opDeposito, aValor);
  finally
    HistoricoUseCase.Free;
    DepositoUseCase.Free;
  end;
end;

end.
