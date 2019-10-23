program CA_2;

uses
  Vcl.Forms,
  Entity.Deposito in 'Entity\Entity.Deposito.pas',
  Entity.Saque in 'Entity\Entity.Saque.pas',
  Gateway.Deposito in 'Gateway\Gateway.Deposito.pas',
  Gateway.Persistence in 'Gateway\Gateway.Persistence.pas',
  Gateway.Saque in 'Gateway\Gateway.Saque.pas',
  Connection.DB in 'Infra\Connection.DB.pas',
  Intf.Persistence in 'UseCase\Intf.Persistence.pas',
  UseCase.RealizarDeposito in 'UseCase\UseCase.RealizarDeposito.pas',
  UseCase.SacarDinheiro in 'UseCase\UseCase.SacarDinheiro.pas',
  View.Form in 'View\View.Form.pas' {fExemplo},
  Defs.Types in 'Entity\Defs.Types.pas',
  UseCase.IncluirHistorico in 'UseCase\UseCase.IncluirHistorico.pas',
  Entity.Historico in 'Entity\Entity.Historico.pas',
  Intf.Connection in 'Gateway\Intf.Connection.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfExemplo, fExemplo);
  Application.Run;
end.
