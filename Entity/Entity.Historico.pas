unit Entity.Historico;

interface

type
  THistorico = class
  private
    FDataEvento: string;
    FDescricao: string;
  public
    property DataEvento: string read FDataEvento write FDataEvento;
    property Descricao: string read FDescricao write FDescricao;
  end;

implementation

end.
