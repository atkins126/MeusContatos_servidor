unit ServerConst1;

interface

resourcestring
  sPortInUse = '- Erro: Porta %s j� em uso';
  sPortSet = '- Porta configurada para %s';
  sServerRunning = '- O servidor j� est� rodando.';
  sStartingServer = '- Iniciando servidor na porta %d';
  sStoppingServer = '- Parando servidor...';
  sServerStopped = '- Servidor encerrado!';
  sServerNotRunning = '- O servidor n�o est� rodando';
  sInvalidCommand = '- Erro: Comando inv�lido.';
  sIndyVersion = '- Vers�o do Indy: ';
  sActive = '- Ativo: ';
  sPort = '- Porta: ';
  sSessionID = '- Id da se��o: ';
  sCommands = 'Servidor Meus Contatos - vers�o 1.1' + slineBreak + slineBreak +
    'Digite o comando: ' + slineBreak +
    '   - "Iniciar" para iniciar o servidor'+ slineBreak +
    '   - "Parar" para parar o servidor'+ slineBreak +
    '   - "Configurar porta" para alterar porta padr�o'+ slineBreak +
    '   - "Status" para exibir status do servidor'+ slineBreak +
    '   - "Ajuda" para mostrar comandos'+ slineBreak +
    '   - "Sair" para encerrar o aplicativo servidor';

const
  cArrow = '->';
  cCommandStart = 'Iniciar';
  cCommandStop = 'Parar';
  cCommandStatus = 'Status';
  cCommandHelp = 'Ajuda';
  cCommandSetPort = 'Configurar porta';
  cCommandExit = 'Sair';

implementation

end.
