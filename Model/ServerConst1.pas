unit ServerConst1;

interface

resourcestring
  sPortInUse = '- Erro: Porta %s já em uso';
  sPortSet = '- Porta configurada para %s';
  sServerRunning = '- O servidor já está rodando.';
  sStartingServer = '- Iniciando servidor na porta %d';
  sStoppingServer = '- Parando servidor...';
  sServerStopped = '- Servidor encerrado!';
  sServerNotRunning = '- O servidor não está rodando';
  sInvalidCommand = '- Erro: Comando inválido.';
  sIndyVersion = '- Versão do Indy: ';
  sActive = '- Ativo: ';
  sPort = '- Porta: ';
  sSessionID = '- Id da seção: ';
  sCommands = 'Servidor Meus Contatos - versão 1.1' + slineBreak + slineBreak +
    'Digite o comando: ' + slineBreak +
    '   - "Iniciar" para iniciar o servidor'+ slineBreak +
    '   - "Parar" para parar o servidor'+ slineBreak +
    '   - "Configurar porta" para alterar porta padrão'+ slineBreak +
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
