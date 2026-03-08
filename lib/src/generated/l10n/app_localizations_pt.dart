// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'ShadowSync';

  @override
  String get appSubtitle => 'Gerenciador de Backups';

  @override
  String get myRoutines => 'Minhas Rotinas';

  @override
  String get verifyDisk => 'Verificar Disco';

  @override
  String get decrypt => 'Descriptografar';

  @override
  String get settings => 'Configurações';

  @override
  String startingBackup(String routineName) {
    return 'Iniciando backup \"$routineName\"...';
  }

  @override
  String get deleteRoutine => 'Excluir rotina';

  @override
  String deleteRoutineConfirm(String routineName) {
    return 'Deseja realmente excluir a rotina \"$routineName\"? Esta ação não pode ser desfeita.';
  }

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Excluir';

  @override
  String get noRoutines => 'Nenhuma rotina configurada';

  @override
  String get noScheduledBackups => 'Sem backups automáticos agendados';

  @override
  String get serviceActive => 'Serviço ativo';

  @override
  String nextBackup(String name, String time) {
    return 'Próximo: \"$name\" $time';
  }

  @override
  String get today => 'hoje';

  @override
  String get tomorrow => 'amanhã';

  @override
  String get monday => 'seg';

  @override
  String get tuesday => 'ter';

  @override
  String get wednesday => 'qua';

  @override
  String get thursday => 'qui';

  @override
  String get friday => 'sex';

  @override
  String get saturday => 'sáb';

  @override
  String get sunday => 'dom';

  @override
  String get newBackup => 'Novo Backup';

  @override
  String get runBackup => 'Executar backup';

  @override
  String get deleteRoutineTooltip => 'Excluir rotina';

  @override
  String get manualExecution => 'Execução manual';

  @override
  String get noScheduleAvailable => 'Não agendado';

  @override
  String scheduledDaily(String time) {
    return 'Agendado: Diariamente às $time';
  }

  @override
  String scheduledWeekly(String date) {
    return 'Agendado: Semanalmente • $date';
  }

  @override
  String scheduledInterval(String interval) {
    return 'Agendado: A cada $interval';
  }

  @override
  String get mode => 'Modo: ';

  @override
  String get next => 'Próximo: ';

  @override
  String get last => 'Último: ';

  @override
  String get lastBackupLabel => 'Último backup: ';

  @override
  String fileCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count arquivos',
      one: '1 arquivo',
    );
    return '$_temp0';
  }

  @override
  String extractedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count extraídos',
      one: '1 extraído',
    );
    return '$_temp0';
  }

  @override
  String get general => 'Geral';

  @override
  String get telegram => 'Telegram';

  @override
  String get email => 'Email';

  @override
  String get userName => 'Nome do Usuário';

  @override
  String get enterYourName => 'Digite seu nome';

  @override
  String get encryptionPassword => 'Senha de Criptografia';

  @override
  String get encryptionPasswordHint =>
      'Usada para proteger seus backups criptografados';

  @override
  String get enterPassword => 'Digite a senha';

  @override
  String get backupFileName => 'Nome do Arquivo de Backup';

  @override
  String get useCustomName => 'Usar nome personalizado';

  @override
  String get customName => 'Nome personalizado';

  @override
  String get telegramNotifications => 'Notificações via Telegram';

  @override
  String get telegramDescription =>
      'Receba alertas sobre seus backups pelo Telegram';

  @override
  String get enableNotifications => 'Habilitar notificações';

  @override
  String get botToken => 'Bot Token';

  @override
  String get botTokenHint => 'Crie um bot com @BotFather no Telegram';

  @override
  String get botTokenExample => '123456789:ABCdefGHI...';

  @override
  String get chatId => 'Chat ID';

  @override
  String get chatIdHint => 'Envie /start ao bot e use @userinfobot para obter';

  @override
  String get chatIdExample => 'Seu Chat ID (ex: 123456789)';

  @override
  String get whenNotify => 'Quando Notificar';

  @override
  String get backupSuccess => 'Backup concluído com sucesso';

  @override
  String get backupFailed => 'Backup falhou';

  @override
  String get backupStarted => 'Backup iniciado';

  @override
  String get sending => 'Enviando...';

  @override
  String get sendTest => 'Enviar Teste';

  @override
  String get emailNotifications => 'Notificações via Email';

  @override
  String get emailDescription => 'Receba alertas sobre seus backups por email';

  @override
  String get emailProvider => 'Provedor de Email';

  @override
  String get emailProviderHint =>
      'Selecione seu provedor ou configure manualmente';

  @override
  String get selectProvider => 'Selecione um provedor';

  @override
  String get smtpServer => 'Servidor SMTP';

  @override
  String get smtpServerExample => 'Ex: smtp.gmail.com';

  @override
  String get smtpServerPlaceholder => 'smtp.example.com';

  @override
  String get smtpPort => 'Porta SMTP';

  @override
  String get smtpPortHint => '587 para TLS, 465 para SSL';

  @override
  String get smtpPortPlaceholder => '587';

  @override
  String get yourEmail => 'Seu Email';

  @override
  String get yourEmailHint => 'Email que será usado para enviar notificações';

  @override
  String get yourEmailPlaceholder => 'seuemail@gmail.com';

  @override
  String get emailPassword => 'Senha ou App Password';

  @override
  String get emailPasswordHint =>
      'Use App Password se tiver autenticação em 2 etapas';

  @override
  String get emailPasswordPlaceholder => 'Sua senha ou App Password';

  @override
  String get destinationEmails => 'Emails de Destino';

  @override
  String get destinationEmailsHint => 'Separe múltiplos emails por vírgula';

  @override
  String get destinationEmailsPlaceholder =>
      'email1@exemplo.com, email2@exemplo.com';

  @override
  String get security => 'Segurança';

  @override
  String get useStartTls => 'Usar STARTTLS (recomendado)';

  @override
  String get useSsl => 'Usar SSL';

  @override
  String get save => 'Salvar';

  @override
  String get fillBotTokenAndChatId =>
      'Preencha o Bot Token e o Chat ID para enviar teste';

  @override
  String get testMessageSent => 'Mensagem de teste enviada com sucesso!';

  @override
  String errorWithMessage(String message) {
    return 'Erro: $message';
  }

  @override
  String get fillAllFields => 'Preencha todos os campos obrigatórios';

  @override
  String get enterAtLeastOneEmail => 'Insira pelo menos um email de destino';

  @override
  String get testEmailSent => 'Email de teste enviado com sucesso!';

  @override
  String get basicData => 'Dados básicos';

  @override
  String get scheduling => 'Agendamento';

  @override
  String get processing => 'Processamento';

  @override
  String get review => 'Revisão';

  @override
  String get nextStep => 'Próximo';

  @override
  String get saveRoutine => 'Salvar Rotina';

  @override
  String get back => 'Voltar';

  @override
  String get routineName => 'Nome da rotina';

  @override
  String get backupSources => 'Origens do Backup';

  @override
  String get selectFilesAndFolders =>
      'Você pode selecionar arquivos e/ou pastas.';

  @override
  String get sourcePathsExample =>
      '/Users/meuuser/Documents;/Users/meuuser/Projetos';

  @override
  String get addSource => 'Adicionar Origem';

  @override
  String get selecting => 'Selecionando...';

  @override
  String get selectFiles => 'Selecionar Arquivo(s)';

  @override
  String get selectFolder => 'Selecionar Pasta';

  @override
  String get backupDestination => 'Destino do Backup';

  @override
  String get destinationDescription =>
      'Escolha a pasta onde os arquivos serão salvos.';

  @override
  String get destinationExample => '/Volumes/Backup/Destino';

  @override
  String get selectDestinationFolder => 'Selecionar Pasta de Destino';

  @override
  String get frequency => 'Frequência';

  @override
  String get manual => 'Manual';

  @override
  String get daily => 'Diário';

  @override
  String get weekly => 'Semanal';

  @override
  String get interval => 'Intervalo';

  @override
  String get runAt => 'Executar às:';

  @override
  String get runEvery => 'Executar a cada:';

  @override
  String get manualExecutionInfo =>
      'O backup será executado manualmente quando você pressionar o botão play no card.';

  @override
  String get oneMinute => '1 minuto';

  @override
  String nMinutes(int n) {
    return '$n minutos';
  }

  @override
  String get oneHour => '1 hora';

  @override
  String nHours(int n) {
    return '$n horas';
  }

  @override
  String get oneDay => '1 dia';

  @override
  String nDays(int n) {
    return '$n dias';
  }

  @override
  String get compressBackup => 'Compactar backup';

  @override
  String get compressionFormat => 'Formato de compactação';

  @override
  String get encryptBackup => 'Criptografar backup';

  @override
  String get name => 'Nome';

  @override
  String get sources => 'Origens';

  @override
  String get destination => 'Destino';

  @override
  String get schedule => 'Agendamento';

  @override
  String get compression => 'Compactação';

  @override
  String activeWithFormat(String format) {
    return 'Ativa ($format)';
  }

  @override
  String get deactivated => 'Desativada';

  @override
  String get encryption => 'Criptografia';

  @override
  String get active => 'Ativa';

  @override
  String get diskSpace => 'Espaço em Disco';

  @override
  String get calculatingSizes => 'Calculando tamanhos...';

  @override
  String get sourceSize => 'Tamanho da origem';

  @override
  String get notAvailable => 'Não disponível';

  @override
  String get availableSpace => 'Espaço disponível no destino';

  @override
  String get retention => 'Retenção (quantidade de versões)';

  @override
  String sufficientSpace(String percent) {
    return 'Espaço suficiente! Margem de $percent% disponível.';
  }

  @override
  String insufficientSpace(String size) {
    return 'Espaço insuficiente! Faltam $size no disco de destino.';
  }

  @override
  String get fileSelectionCancelled => 'Seleção de arquivos cancelada.';

  @override
  String filesAdded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count arquivos adicionados à origem.',
      one: '1 arquivo adicionado à origem.',
    );
    return '$_temp0';
  }

  @override
  String failedToSelectFiles(String error) {
    return 'Falha ao selecionar arquivos: $error';
  }

  @override
  String get folderSelectionCancelled =>
      'Seleção de pasta de origem cancelada.';

  @override
  String get sourceFolderSelected => 'Pasta de origem selecionada.';

  @override
  String failedToSelectSourceFolder(String error) {
    return 'Falha ao selecionar pasta de origem: $error';
  }

  @override
  String get iosSaveLocation =>
      'No iOS, os backups serão salvos em: Documentos/Backups';

  @override
  String get destinationSelectionCancelled =>
      'Seleção de pasta de destino cancelada.';

  @override
  String get destinationFolderSelected => 'Pasta de destino selecionada.';

  @override
  String failedToSelectDestination(String error) {
    return 'Falha ao selecionar pasta de destino: $error';
  }

  @override
  String get enterRoutineName => 'Informe o nome da rotina.';

  @override
  String get enterAtLeastOneSource => 'Informe ao menos uma origem.';

  @override
  String get enterDestinationPath => 'Informe o caminho de destino.';

  @override
  String get retentionMustBePositive =>
      'Retenção deve ser um número maior que zero.';

  @override
  String get configureEncryptionPassword =>
      'Configure uma senha de criptografia nas Configurações antes de habilitar a criptografia.';

  @override
  String get decryptFile => 'Descriptografar Arquivo';

  @override
  String get decryptionDescription =>
      'Descriptografe arquivos protegidos pelo ShadowSync';

  @override
  String get encryptedFile => 'Arquivo Criptografado';

  @override
  String get selectFileEllipsis => 'Selecionar arquivo...';

  @override
  String get destinationFolder => 'Pasta de Destino';

  @override
  String get selectFolderEllipsis => 'Selecionar pasta...';

  @override
  String get outputFileName => 'Nome do arquivo de saída:';

  @override
  String get decryptionPassword => 'Senha de descriptografia:';

  @override
  String get enterEncryptionPassword => 'Digite a senha usada na criptografia';

  @override
  String get selectEncryptedFile => 'Selecionar arquivo criptografado';

  @override
  String get selectDestinationFolderTooltip => 'Selecionar pasta de destino';

  @override
  String get execute => 'Executar';

  @override
  String get decrypting => 'Descriptografando...';

  @override
  String get close => 'Fechar';

  @override
  String get decryptAnother => 'Descriptografar Outro';

  @override
  String get startingDecryption => 'Iniciando descriptografia...';

  @override
  String get preparingDecryption => 'Preparando descriptografia...';

  @override
  String get decryptingFile => 'Descriptografando arquivo...';

  @override
  String get extractingContent => 'Extraindo conteúdo...';

  @override
  String get finalizing => 'Finalizando...';

  @override
  String decryptedSuccessfully(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count arquivos extraídos.',
      one: '1 arquivo extraído.',
    );
    return 'Descriptografado com sucesso! $_temp0';
  }

  @override
  String errorSelectingFile(String error) {
    return 'Erro ao selecionar arquivo: $error';
  }

  @override
  String errorSelectingDestination(String error) {
    return 'Erro ao selecionar destino: $error';
  }

  @override
  String get verifyDiskTitle => 'Verificar Disco';

  @override
  String get selectDiskToVerify =>
      'Selecione um disco para verificar sua integridade';

  @override
  String verifying(String diskName) {
    return 'Verificando: $diskName';
  }

  @override
  String get backToSelection => 'Voltar à seleção';

  @override
  String get loadingDisks => 'Carregando discos...';

  @override
  String errorLoadingDisks(String error) {
    return 'Erro ao carregar discos: $error';
  }

  @override
  String get tryAgain => 'Tentar novamente';

  @override
  String get noDisksFound => 'Nenhum disco encontrado';

  @override
  String freeSpace(String size) {
    return '$size livres';
  }

  @override
  String get diskSpaceUnavailable => 'Informações de espaço indisponíveis';

  @override
  String get internalStorage => 'Armazenamento Interno';

  @override
  String get sdCard => 'Cartão SD';

  @override
  String get externalSdCard => 'Cartão SD Externo';

  @override
  String get primaryStorage => 'Armazenamento Principal';

  @override
  String get externalStorage => 'Armazenamento Externo';

  @override
  String get deviceStorage => 'Armazenamento do Dispositivo';

  @override
  String get appStorage => 'Armazenamento do App';

  @override
  String get testsToRun => 'Testes que serão executados:';

  @override
  String get testResults => 'Resultados dos Testes';

  @override
  String get verificationInProgress => 'Verificação em andamento...';

  @override
  String get diskVerifiedNoProblems =>
      'Disco verificado - Nenhum problema encontrado';

  @override
  String get verificationCompletedWithWarnings =>
      'Verificação concluída com avisos';

  @override
  String get problemsDetected => 'Problemas detectados no disco';

  @override
  String get waiting => 'Aguardando...';

  @override
  String totalTime(String duration) {
    return 'Tempo total: $duration';
  }

  @override
  String get mountPoint => 'Ponto de montagem';

  @override
  String get device => 'Dispositivo';

  @override
  String get fileSystem => 'Sistema de arquivos';

  @override
  String get totalCapacity => 'Capacidade total';

  @override
  String get availableSpaceLabel => 'Espaço disponível';

  @override
  String get mediaType => 'Tipo de mídia';

  @override
  String get type => 'Tipo';

  @override
  String get removable => 'Removível';

  @override
  String get internal => 'Interno';

  @override
  String get startVerification => 'Iniciar Verificação';

  @override
  String get verifyAgain => 'Verificar Novamente';

  @override
  String get testAccessibilityCheck => 'Verificação de Acessibilidade';

  @override
  String get testSpaceAnalysis => 'Análise de Espaço em Disco';

  @override
  String get testReadTest => 'Teste de Leitura';

  @override
  String get testFileSystemCheck => 'Verificação do Sistema de Ficheiros';

  @override
  String get testSmartStatus => 'Estado S.M.A.R.T.';

  @override
  String get fullDiskAccessRequired =>
      'Acesso negado. No macOS, conceda \"Acesso Total ao Disco\" ao ShadowSync em Ajustes do Sistema > Privacidade e Segurança > Acesso Total ao Disco.';

  @override
  String get fileSystemCheckRequiresPrivileges =>
      'Verificação de sistema de arquivos requer acesso privilegiado do sistema. Use o aplicativo \"Utilidades de Disco\" do macOS para verificar este volume manualmente.';

  @override
  String get language => 'Idioma';

  @override
  String get languagePortuguese => 'Português (Brasil)';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageFrench => 'Français';

  @override
  String get languageGerman => 'Deutsch';

  @override
  String get languageSpanish => 'Español';

  @override
  String get languageItalian => 'Italiano';

  @override
  String get languageJapanese => '日本語';

  @override
  String get languageChinese => '中文 (简体)';

  @override
  String get languageKorean => '한국어';

  @override
  String get scheduleTypeManual => 'Manual';

  @override
  String get scheduleTypeDaily => 'Diário';

  @override
  String get scheduleTypeWeekly => 'Semanal';

  @override
  String get scheduleTypeInterval => 'Intervalo';

  @override
  String get backupName => 'Nome';

  @override
  String get backupSource => 'Origens';

  @override
  String get backupCompression => 'Compactação';

  @override
  String get backupEncryption => 'Criptografia';

  @override
  String get encryptionActive => 'Ativa';

  @override
  String get noRoutinesConfigured => 'Nenhuma rotina configurada';

  @override
  String nextBackupFormat(String routineName, String time) {
    return 'Próximo: \"$routineName\" $time';
  }

  @override
  String diskSpaceSufficient(String margin) {
    return 'Espaço suficiente! Margem de $margin% disponível.';
  }

  @override
  String diskSpaceInsufficient(String deficit) {
    return 'Espaço insuficiente! Faltam $deficit no disco de destino.';
  }

  @override
  String get dateToday => 'hoje';

  @override
  String get dateTomorrow => 'amanhã';

  @override
  String get weekdayMonday => 'seg';

  @override
  String get weekdayTuesday => 'ter';

  @override
  String get weekdayWednesday => 'qua';

  @override
  String get weekdayThursday => 'qui';

  @override
  String get weekdayFriday => 'sex';

  @override
  String get weekdaySaturday => 'sáb';

  @override
  String get weekdaySunday => 'dom';

  @override
  String get about => 'Sobre';

  @override
  String get aboutTitle => 'Sobre o ShadowSync';

  @override
  String get version => 'Versão';

  @override
  String get developer => 'Desenvolvedor';

  @override
  String get visitWebsite => 'Visitar Site';
}

