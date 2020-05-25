unit Contatos2.model.interfaces;

interface

uses FireDAC.Comp.Client, Contatos2.entidade.contatos,
  System.Generics.Collections, System.JSON;

type
  iconexao = interface
    ['{7F6A2FF6-5958-45B5-8779-B0A478DB2E6A}']
    function Conexao : tfdconnection;
  end;

  iquery = interface
    ['{308E1CE8-9683-4D72-BBE3-EBDE50DC22D9}']
    function Query : TFDQuery;
  end;

  iModelContatos = interface
    ['{EB4BA313-85C6-4944-94CD-72747EFBFA6F}']
    Function Novo    (Valor : tcontatos) : boolean;
    Function Editar  (Valor : tcontatos) : boolean;
    Function Remover (Valor : integer) : boolean;
    Function Listar : tobjectlist<Tcontatos>;
    Function Buscar (Valor : string) : TObjectList<Tcontatos>;
    Function Contato (valor : integer) : Tcontatos;
    Function JSON  : TJSonArray;
    Function JSON2 : string;
  end;

implementation

end.
