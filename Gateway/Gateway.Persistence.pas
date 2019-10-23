unit Gateway.Persistence;

interface

uses
  Intf.Persistence, Intf.Connection, Entity.Saque, Entity.Deposito, Entity.Historico;

type
  TPersistenceGateway = class(TInterfacedObject, IPersistence)
  private
    FDBConnection: IDBConnection;
  public
    constructor Create(aDBConnection: IDBConnection);
    procedure SalvarSaque(aSaque: TSaque);
    procedure SalvarDeposito(aDeposito: TDeposito);
    procedure SalvarHistorico(aHistorico: THistorico);
    function ObterSaldo: double;
  end;

implementation

uses
  System.SysUtils;

{ TPersistenceGateway }

procedure TPersistenceGateway.SalvarSaque(aSaque: TSaque);
var
  Comando: TStringBuilder;
begin
  Comando := TStringBuilder.Create;
  try
    // UPDATE sem WHERE apenas para demonstração
    Comando
      .Append('UPDATE Conta')
      .Append(' SET Saldo = Saldo - ')
      .Append(aSaque.Valor)
      .Append(' WHERE ID = 1');

    FDBConnection.Execute(Comando.ToString);
  finally
    Comando.Free;
  end;
end;

procedure TPersistenceGateway.SalvarDeposito(aDeposito: TDeposito);
var
  Comando: TStringBuilder;
begin
  Comando := TStringBuilder.Create;
  try
    // UPDATE sem WHERE apenas para demonstração
    Comando
      .Append('UPDATE Conta')
      .Append(' SET Saldo = Saldo + ')
      .Append(aDeposito.Valor)
      .Append(' WHERE ID = 1');

    FDBConnection.Execute(Comando.ToString);
  finally
    Comando.Free;
  end;
end;

procedure TPersistenceGateway.SalvarHistorico(aHistorico: THistorico);
var
  Comando: TStringBuilder;
begin
  Comando := TStringBuilder.Create;
  try
    Comando
      .Append('INSERT INTO Historico VALUES ')
      .AppendFormat('(%s, %s)',
        [aHistorico.DataEvento.QuotedString,
         aHistorico.Descricao.QuotedString]);

    FDBConnection.Execute(Comando.ToString);
  finally
    Comando.Free;
  end;
end;

constructor TPersistenceGateway.Create(aDBConnection: IDBConnection);
begin
  FDBConnection := aDBConnection;
end;

function TPersistenceGateway.ObterSaldo: double;
var
  Comando: TStringBuilder;
begin
  Comando := TStringBuilder.Create;
  try
    Comando.Append('SELECT Saldo FROM Conta');

    result := FDBConnection.GetValue(Comando.ToString);
  finally
    Comando.Free;
  end;
end;

end.