/// The translations for Portuguese, as used in Brazil (`pt_BR`).
class AppLocalizationsPtBr extends AppLocalizationsPt {
  AppLocalizationsPtBr() : super('pt_BR');

  @override
  String get appTitle => 'ShadowSync';

  @override
  String get appSubtitle => 'Gerenciador de Backups';

  @override
  String get myRoutines => 'Minhas Rotinas';

  @override
  String get verifyDisk => 'Verificar Disco';

  @override
  String get decrypt => 'Descriptografar';

  @override
  String get settings => 'Configurações';

  @override
  String startingBackup(String routineName) {
    return 'Iniciando backup \"$routineName\"...';
  }

  @override
  String get deleteRoutine => 'Excluir rotina';

  @override
  String deleteRoutineConfirm(String routineName) {
    return 'Deseja realmente excluir a rotina \"$routineName\"? Esta ação não pode ser desfeita.';
  }

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Excluir';

  @override
  String get noRoutines => 'Nenhuma rotina configurada';

  @override
  String get noScheduledBackups => 'Sem backups automáticos agendados';

  @override
  String get serviceActive => 'Serviço ativo';

  @override
  String nextBackup(String name, String time) {
    return 'Próximo: \"$name\" $time';
  }

  @override
  String get today => 'hoje';

