unit Contatos2.model.query;

interface

uses
  FireDAC.Comp.Client, contatos2.model.conexao, contatos2.model.interfaces;

Type
  TQuery = Class(TInterfacedObject, iQuery)
    Private
     FQuery: Tfdquery;
     Con: iconexao;
    Public
     Constructor Create;
     Destructor Destroy; Override;
     Class function New: iQuery;
     Function Query: tfdquery;
  End;

implementation

uses
  System.SysUtils;

{ TQuery }

constructor TQuery.Create;
begin
    con               := tconexao.New;
    fquery            := TFDQuery.Create(nil);
    fquery.Connection := con.conexao;
end;

destructor TQuery.Destroy;
begin
  FreeAndNil(FQuery);
  inherited;
end;

class function TQuery.New: iQuery;
begin
   Result:= self.Create;
end;

function TQuery.Query: tfdquery;
begin
    Result:= FQuery;
end;

end.
