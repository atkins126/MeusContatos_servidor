unit Contatos2.entidade.contatos;

interface

Type
  Tcontatos = class
    Private
     Fid       : integer;
     Fnome     : string;
     Ftelefone : string;
     Fcelular  : string;
     Femail    : string;
    procedure SetCelular(const Value: string);
    procedure SetEmail(const Value: string);
    procedure Setid(const Value: integer);
    procedure Setnome(const Value: string);
    procedure Settelefone(const Value: string);
    Public
     Property id       : integer read Fid write Setid;
     Property nome     : string read Fnome write Setnome;
     Property telefone : string read Ftelefone write Settelefone;
     Property Celular  : string read FCelular write SetCelular;
     Property Email    : string read FEmail write SetEmail;
  end;

implementation

{ Tcontatos }

procedure Tcontatos.SetCelular(const Value: string);
begin
  FCelular := Value;
end;

procedure Tcontatos.SetEmail(const Value: string);
begin
  FEmail := Value;
end;

procedure Tcontatos.Setid(const Value: integer);
begin
  Fid := Value;
end;

procedure Tcontatos.Setnome(const Value: string);
begin
  Fnome := Value;
end;

procedure Tcontatos.Settelefone(const Value: string);
begin
  Ftelefone := Value;
end;

end.