  @override
  String get tomorrow => 'amanhã';

  @override
  String get monday => 'seg';

  @override
  String get tuesday => 'ter';

  @override
  String get wednesday => 'qua';

  @override
  String get thursday => 'qui';

  @override
  String get friday => 'sex';

  @override
  String get saturday => 'sáb';

  @override
  String get sunday => 'dom';

  @override
  String get newBackup => 'Novo Backup';

  @override
  String get runBackup => 'Executar backup';

  @override
  String get deleteRoutineTooltip => 'Excluir rotina';

  @override
  String get manualExecution => 'Execução manual';

  @override
  String get noScheduleAvailable => 'Não agendado';

  @override
  String scheduledDaily(String time) {
    return 'Agendado: Diariamente às $time';
  }

  @override
  String scheduledWeekly(String date) {
    return 'Agendado: Semanalmente • $date';
  }

  @override
  String scheduledInterval(String interval) {
    return 'Agendado: A cada $interval';
  }

  @override
  String get mode => 'Modo: ';

  @override
  String get next => 'Próximo: ';

  @override
  String get last => 'Último: ';

  @override
  String get lastBackupLabel => 'Último backup: ';

  @override
  String fileCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count arquivos',
      one: '1 arquivo',
    );
    return '$_temp0';
  }

  @override
  String extractedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count extraídos',
      one: '1 extraído',
    );
    return '$_temp0';
  }

  @override
  String get general => 'Geral';

  @override
  String get telegram => 'Telegram';

  @override
  String get email => 'Email';

  @override
  String get userName => 'Nome do Usuário';

  @override
  String get enterYourName => 'Digite seu nome';

  @override
  String get encryptionPassword => 'Senha de Criptografia';

  @override
  String get encryptionPasswordHint =>
      'Usada para proteger seus backups criptografados';

  @override
  String get enterPassword => 'Digite a senha';

  @override
  String get backupFileName => 'Nome do Arquivo de Backup';

  @override
  String get useCustomName => 'Usar nome personalizado';

  @override
  String get customName => 'Nome personalizado';

  @override
  String get telegramNotifications => 'Notificações via Telegram';

  @override
  String get telegramDescription =>
      'Receba alertas sobre seus backups pelo Telegram';

  @override
  String get enableNotifications => 'Habilitar notificações';

  @override
  String get botToken => 'Bot Token';

  @override
  String get botTokenHint => 'Crie um bot com @BotFather no Telegram';

  @override
  String get botTokenExample => '123456789:ABCdefGHI...';

  @override
  String get chatId => 'Chat ID';

  @override
  String get chatIdHint => 'Envie /start ao bot e use @userinfobot para obter';

  @override
  String get chatIdExample => 'Seu Chat ID (ex: 123456789)';

  @override
  String get whenNotify => 'Quando Notificar';

  @override
  String get backupSuccess => 'Backup concluído com sucesso';

  @override
  String get backupFailed => 'Backup falhou';

  @override
  String get backupStarted => 'Backup iniciado';

  @override
  String get sending => 'Enviando...';

  @override
  String get sendTest => 'Enviar Teste';

  @override
  String get emailNotifications => 'Notificações via Email';

  @override
  String get emailDescription => 'Receba alertas sobre seus backups por email';

  @override
  String get emailProvider => 'Provedor de Email';

  @override
  String get emailProviderHint =>
      'Selecione seu provedor ou configure manualmente';

  @override
  String get selectProvider => 'Selecione um provedor';

  @override
  String get smtpServer => 'Servidor SMTP';

  @override
  String get smtpServerExample => 'Ex: smtp.gmail.com';

  @override
  String get smtpServerPlaceholder => 'smtp.example.com';

  @override
  String get smtpPort => 'Porta SMTP';

  @override
  String get smtpPortHint => '587 para TLS, 465 para SSL';

  @override
  String get smtpPortPlaceholder => '587';

  @override
  String get yourEmail => 'Seu Email';

  @override
  String get yourEmailHint => 'Email que será usado para enviar notificações';

  @override
  String get yourEmailPlaceholder => 'seuemail@gmail.com';

  @override
  String get emailPassword => 'Senha ou App Password';

  @override
  String get emailPasswordHint =>
      'Use App Password se tiver autenticação em 2 etapas';

  @override
  String get emailPasswordPlaceholder => 'Sua senha ou App Password';

  @override
  String get destinationEmails => 'Emails de Destino';

  @override
  String get destinationEmailsHint => 'Separe múltiplos emails por vírgula';

  @override
  String get destinationEmailsPlaceholder =>
      'email1@exemplo.com, email2@exemplo.com';

  @override
  String get security => 'Segurança';

  @override
  String get useStartTls => 'Usar STARTTLS (recomendado)';

  @override
  String get useSsl => 'Usar SSL';

  @override
  String get save => 'Salvar';

  @override
  String get fillBotTokenAndChatId =>
      'Preencha o Bot Token e o Chat ID para enviar teste';

  @override
  String get testMessageSent => 'Mensagem de teste enviada com sucesso!';

  @override
  String errorWithMessage(String message) {
    return 'Erro: $message';
  }

  @override
  String get fillAllFields => 'Preencha todos os campos obrigatórios';

  @override
  String get enterAtLeastOneEmail => 'Insira pelo menos um email de destino';

  @override
  String get testEmailSent => 'Email de teste enviado com sucesso!';

  @override
  String get basicData => 'Dados básicos';

  @override
  String get scheduling => 'Agendamento';

  @override
  String get processing => 'Processamento';

  @override
  String get review => 'Revisão';

  @override
  String get nextStep => 'Próximo';

  @override
  String get saveRoutine => 'Salvar Rotina';

  @override
  String get back => 'Voltar';

  @override
  String get routineName => 'Nome da rotina';

  @override
  String get backupSources => 'Origens do Backup';

  @override
  String get selectFilesAndFolders =>
      'Você pode selecionar arquivos e/ou pastas.';

  @override
  String get sourcePathsExample =>
      '/Users/meuuser/Documents;/Users/meuuser/Projetos';

  @override
  String get addSource => 'Adicionar Origem';

  @override
  String get selecting => 'Selecionando...';

  @override
  String get selectFiles => 'Selecionar Arquivo(s)';

  @override
  String get selectFolder => 'Selecionar Pasta';

  @override
  String get backupDestination => 'Destino do Backup';

  @override
  String get destinationDescription =>
      'Escolha a pasta onde os arquivos serão salvos.';

  @override
  String get destinationExample => '/Volumes/Backup/Destino';

  @override
  String get selectDestinationFolder => 'Selecionar Pasta de Destino';

  @override
  String get frequency => 'Frequência';

  @override
  String get manual => 'Manual';

  @override
  String get daily => 'Diário';

  @override
  String get weekly => 'Semanal';

  @override
  String get interval => 'Intervalo';

  @override
  String get runAt => 'Executar às:';

  @override
  String get runEvery => 'Executar a cada:';

  @override
  String get manualExecutionInfo =>
      'O backup será executado manualmente quando você pressionar o botão play no card.';

  @override
  String get oneMinute => '1 minuto';

  @override
  String nMinutes(int n) {
    return '$n minutos';
  }

  @override
  String get oneHour => '1 hora';

  @override
  String nHours(int n) {
    return '$n horas';
  }

  @override
  String get oneDay => '1 dia';

  @override
  String nDays(int n) {
    return '$n dias';
  }

  @override
  String get compressBackup => 'Compactar backup';

  @override
  String get compressionFormat => 'Formato de compactação';

  @override
  String get encryptBackup => 'Criptografar backup';

  @override
  String get name => 'Nome';

  @override
  String get sources => 'Origens';

  @override
  String get destination => 'Destino';

  @override
  String get schedule => 'Agendamento';

  @override
  String get compression => 'Compactação';

  @override
  String activeWithFormat(String format) {
    return 'Ativa ($format)';
  }

  @override
  String get deactivated => 'Desativada';

  @override
  String get encryption => 'Criptografia';

  @override
  String get active => 'Ativa';

  @override
  String get diskSpace => 'Espaço em Disco';

  @override
  String get calculatingSizes => 'Calculando tamanhos...';

  @override
  String get sourceSize => 'Tamanho da origem';

  @override
  String get notAvailable => 'Não disponível';

  @override
  String get availableSpace => 'Espaço disponível no destino';

  @override
  String get retention => 'Retenção (quantidade de versões)';

  @override
  String sufficientSpace(String percent) {
    return 'Espaço suficiente! Margem de $percent% disponível.';
  }

  @override
  String insufficientSpace(String size) {
    return 'Espaço insuficiente! Faltam $size no disco de destino.';
  }

  @override
  String get fileSelectionCancelled => 'Seleção de arquivos cancelada.';

  @override
  String filesAdded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count arquivos adicionados à origem.',
      one: '1 arquivo adicionado à origem.',
    );
    return '$_temp0';
  }

  @override
  String failedToSelectFiles(String error) {
    return 'Falha ao selecionar arquivos: $error';
  }

  @override
  String get folderSelectionCancelled =>
      'Seleção de pasta de origem cancelada.';

  @override
  String get sourceFolderSelected => 'Pasta de origem selecionada.';

  @override
  String failedToSelectSourceFolder(String error) {
    return 'Falha ao selecionar pasta de origem: $error';
  }

  @override
  String get iosSaveLocation =>
      'No iOS, os backups serão salvos em: Documentos/Backups';

  @override
  String get destinationSelectionCancelled =>
      'Seleção de pasta de destino cancelada.';

  @override
  String get destinationFolderSelected => 'Pasta de destino selecionada.';

  @override
  String failedToSelectDestination(String error) {
    return 'Falha ao selecionar pasta de destino: $error';
  }

  @override
  String get enterRoutineName => 'Informe o nome da rotina.';

  @override
  String get enterAtLeastOneSource => 'Informe ao menos uma origem.';

  @override
  String get enterDestinationPath => 'Informe o caminho de destino.';

  @override
  String get retentionMustBePositive =>
      'Retenção deve ser um número maior que zero.';

  @override
  String get configureEncryptionPassword =>
      'Configure uma senha de criptografia nas Configurações antes de habilitar a criptografia.';

  @override
  String get decryptFile => 'Descriptografar Arquivo';

  @override
  String get decryptionDescription =>
      'Descriptografe arquivos protegidos pelo ShadowSync';

  @override
  String get encryptedFile => 'Arquivo Criptografado';

  @override
  String get selectFileEllipsis => 'Selecionar arquivo...';

  @override
  String get destinationFolder => 'Pasta de Destino';

  @override
  String get selectFolderEllipsis => 'Selecionar pasta...';

  @override
  String get outputFileName => 'Nome do arquivo de saída:';

  @override
  String get decryptionPassword => 'Senha de descriptografia:';

  @override
  String get enterEncryptionPassword => 'Digite a senha usada na criptografia';

  @override
  String get selectEncryptedFile => 'Selecionar arquivo criptografado';

  @override
  String get selectDestinationFolderTooltip => 'Selecionar pasta de destino';

  @override
  String get execute => 'Executar';

  @override
  String get decrypting => 'Descriptografando...';

  @override
  String get close => 'Fechar';

  @override
  String get decryptAnother => 'Descriptografar Outro';

  @override
  String get startingDecryption => 'Iniciando descriptografia...';

  @override
  String get preparingDecryption => 'Preparando descriptografia...';

  @override
  String get decryptingFile => 'Descriptografando arquivo...';

  @override
  String get extractingContent => 'Extraindo conteúdo...';

  @override
  String get finalizing => 'Finalizando...';

  @override
  String decryptedSuccessfully(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count arquivos extraídos.',
      one: '1 arquivo extraído.',
    );
    return 'Descriptografado com sucesso! $_temp0';
  }

  @override
  String errorSelectingFile(String error) {
    return 'Erro ao selecionar arquivo: $error';
  }

  @override
  String errorSelectingDestination(String error) {
    return 'Erro ao selecionar destino: $error';
  }

  @override
  String get verifyDiskTitle => 'Verificar Disco';

  @override
  String get selectDiskToVerify =>
      'Selecione um disco para verificar sua integridade';

  @override
  String verifying(String diskName) {
    return 'Verificando: $diskName';
  }

  @override
  String get backToSelection => 'Voltar à seleção';

  @override
  String get loadingDisks => 'Carregando discos...';

  @override
  String errorLoadingDisks(String error) {
    return 'Erro ao carregar discos: $error';
  }

  @override
  String get tryAgain => 'Tentar novamente';

  @override
  String get noDisksFound => 'Nenhum disco encontrado';

  @override
  String freeSpace(String size) {
    return '$size livres';
  }

  @override
  String get diskSpaceUnavailable => 'Informações de espaço indisponíveis';

  @override
  String get internalStorage => 'Armazenamento Interno';

  @override
  String get sdCard => 'Cartão SD';

  @override
  String get externalSdCard => 'Cartão SD Externo';

  @override
  String get primaryStorage => 'Armazenamento Principal';

  @override
  String get externalStorage => 'Armazenamento Externo';

  @override
  String get deviceStorage => 'Armazenamento do Dispositivo';

  @override
  String get appStorage => 'Armazenamento do App';

  @override
  String get testsToRun => 'Testes que serão executados:';

  @override
  String get testResults => 'Resultados dos Testes';

  @override
  String get verificationInProgress => 'Verificação em andamento...';

  @override
  String get diskVerifiedNoProblems =>
      'Disco verificado - Nenhum problema encontrado';

  @override
  String get verificationCompletedWithWarnings =>
      'Verificação concluída com avisos';

  @override
  String get problemsDetected => 'Problemas detectados no disco';

  @override
  String get waiting => 'Aguardando...';

  @override
  String totalTime(String duration) {
    return 'Tempo total: $duration';
  }

  @override
  String get mountPoint => 'Ponto de montagem';

  @override
  String get device => 'Dispositivo';

  @override
  String get fileSystem => 'Sistema de arquivos';

  @override
  String get totalCapacity => 'Capacidade total';

  @override
  String get availableSpaceLabel => 'Espaço disponível';

  @override
  String get mediaType => 'Tipo de mídia';

  @override
  String get type => 'Tipo';

  @override
  String get removable => 'Removível';

  @override
  String get internal => 'Interno';

  @override
  String get startVerification => 'Iniciar Verificação';

  @override
  String get verifyAgain => 'Verificar Novamente';

  @override
  String get testAccessibilityCheck => 'Verificação de Acessibilidade';

  @override
  String get testSpaceAnalysis => 'Análise de Espaço em Disco';

  @override
  String get testReadTest => 'Teste de Leitura';

  @override
  String get testFileSystemCheck => 'Verificação do Sistema de Arquivos';

  @override
  String get testSmartStatus => 'Status S.M.A.R.T.';

  @override
  String get fullDiskAccessRequired =>
      'Acesso negado. No macOS, conceda \"Acesso Total ao Disco\" ao ShadowSync em Ajustes do Sistema > Privacidade e Segurança > Acesso Total ao Disco.';

  @override
  String get fileSystemCheckRequiresPrivileges =>
      'Verificação de sistema de arquivos requer acesso privilegiado do sistema. Use o aplicativo \"Utilidades de Disco\" do macOS para verificar este volume manualmente.';

  @override
  String get language => 'Idioma';

  @override
  String get languagePortuguese => 'Português (Brasil)';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageFrench => 'Français';

  @override
  String get languageGerman => 'Deutsch';

  @override
  String get languageSpanish => 'Español';

  @override
  String get languageItalian => 'Italiano';

  @override
  String get languageJapanese => '日本語';

  @override
  String get languageChinese => '中文 (简体)';

  @override
  String get languageKorean => '한국어';

  @override
  String get scheduleTypeManual => 'Manual';

  @override
  String get scheduleTypeDaily => 'Diário';

  @override
  String get scheduleTypeWeekly => 'Semanal';

  @override
  String get scheduleTypeInterval => 'Intervalo';

  @override
  String get backupName => 'Nome';

  @override
  String get backupSource => 'Origens';

  @override
  String get backupCompression => 'Compactação';

  @override
  String get backupEncryption => 'Criptografia';

  @override
  String get encryptionActive => 'Ativa';

  @override
  String get noRoutinesConfigured => 'Nenhuma rotina configurada';

  @override
  String nextBackupFormat(String routineName, String time) {
    return 'Próximo: \"$routineName\" $time';
  }

  @override
  String diskSpaceSufficient(String margin) {
    return 'Espaço suficiente! Margem de $margin% disponível.';
  }

  @override
  String diskSpaceInsufficient(String deficit) {
    return 'Espaço insuficiente! Faltam $deficit no disco de destino.';
  }

  @override
  String get dateToday => 'hoje';

  @override
  String get dateTomorrow => 'amanhã';

  @override
  String get weekdayMonday => 'seg';

  @override
  String get weekdayTuesday => 'ter';

  @override
  String get weekdayWednesday => 'qua';

  @override
  String get weekdayThursday => 'qui';

  @override
  String get weekdayFriday => 'sex';

  @override
  String get weekdaySaturday => 'sáb';

  @override
  String get weekdaySunday => 'dom';

  @override
  String get about => 'Sobre';

  @override
  String get aboutTitle => 'Sobre o ShadowSync';

  @override
  String get version => 'Versão';

  @override
  String get developer => 'Desenvolvedor';

  @override
  String get visitWebsite => 'Visitar Site';
}
