unit Contatos2.model.ConstSQL;

interface

Const
  SQL_Lista = 'SELECT * FROM Contatos';
  SQL_Busca = 'SELECT * FROM Contatos WHERE Nome LIKE :pNome';
  SQL_Apaga = 'DELETE FROM Contatos WHERE Id = :pCodigo';
  SQL_Edita = 'UPDATE Contatos SET Nome = :pNome, Fixo = :pFixo, Celular = :pCelular, Email = :pEmail WHERE Id = :pCodigo';
  SQL_Novo  = 'INSERT INTO Contatos (Nome, Fixo, Celular, Email) VALUES (:pNome, :pFixo, :pCelular, :pEmail)';
  SQL_Item  = 'SELECT * FROM Contatos WHERE Id LIKE :pId';

implementation

end.
