unit Intf.Connection;

interface

type
  IDBConnection = interface
    procedure Execute(const aComando: string);
    function GetValue(const aComando: string): variant;
  end;

implementation

end.
