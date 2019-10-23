unit UseCase.RealizarDeposito;

interface

uses
  Intf.Persistence, Entity.Deposito;

type
  TRealizarDepositoUseCase = class
  private
    FPersistence: IPersistence;
    procedure Validate(const aDeposito: TDeposito);
  public
    constructor Create(aDepositoPersistence: IPersistence);
    procedure Execute(const aValor: double);
  end;

implementation

uses
  System.SysUtils;

{ TDepositoUseCase }

constructor TRealizarDepositoUseCase.Create(aDepositoPersistence: IPersistence);
begin
  FPersistence := aDepositoPersistence;
end;

procedure TRealizarDepositoUseCase.Execute(const aValor: double);
var
  Deposito: TDeposito;
begin
  Deposito := TDeposito.Create;
  try
    Deposito.Valor := aValor;

    Validate(Deposito);

    FPersistence.SalvarDeposito(Deposito);
  finally
    Deposito.Free;
  end;
end;

procedure TRealizarDepositoUseCase.Validate(const aDeposito: TDeposito);
begin
  if (aDeposito.Valor <= 0) or (aDeposito.Valor > 5000) then
    raise EArgumentException.Create('Informe um valor válido para o depósito.');
end;

end.
