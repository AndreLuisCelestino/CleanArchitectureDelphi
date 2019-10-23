unit Intf.Persistence;

interface

uses
  Entity.Saque, Entity.Deposito, Entity.Historico;

type
  IPersistence = interface
    procedure SalvarSaque(aSaque: TSaque);
    procedure SalvarDeposito(aDeposito: TDeposito);
    procedure SalvarHistorico(aHistorico: THistorico);
    function ObterSaldo: double;
  end;

implementation

end.
