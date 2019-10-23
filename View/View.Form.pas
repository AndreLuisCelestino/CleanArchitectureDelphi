unit View.Form;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Imaging.jpeg, Vcl.ExtCtrls;

type
  TfExemplo = class(TForm)
    Bevel: TBevel;
    BitBtnConfirmar: TBitBtn;
    ComboBoxOperacao: TComboBox;
    EditValor: TEdit;
    Image: TImage;
    LabelOperacao: TLabel;
    LabelValor: TLabel;
    procedure BitBtnConfirmarClick(Sender: TObject);
  private
    procedure SacarDinheiro;
    procedure RealizarDeposito;
  end;

var
  fExemplo: TfExemplo;

implementation

uses
  Gateway.Saque, Gateway.Deposito, Connection.DB;

{$R *.dfm}

procedure TfExemplo.BitBtnConfirmarClick(Sender: TObject);
begin
  case ComboBoxOperacao.ItemIndex of
    0: SacarDinheiro;
    1: RealizarDeposito;
  end;
end;

procedure TfExemplo.RealizarDeposito;
var
  DepositoGateway: TDepositoGateway;
  Valor: real;
begin
  DepositoGateway := TDepositoGateway.Create(TDBConnection.Create);
  try
    Valor := StrToFloatDef(EditValor.Text, 0);
    DepositoGateway.Depositar(Valor);
  finally
    DepositoGateway.Free;
  end;
end;

procedure TfExemplo.SacarDinheiro;
var
  SaqueGateway: TSaqueGateway;
  Valor: real;
begin
  SaqueGateway := TSaqueGateway.Create(TDBConnection.Create);
  try
    Valor := StrToFloatDef(EditValor.Text, 0);
    SaqueGateway.Sacar(Valor);
  finally
    SaqueGateway.Free;
  end;
end;

end.
