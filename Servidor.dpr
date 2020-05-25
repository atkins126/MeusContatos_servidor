program Servidor;
{$APPTYPE CONSOLE}

{$R *.dres}

uses
  System.SysUtils,
  System.Types,
  IPPeerServer,
  IPPeerAPI,
  IdHTTPWebBrokerBridge,
  Web.WebReq,
  Web.WebBroker,
  Datasnap.DSSession,
  ServerMain in 'Metodos\ServerMain.pas',
  WebModuleUnit1 in 'WebModuleUnit1.pas' {WebModule1: TWebModule},
  ServerConst1 in 'Model\ServerConst1.pas',
  Contatos2.entidade.contatos in 'Model\Contatos2.entidade.contatos.pas',
  Contatos2.model.conexao in 'Model\Contatos2.model.conexao.pas',
  Contatos2.model.ConstSQL in 'Model\Contatos2.model.ConstSQL.pas',
  Contatos2.model.contatos in 'Model\Contatos2.model.contatos.pas',
  Contatos2.model.interfaces in 'Model\Contatos2.model.interfaces.pas',
  Contatos2.model.query in 'Model\Contatos2.model.query.pas',
  ULGTDataSetHelper in 'Model\ULGTDataSetHelper.pas';

{$R *.res}

procedure TerminateThreads;
begin
  if TDSSessionManager.Instance <> nil then
    TDSSessionManager.Instance.TerminateAllSessions;
end;

function BindPort(Aport: Integer): Boolean;
var
  LTestServer: IIPTestServer;
begin
  Result := True;
  try
    LTestServer := PeerFactory.CreatePeer('', IIPTestServer) as IIPTestServer;
    LTestServer.TestOpenPort(APort, nil);
  except
    Result := False;
  end;
end;

function CheckPort(Aport: Integer): Integer;
begin
  if BindPort(Aport) then
    Result := Aport
  else
    Result := 0;
end;

procedure SetPort(const Aserver: TIdHTTPWebBrokerBridge; APort: String);
begin
  if not (Aserver.Active) then
  begin
    APort := APort.Replace(cCommandSetPort, '').Trim;
    if CheckPort(APort.ToInteger) > 0 then
    begin
      Aserver.DefaultPort := APort.ToInteger;
      Writeln(Format(sPortSet, [APort]));
    end
    else
      Writeln(Format(sPortInUse, [Aport]));
  end
  else
    Writeln(sServerRunning);
  Write(cArrow);
end;

procedure StartServer(const Aserver: TIdHTTPWebBrokerBridge);
begin
  if not (Aserver.Active) then
  begin
    if CheckPort(Aserver.DefaultPort) > 0 then
    begin
      Writeln(Format(sStartingServer, [Aserver.DefaultPort]));
      Aserver.Bindings.Clear;
      Aserver.Active := True;
    end
    else
      Writeln(Format(sPortInUse, [Aserver.DefaultPort.ToString]));
  end
  else
    Writeln(sServerRunning);
  Write(cArrow);
end;

procedure StopServer(const Aserver: TIdHTTPWebBrokerBridge);
begin
  if Aserver.Active  then
  begin
    Writeln(sStoppingServer);
    TerminateThreads;
    Aserver.Active := False;
    Aserver.Bindings.Clear;
    Writeln(sServerStopped);
  end
  else
    Writeln(sServerNotRunning);
  Write(cArrow);
end;

procedure WriteCommands;
begin
  Writeln(sCommands);
  Write(cArrow);
end;

procedure WriteStatus(const Aserver: TIdHTTPWebBrokerBridge);
begin
  Writeln(sIndyVersion + Aserver.SessionList.Version);
  Writeln(sActive + Aserver.Active.ToString(TUseBoolStrs.True));
  Writeln(sPort + Aserver.DefaultPort.ToString);
  Writeln(sSessionID + Aserver.SessionIDCookieName);
  Write(cArrow);
end;

procedure RunServer(APort: Integer);
var
  LServer: TIdHTTPWebBrokerBridge;
  LResponse: string;
begin
  WriteCommands;
  LServer := TIdHTTPWebBrokerBridge.Create(nil);
  try
    LServer.DefaultPort := APort;
    while True do
    begin
      Readln(LResponse);
      LResponse := LowerCase(LResponse);
      if LResponse.StartsWith(cCommandSetPort) then
        SetPort(LServer, LResponse)
      else if sametext(LResponse, cCommandStart) then
        StartServer(LServer)
      else if sametext(LResponse, cCommandStatus) then
        WriteStatus(LServer)
      else if sametext(LResponse, cCommandStop) then
        StopServer(LServer)
      else if sametext(LResponse, cCommandHelp) then
        WriteCommands
      else if sametext(LResponse, cCommandExit) then
        if LServer.Active then
        begin
          StopServer(LServer);
          break
        end
        else
          break
      else
      begin
        Writeln(sInvalidCommand);
        Write(cArrow);
      end;
    end;
    TerminateThreads();
  finally
    LServer.Free;
  end;
end;

begin
  try
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
    RunServer(8080);
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end
end.
