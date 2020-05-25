unit Contatos2.model.contatos;

interface

uses
  Contatos2.model.interfaces, Contatos2.entidade.contatos,
  System.Generics.Collections, Contatos2.model.ConstSQL, firedac.stan.param,
  System.JSON;

Type
  TModelContatos = Class(TInterfacedObject, iModelContatos)
    Private
     Flista   : TObjectList<TContatos>;
     Fcontato : Tcontatos;
     Procedure MontarLista;
    Public
     Constructor Create;
     Destructor Destroy; Override;
     Class function New: iModelContatos;
     Function Novo    (Valor : tcontatos) : boolean;
     Function Editar  (Valor : tcontatos) : boolean;
     Function Remover (Valor : integer) : boolean;
     Function Listar : tobjectlist<Tcontatos>;
     Function Buscar (Valor : string) : TObjectList<Tcontatos>;
     Function Contato (Valor : integer) : Tcontatos;
     Function JSON : TJSonArray;
     Function JSON2 : string;
  End;

implementation

uses
  Contatos2.model.query, System.SysUtils, ULGTDataSetHelper, REST.Json;

{ TModelContatos }

function TModelContatos.Buscar(Valor: string): TObjectList<Tcontatos>;
var
 myquery : iquery;
begin
  myquery := tquery.New;
  myquery.Query.SQL.Clear;
  myquery.Query.SQL.Add(SQL_Busca);
  myquery.Query.ParamByName('pNome').AsString := '%'+Valor+'%';
  myquery.Query.Open();
  myquery.Query.First;
  Flista.Clear;
  while not myquery.Query.Eof do
   begin
    FLista.Add(tContatos.Create);
    Flista.Last.id       := myquery.Query.FieldByName('Id').AsInteger;
    FLista.Last.nome     := myquery.Query.FieldByName('Nome').AsString;
    FLista.Last.telefone := myquery.Query.FieldByName('Fixo').AsString;
    FLista.Last.Celular  := myquery.Query.FieldByName('Celular').AsString;
    FLista.Last.Email    := myquery.Query.FieldByName('Email').AsString;
    myquery.Query.Next;
   end;
  myquery.Query.Close;
  Result:= Flista;
end;

function TModelContatos.Contato(Valor: integer): Tcontatos;
var
 myquery   : iquery;
begin
  myquery := tquery.New;
  myquery.Query.SQL.Clear;
  myquery.Query.SQL.Add(SQL_Item);
  myquery.Query.ParamByName('pId').AsInteger := Valor;
  myquery.Query.Open();
  Fcontato.id       := myquery.Query.FieldByName('Id').AsInteger;
  Fcontato.nome     := myquery.Query.FieldByName('Nome').AsString;
  Fcontato.telefone := myquery.Query.FieldByName('Fixo').AsString;
  Fcontato.Celular  := myquery.Query.FieldByName('Celular').Asstring;
  Fcontato.Email    := myquery.Query.FieldByName('Email').AsString;
  myquery.Query.Close;
  Result := Fcontato;
end;

constructor TModelContatos.Create;
begin
    //if Not Assigned(Flista) then
    flista := TObjectList<TContatos>.create;
    Fcontato := Tcontatos.Create;
end;

destructor TModelContatos.Destroy;
begin
  FreeAndNil(Fcontato);
  FreeAndNil(Flista);
  inherited;
end;

function TModelContatos.Editar(Valor: tcontatos): boolean;
var
 myquery   : iquery;
begin
  myquery := tquery.New;
  myquery.Query.SQL.Clear;
  myquery.Query.SQL.Add(SQL_Edita);
  myquery.Query.ParamByName('pCodigo').AsInteger      := Valor.id;
  myquery.Query.ParamByName('pNome').AsString     := Valor.nome;
  myquery.Query.ParamByName('pFixo').AsString     := Valor.telefone;
  myquery.Query.ParamByName('pCelular').AsString  := Valor.Celular;
  myquery.Query.ParamByName('pEmail').AsString    := Valor.Email;
  try
   myquery.Query.ExecSQL;
   Result := True;
  Except
   Result := False;
  end;
end;

function TModelContatos.JSON: TJSonArray;
var myquery : iquery;
begin
  myquery := tquery.New;
  myquery.Query.SQL.Clear;
  myquery.Query.SQL.Add(SQL_Lista);
  myquery.Query.Open();
  Result := myquery.Query.DataSetToJSON();
  myquery.Query.Close;
end;

function TModelContatos.JSON2: string;
var
 myquery : iquery;
begin
  myquery := tquery.New;
  myquery.Query.SQL.Clear;
  myquery.Query.SQL.Add(SQL_Lista);
  myquery.Query.Open();
  myquery.Query.First;
  Flista.Clear;
  while not myquery.Query.Eof do
   begin
    FLista.Add(tContatos.Create);
    Flista.Last.id       := myquery.Query.FieldByName('Id').AsInteger;
    FLista.Last.nome     := myquery.Query.FieldByName('Nome').AsString;
    FLista.Last.telefone := myquery.Query.FieldByName('Fixo').AsString;
    FLista.Last.Celular  := myquery.Query.FieldByName('Celular').AsString;
    FLista.Last.Email    := myquery.Query.FieldByName('Email').AsString;
    myquery.Query.Next;
   end;
  myquery.Query.Close;
  Result := TJSON.ObjectToJsonString(Flista);
end;

function TModelContatos.Listar: tobjectlist<Tcontatos>;
begin
   MontarLista;
   Result := Flista;
end;

procedure TModelContatos.MontarLista;
var
 myquery : iquery;
begin
  myquery := tquery.New;
  myquery.Query.SQL.Clear;
  myquery.Query.SQL.Add(SQL_Lista);
  myquery.Query.Open();
  myquery.Query.First;
  Flista.Clear;
  while not myquery.Query.Eof do
   begin
    FLista.Add(tContatos.Create);
    Flista.Last.id       := myquery.Query.FieldByName('Id').AsInteger;
    FLista.Last.nome     := myquery.Query.FieldByName('Nome').AsString;
    FLista.Last.telefone := myquery.Query.FieldByName('Fixo').AsString;
    FLista.Last.Celular  := myquery.Query.FieldByName('Celular').AsString;
    FLista.Last.Email    := myquery.Query.FieldByName('Email').AsString;
    myquery.Query.Next;
   end;
  myquery.Query.Close;
end;

class function TModelContatos.New: iModelContatos;
begin
    result := self.Create;
end;

function TModelContatos.Novo(Valor: tcontatos): boolean;
var
 myquery   : iquery;
begin
  myquery := tquery.New;
  myquery.Query.SQL.Clear;
  myquery.Query.SQL.Add(SQL_Novo);
  myquery.Query.ParamByName('pNome').AsString     := Valor.nome;
  myquery.Query.ParamByName('pFixo').AsString     := Valor.telefone;
  myquery.Query.ParamByName('pCelular').AsString  := Valor.Celular;
  myquery.Query.ParamByName('pEmail').AsString    := Valor.Email;
  try
   myquery.Query.ExecSQL;
   Result := True;
  Except
   Result := False;
  end;
end;

function TModelContatos.Remover(Valor: integer): boolean;
var
 myquery   : iquery;
begin
  myquery := tquery.New;
  myquery.Query.SQL.Clear;
  myquery.Query.SQL.Add(SQL_Apaga);
  myquery.Query.ParamByName('pCodigo').AsInteger := Valor;
  try
   myquery.Query.ExecSQL;
   Result := true;
  Except
   Result := false;
  end;

end;


end.
