unit ServerMain;

interface

uses System.SysUtils, System.Classes, Datasnap.DSServer, Datasnap.DSAuth,
  System.JSON;

type
{$METHODINFO ON}
  TServerMethods1 = class(TComponent)
  private
    { Private declarations }
    procedure FormatarJSON(const AIDCode: Integer; const AContent: string);
  public
    { Public declarations }
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
    Function Contatos : tjsonarray;
    Function UpdateContatos : TJSONArray;
    Function AcceptContatos : TJSONArray;
    Function CancelContatos (const aid: integer) : tJsonArray;
    Function Contato (Aid : integer) : tjsonarray;
  end;

  Main = class (TServerMethods1);
{$METHODINFO OFF}

implementation


uses System.StrUtils, Data.DBXPlatform, Contatos2.model.interfaces,
  Contatos2.model.contatos, Web.HTTPApp, Datasnap.DSHTTPWebBroker,
  Contatos2.entidade.contatos, REST.Json;

function TServerMethods1.AcceptContatos: TJSONArray;
var modulo : twebmodule;
   contatos : tcontatos;
   Contato : iModelContatos;
begin
   modulo := GetDataSnapWebModule;
   if modulo.Request.Content.IsEmpty then
    begin
      Result := TJSONArray.Create('Mensagem', 'Erro!');
      FormatarJSON(204, result.ToString);
      abort;
    end;
   Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Modulo.Request.Content), 0) as TJSONArray;
   Contatos := Tcontatos.create;
   try
     Contatos.id       := Result.Items[0].GetValue<integer>('id');
     Contatos.nome     := Result.Items[0].GetValue<string>('nome');
     contatos.telefone := Result.Items[0].GetValue<string>('fixo');
     contatos.Celular  := Result.Items[0].GetValue<string>('celular');
     Contatos.Email    := Result.Items[0].GetValue<string>('email');
     Contato := tmodelcontatos.new;
     if contato.Editar(contatos) = true then
      begin
       Result := TJSONArray.Create('Mensagem', 'Ok');
       FormatarJSON(200, result.ToString);
      end
     else
      begin
       Result := TJSONArray.Create('Mensagem', 'Erro!');
       FormatarJSON(204, result.ToString);
      end;
   finally
      FreeAndNil(Contatos);
   end;
end;

function TServerMethods1.CancelContatos(const aid: integer): tJsonArray;
var
   Contato : iModelContatos;
begin
     Contato := tmodelcontatos.New;
     if contato.Remover(aid) = true then
      begin
       Result := TJSONArray.Create('Mensagem', 'Ok');
       FormatarJSON(200, result.ToString);
      end
     else
      begin
       Result := TJSONArray.Create('Mensagem', 'Erro!');
       FormatarJSON(204, result.ToString);
      end;
end;

function TServerMethods1.Contato(Aid: integer): tjsonarray;
var Contatos : Tcontatos;
    JsonString : TJSONObject;
begin
  Contatos := tmodelContatos.New.Contato(Aid);
  JsonString := TJson.ObjectToJsonObject(Contatos);
  if JsonString <> nil then
   Begin
     Result := TJSONArray.Create(JsonString);
     FormatarJSON(200, Result.ToString);
   End
  else
    begin
     Result := TJSONArray.Create(TJSONObject.Create(TJSONPair.Create('Mensagem', 'Nenhum contato encontrado.')));
     FormatarJSON(203, Result.ToString);
    end;
end;

function TServerMethods1.Contatos: tjsonarray;
var Contatos : imodelcontatos;
begin
   Contatos := tmodelcontatos.new;
   if Contatos.JSON.Count > 0 then
    begin
     Result := Contatos.JSON;
     FormatarJSON(200, Result.ToString);
    end
   else
    begin
     Result := TJSONArray.Create(TJSONObject.Create(TJSONPair.Create('Mensagem', 'Nenhum contato encontrado.')));
     FormatarJSON(203, Result.ToString);
    end;
end;

function TServerMethods1.EchoString(Value: string): string;
begin
  Result := Value;
end;

procedure TServerMethods1.FormatarJSON(const AIDCode: Integer;
  const AContent: string);
begin
  GetInvocationMetadata().ResponseCode    := AIDCode;
  GetInvocationMetadata().ResponseContent :=  AContent;
end;

function TServerMethods1.UpdateContatos: TJSONArray;
var modulo : twebmodule;
   contatos : tcontatos;
   Contato : iModelContatos;
begin
   modulo := GetDataSnapWebModule;
   if modulo.Request.Content.IsEmpty then
    begin
      Result := TJSONArray.Create('Mensagem', 'Erro!');
      FormatarJSON(204, result.ToString);
      abort;
    end;
   Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Modulo.Request.Content), 0) as TJSONArray;
   Contatos := Tcontatos.create;
   try
     Contatos.nome     := Result.Items[0].GetValue<string>('nome');
     contatos.telefone := Result.Items[0].GetValue<string>('fixo');
     contatos.Celular  := Result.Items[0].GetValue<string>('celular');
     Contatos.Email    := Result.Items[0].GetValue<string>('email');
     Contato := tmodelcontatos.new;
     if contato.Novo(contatos) = true then
      begin
       Result := TJSONArray.Create('Mensagem', 'Ok');
       FormatarJSON(200, result.ToString);
      end
     else
      begin
       Result := TJSONArray.Create('Mensagem', 'Erro!');
       FormatarJSON(204, result.ToString);
      end;
   finally
      FreeAndNil(Contatos);
   end;
end;

function TServerMethods1.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;
end.

