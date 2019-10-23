unit UseCase.SacarDinheiro;

interface

uses
  Intf.Persistence, Entity.Saque;

type
  TSacarDinheiroUseCase = class
  private
    FPersistence: IPersistence;
    procedure Validate(const aSaque: TSaque);
  public
    constructor Create(aSaquePersistence: IPersistence);
    procedure Execute(const aValor: double);
  end;

implementation

uses
  System.SysUtils;

{ TSaqueUseCase }

constructor TSacarDinheiroUseCase.Create(aSaquePersistence: IPersistence);
begin
  FPersistence := aSaquePersistence;
end;

procedure TSacarDinheiroUseCase.Execute(const aValor: double);
var
  Saque: TSaque;
begin
  Saque := TSaque.Create;
  try
    Saque.Valor := aValor;

    Validate(Saque);

    FPersistence.SalvarSaque(Saque);
  finally
    Saque.Free;
  end;
end;

procedure TSacarDinheiroUseCase.Validate(const aSaque: TSaque);
begin
  if aSaque.Valor <= 0 then
    raise EArgumentException.Create('Informe um valor válido para o saque.');

  if FPersistence.ObterSaldo < aSaque.Valor then
    raise EInvalidOp.Create('Não há saldo suficiente para este saque.');
end;

end.
