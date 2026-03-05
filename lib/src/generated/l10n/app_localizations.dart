import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt'),
    Locale('pt', 'BR'),
  ];

  /// Título do aplicativo
  ///
  /// In pt_BR, this message translates to:
  /// **'ShadowSync'**
  String get appTitle;

  /// Subtítulo do aplicativo
  ///
  /// In pt_BR, this message translates to:
  /// **'Gerenciador de Backups'**
  String get appSubtitle;

  /// Título da seção de rotinas
  ///
  /// In pt_BR, this message translates to:
  /// **'Minhas Rotinas'**
  String get myRoutines;

  /// Opção de verificar disco
  ///
  /// In pt_BR, this message translates to:
  /// **'Verificar Disco'**
  String get verifyDisk;

  /// Opção de descriptografar
  ///
  /// In pt_BR, this message translates to:
  /// **'Descriptografar'**
  String get decrypt;

  /// Página de configurações
  ///
  /// In pt_BR, this message translates to:
  /// **'Configurações'**
  String get settings;

  /// Mensagem ao iniciar backup
  ///
  /// In pt_BR, this message translates to:
  /// **'Iniciando backup \"{routineName}\"...'**
  String startingBackup(String routineName);

  /// Título do diálogo de exclusão
  ///
  /// In pt_BR, this message translates to:
  /// **'Excluir rotina'**
  String get deleteRoutine;

  /// Mensagem de confirmação de exclusão
  ///
  /// In pt_BR, this message translates to:
  /// **'Deseja realmente excluir a rotina \"{routineName}\"? Esta ação não pode ser desfeita.'**
  String deleteRoutineConfirm(String routineName);

  /// Botão cancelar
  ///
  /// In pt_BR, this message translates to:
  /// **'Cancelar'**
  String get cancel;

  /// Botão excluir
  ///
  /// In pt_BR, this message translates to:
  /// **'Excluir'**
  String get delete;

  /// Mensagem quando não há rotinas
  ///
  /// In pt_BR, this message translates to:
  /// **'Nenhuma rotina configurada'**
  String get noRoutines;

  /// Mensagem quando não há backups automáticos agendados
  ///
  /// In pt_BR, this message translates to:
  /// **'Sem backups automáticos agendados'**
  String get noScheduledBackups;

  /// Mensagem de status do serviço
  ///
  /// In pt_BR, this message translates to:
  /// **'Serviço ativo'**
  String get serviceActive;

  /// Próximo backup agendado
  ///
  /// In pt_BR, this message translates to:
  /// **'Próximo: \"{name}\" {time}'**
  String nextBackup(String name, String time);

  /// Hoje
  ///
  /// In pt_BR, this message translates to:
  /// **'hoje'**
  String get today;

  /// Amanhã
  ///
  /// In pt_BR, this message translates to:
  /// **'amanhã'**
  String get tomorrow;

  /// Segunda-feira (abreviado)
  ///
  /// In pt_BR, this message translates to:
  /// **'seg'**
  String get monday;

  /// Terça-feira (abreviado)
  ///
  /// In pt_BR, this message translates to:
  /// **'ter'**
  String get tuesday;

  /// Quarta-feira (abreviado)
  ///
  /// In pt_BR, this message translates to:
  /// **'qua'**
  String get wednesday;

  /// Quinta-feira (abreviado)
  ///
  /// In pt_BR, this message translates to:
  /// **'qui'**
  String get thursday;

  /// Sexta-feira (abreviado)
  ///
  /// In pt_BR, this message translates to:
  /// **'sex'**
  String get friday;

  /// Sábado (abreviado)
  ///
  /// In pt_BR, this message translates to:
  /// **'sáb'**
  String get saturday;

  /// Domingo (abreviado)
  ///
  /// In pt_BR, this message translates to:
  /// **'dom'**
  String get sunday;

  /// Botão para criar novo backup
  ///
  /// In pt_BR, this message translates to:
  /// **'Novo Backup'**
  String get newBackup;

  /// Tooltip para executar backup
  ///
  /// In pt_BR, this message translates to:
  /// **'Executar backup'**
  String get runBackup;

  /// Tooltip para excluir rotina
  ///
  /// In pt_BR, this message translates to:
  /// **'Excluir rotina'**
  String get deleteRoutineTooltip;

  /// Modo de execução manual
  ///
  /// In pt_BR, this message translates to:
  /// **'Execução manual'**
  String get manualExecution;

  /// Quando não há próximo agendamento disponível
  ///
  /// In pt_BR, this message translates to:
  /// **'Não agendado'**
  String get noScheduleAvailable;

  /// Agendamento diário
  ///
  /// In pt_BR, this message translates to:
  /// **'Agendado: Diariamente às {time}'**
  String scheduledDaily(String time);

  /// Agendamento semanal
  ///
  /// In pt_BR, this message translates to:
  /// **'Agendado: Semanalmente • {date}'**
  String scheduledWeekly(String date);

  /// Agendamento por intervalo
  ///
  /// In pt_BR, this message translates to:
  /// **'Agendado: A cada {interval}'**
  String scheduledInterval(String interval);

  /// Label de modo
  ///
  /// In pt_BR, this message translates to:
  /// **'Modo: '**
  String get mode;

  /// Label de próximo
  ///
  /// In pt_BR, this message translates to:
  /// **'Próximo: '**
  String get next;

  /// Label de último
  ///
  /// In pt_BR, this message translates to:
  /// **'Último: '**
  String get last;

  /// Label de último backup
  ///
  /// In pt_BR, this message translates to:
  /// **'Último backup: '**
  String get lastBackupLabel;

  /// Contador de arquivos
  ///
  /// In pt_BR, this message translates to:
  /// **'{count, plural, =1{1 arquivo} other{{count} arquivos}}'**
  String fileCount(int count);

  /// Contador de arquivos extraídos
  ///
  /// In pt_BR, this message translates to:
  /// **'{count, plural, =1{1 extraído} other{{count} extraídos}}'**
  String extractedCount(int count);

  /// Aba geral
  ///
  /// In pt_BR, this message translates to:
  /// **'Geral'**
  String get general;

  /// Aba telegram
  ///
  /// In pt_BR, this message translates to:
  /// **'Telegram'**
  String get telegram;

  /// Aba email
  ///
  /// In pt_BR, this message translates to:
  /// **'Email'**
  String get email;

  /// Campo nome do usuário
  ///
  /// In pt_BR, this message translates to:
  /// **'Nome do Usuário'**
  String get userName;

  /// Placeholder nome do usuário
  ///
  /// In pt_BR, this message translates to:
  /// **'Digite seu nome'**
  String get enterYourName;

  /// Campo senha de criptografia
  ///
  /// In pt_BR, this message translates to:
  /// **'Senha de Criptografia'**
  String get encryptionPassword;

  /// Hint da senha de criptografia
  ///
  /// In pt_BR, this message translates to:
  /// **'Usada para proteger seus backups criptografados'**
  String get encryptionPasswordHint;

  /// Placeholder senha
  ///
  /// In pt_BR, this message translates to:
  /// **'Digite a senha'**
  String get enterPassword;

  /// Campo nome do arquivo de backup
  ///
  /// In pt_BR, this message translates to:
  /// **'Nome do Arquivo de Backup'**
  String get backupFileName;

  /// Opção usar nome personalizado
  ///
  /// In pt_BR, this message translates to:
  /// **'Usar nome personalizado'**
  String get useCustomName;

  /// Campo nome personalizado
  ///
  /// In pt_BR, this message translates to:
  /// **'Nome personalizado'**
  String get customName;

  /// Título notificações telegram
  ///
  /// In pt_BR, this message translates to:
  /// **'Notificações via Telegram'**
  String get telegramNotifications;

  /// Descrição notificações telegram
  ///
  /// In pt_BR, this message translates to:
  /// **'Receba alertas sobre seus backups pelo Telegram'**
  String get telegramDescription;

  /// Opção habilitar notificações
  ///
  /// In pt_BR, this message translates to:
  /// **'Habilitar notificações'**
  String get enableNotifications;

  /// Campo bot token
  ///
  /// In pt_BR, this message translates to:
  /// **'Bot Token'**
  String get botToken;

  /// Hint do bot token
  ///
  /// In pt_BR, this message translates to:
  /// **'Crie um bot com @BotFather no Telegram'**
  String get botTokenHint;

  /// Exemplo de bot token
  ///
  /// In pt_BR, this message translates to:
  /// **'123456789:ABCdefGHI...'**
  String get botTokenExample;

  /// Campo chat ID
  ///
  /// In pt_BR, this message translates to:
  /// **'Chat ID'**
  String get chatId;

  /// Hint do chat ID
  ///
  /// In pt_BR, this message translates to:
  /// **'Envie /start ao bot e use @userinfobot para obter'**
  String get chatIdHint;

  /// Exemplo de chat ID
  ///
  /// In pt_BR, this message translates to:
  /// **'Seu Chat ID (ex: 123456789)'**
  String get chatIdExample;

  /// Título quando notificar
  ///
  /// In pt_BR, this message translates to:
  /// **'Quando Notificar'**
  String get whenNotify;

  /// Opção notificar sucesso
  ///
  /// In pt_BR, this message translates to:
  /// **'Backup concluído com sucesso'**
  String get backupSuccess;

  /// Título de notificação para backup com falha
  ///
  /// In pt_BR, this message translates to:
  /// **'Falha no Backup ✗'**
  String get backupFailed;

  /// Opção notificar início
  ///
  /// In pt_BR, this message translates to:
  /// **'Backup iniciado'**
  String get backupStarted;

  /// Status enviando
  ///
  /// In pt_BR, this message translates to:
  /// **'Enviando...'**
  String get sending;

  /// Botão enviar teste
  ///
  /// In pt_BR, this message translates to:
  /// **'Enviar Teste'**
  String get sendTest;

  /// Título notificações email
  ///
  /// In pt_BR, this message translates to:
  /// **'Notificações via Email'**
  String get emailNotifications;

  /// Descrição notificações email
  ///
  /// In pt_BR, this message translates to:
  /// **'Receba alertas sobre seus backups por email'**
  String get emailDescription;

  /// Campo provedor de email
  ///
  /// In pt_BR, this message translates to:
  /// **'Provedor de Email'**
  String get emailProvider;

  /// Hint do provedor de email
  ///
  /// In pt_BR, this message translates to:
  /// **'Selecione seu provedor ou configure manualmente'**
  String get emailProviderHint;

  /// Placeholder selecionar provedor
  ///
  /// In pt_BR, this message translates to:
  /// **'Selecione um provedor'**
  String get selectProvider;

  /// Campo servidor SMTP
  ///
  /// In pt_BR, this message translates to:
  /// **'Servidor SMTP'**
  String get smtpServer;

  /// Exemplo de servidor SMTP
  ///
  /// In pt_BR, this message translates to:
  /// **'Ex: smtp.gmail.com'**
  String get smtpServerExample;

  /// Placeholder servidor SMTP
  ///
  /// In pt_BR, this message translates to:
  /// **'smtp.example.com'**
  String get smtpServerPlaceholder;

  /// Campo porta SMTP
  ///
  /// In pt_BR, this message translates to:
  /// **'Porta SMTP'**
  String get smtpPort;

  /// Hint da porta SMTP
  ///
  /// In pt_BR, this message translates to:
  /// **'587 para TLS, 465 para SSL'**
  String get smtpPortHint;

  /// Placeholder porta SMTP
  ///
  /// In pt_BR, this message translates to:
  /// **'587'**
  String get smtpPortPlaceholder;

  /// Campo seu email
  ///
  /// In pt_BR, this message translates to:
  /// **'Seu Email'**
  String get yourEmail;

  /// Hint do seu email
  ///
  /// In pt_BR, this message translates to:
  /// **'Email que será usado para enviar notificações'**
  String get yourEmailHint;

  /// Placeholder do seu email
  ///
  /// In pt_BR, this message translates to:
  /// **'seuemail@gmail.com'**
  String get yourEmailPlaceholder;

  /// Campo senha do email
  ///
  /// In pt_BR, this message translates to:
  /// **'Senha ou App Password'**
  String get emailPassword;

  /// Hint da senha do email
  ///
  /// In pt_BR, this message translates to:
  /// **'Use App Password se tiver autenticação em 2 etapas'**
  String get emailPasswordHint;

  /// Placeholder da senha do email
  ///
  /// In pt_BR, this message translates to:
  /// **'Sua senha ou App Password'**
  String get emailPasswordPlaceholder;

  /// Campo emails de destino
  ///
  /// In pt_BR, this message translates to:
  /// **'Emails de Destino'**
  String get destinationEmails;

  /// Hint dos emails de destino
  ///
  /// In pt_BR, this message translates to:
  /// **'Separe múltiplos emails por vírgula'**
  String get destinationEmailsHint;

  /// Placeholder dos emails de destino
  ///
  /// In pt_BR, this message translates to:
  /// **'email1@exemplo.com, email2@exemplo.com'**
  String get destinationEmailsPlaceholder;

  /// Título segurança
  ///
  /// In pt_BR, this message translates to:
  /// **'Segurança'**
  String get security;

  /// Opção usar STARTTLS
  ///
  /// In pt_BR, this message translates to:
  /// **'Usar STARTTLS (recomendado)'**
  String get useStartTls;

  /// Opção usar SSL
  ///
  /// In pt_BR, this message translates to:
  /// **'Usar SSL'**
  String get useSsl;

  /// Botão salvar
  ///
  /// In pt_BR, this message translates to:
  /// **'Salvar'**
  String get save;

  /// Mensagem de erro ao enviar teste do telegram
  ///
  /// In pt_BR, this message translates to:
  /// **'Preencha o Bot Token e o Chat ID para enviar teste'**
  String get fillBotTokenAndChatId;

  /// Mensagem de sucesso ao enviar teste
  ///
  /// In pt_BR, this message translates to:
  /// **'Mensagem de teste enviada com sucesso!'**
  String get testMessageSent;

  /// Mensagem de erro genérica
  ///
  /// In pt_BR, this message translates to:
  /// **'Erro: {message}'**
  String errorWithMessage(String message);

  /// Mensagem de erro ao salvar sem preencher campos
  ///
  /// In pt_BR, this message translates to:
  /// **'Preencha todos os campos obrigatórios'**
  String get fillAllFields;

  /// Mensagem de erro ao salvar sem email de destino
  ///
  /// In pt_BR, this message translates to:
  /// **'Insira pelo menos um email de destino'**
  String get enterAtLeastOneEmail;

  /// Mensagem de sucesso ao enviar teste de email
  ///
  /// In pt_BR, this message translates to:
  /// **'Email de teste enviado com sucesso!'**
  String get testEmailSent;

  /// Step dados básicos
  ///
  /// In pt_BR, this message translates to:
  /// **'Dados básicos'**
  String get basicData;

  /// Label agendamento do backup
  ///
  /// In pt_BR, this message translates to:
  /// **'Agendamento'**
  String get scheduling;

  /// Step processamento
  ///
  /// In pt_BR, this message translates to:
  /// **'Processamento'**
  String get processing;

  /// Step revisão
  ///
  /// In pt_BR, this message translates to:
  /// **'Revisão'**
  String get review;

  /// Botão próximo passo
  ///
  /// In pt_BR, this message translates to:
  /// **'Próximo'**
  String get nextStep;

  /// Botão salvar rotina
  ///
  /// In pt_BR, this message translates to:
  /// **'Salvar Rotina'**
  String get saveRoutine;

  /// Botão voltar
  ///
  /// In pt_BR, this message translates to:
  /// **'Voltar'**
  String get back;

  /// Campo nome da rotina
  ///
  /// In pt_BR, this message translates to:
  /// **'Nome da rotina'**
  String get routineName;

  /// Título origens do backup
  ///
  /// In pt_BR, this message translates to:
  /// **'Origens do Backup'**
  String get backupSources;

  /// Descrição de origens
  ///
  /// In pt_BR, this message translates to:
  /// **'Você pode selecionar arquivos e/ou pastas.'**
  String get selectFilesAndFolders;

  /// Exemplo de caminhos de origem
  ///
  /// In pt_BR, this message translates to:
  /// **'/Users/meuuser/Documents;/Users/meuuser/Projetos'**
  String get sourcePathsExample;

  /// Botão adicionar origem
  ///
  /// In pt_BR, this message translates to:
  /// **'Adicionar Origem'**
  String get addSource;

  /// Status selecionando
  ///
  /// In pt_BR, this message translates to:
  /// **'Selecionando...'**
  String get selecting;

  /// Botão selecionar arquivos
  ///
  /// In pt_BR, this message translates to:
  /// **'Selecionar Arquivo(s)'**
  String get selectFiles;

  /// Botão selecionar pasta
  ///
  /// In pt_BR, this message translates to:
  /// **'Selecionar Pasta'**
  String get selectFolder;

  /// Campo destino do backup
  ///
  /// In pt_BR, this message translates to:
  /// **'Destino do Backup'**
  String get backupDestination;

  /// Descrição do destino
  ///
  /// In pt_BR, this message translates to:
  /// **'Escolha a pasta onde os arquivos serão salvos.'**
  String get destinationDescription;

  /// Exemplo de destino
  ///
  /// In pt_BR, this message translates to:
  /// **'/Volumes/Backup/Destino'**
  String get destinationExample;

  /// Botão selecionar pasta de destino
  ///
  /// In pt_BR, this message translates to:
  /// **'Selecionar Pasta de Destino'**
  String get selectDestinationFolder;

  /// Label frequência do agendamento
  ///
  /// In pt_BR, this message translates to:
  /// **'Frequência'**
  String get frequency;

  /// Tipo de agendamento manual
  ///
  /// In pt_BR, this message translates to:
  /// **'Manual'**
  String get manual;

  /// Tipo de agendamento diário
  ///
  /// In pt_BR, this message translates to:
  /// **'Diário'**
  String get daily;

  /// Tipo de agendamento semanal
  ///
  /// In pt_BR, this message translates to:
  /// **'Semanal'**
  String get weekly;

  /// Tipo de agendamento por intervalo
  ///
  /// In pt_BR, this message translates to:
  /// **'Intervalo'**
  String get interval;

  /// Label executar às
  ///
  /// In pt_BR, this message translates to:
  /// **'Executar às:'**
  String get runAt;

  /// Label executar a cada
  ///
  /// In pt_BR, this message translates to:
  /// **'Executar a cada:'**
  String get runEvery;

  /// Informação sobre execução manual
  ///
  /// In pt_BR, this message translates to:
  /// **'O backup será executado manualmente quando você pressionar o botão play no card.'**
  String get manualExecutionInfo;

  /// Intervalo de 1 minuto
  ///
  /// In pt_BR, this message translates to:
  /// **'1 minuto'**
  String get oneMinute;

  /// Intervalo de n minutos
  ///
  /// In pt_BR, this message translates to:
  /// **'{n} minutos'**
  String nMinutes(int n);

  /// Intervalo de 1 hora
  ///
  /// In pt_BR, this message translates to:
  /// **'1 hora'**
  String get oneHour;

  /// Intervalo de n horas
  ///
  /// In pt_BR, this message translates to:
  /// **'{n} horas'**
  String nHours(int n);

  /// Intervalo de 1 dia
  ///
  /// In pt_BR, this message translates to:
  /// **'1 dia'**
  String get oneDay;

  /// Intervalo de n dias
  ///
  /// In pt_BR, this message translates to:
  /// **'{n} dias'**
  String nDays(int n);

  /// Opção compactar backup
  ///
  /// In pt_BR, this message translates to:
  /// **'Compactar backup'**
  String get compressBackup;

  /// Campo formato de compactação
  ///
  /// In pt_BR, this message translates to:
  /// **'Formato de compactação'**
  String get compressionFormat;

  /// Opção criptografar backup
  ///
  /// In pt_BR, this message translates to:
  /// **'Criptografar backup'**
  String get encryptBackup;

  /// Label nome
  ///
  /// In pt_BR, this message translates to:
  /// **'Nome'**
  String get name;

  /// Label origens
  ///
  /// In pt_BR, this message translates to:
  /// **'Origens'**
  String get sources;

  /// Label destino do backup
  ///
  /// In pt_BR, this message translates to:
  /// **'Destino'**
  String get destination;

  /// Label agendamento
  ///
  /// In pt_BR, this message translates to:
  /// **'Agendamento'**
  String get schedule;

  /// Label compactação
  ///
  /// In pt_BR, this message translates to:
  /// **'Compactação'**
  String get compression;

  /// Compactação ativa com formato
  ///
  /// In pt_BR, this message translates to:
  /// **'Ativa ({format})'**
  String activeWithFormat(String format);

  /// Desativada
  ///
  /// In pt_BR, this message translates to:
  /// **'Desativada'**
  String get deactivated;

  /// Label criptografia
  ///
  /// In pt_BR, this message translates to:
  /// **'Criptografia'**
  String get encryption;

  /// Ativa
  ///
  /// In pt_BR, this message translates to:
  /// **'Ativa'**
  String get active;

  /// Título espaço em disco
  ///
  /// In pt_BR, this message translates to:
  /// **'Espaço em Disco'**
  String get diskSpace;

  /// Status calculando tamanhos
  ///
  /// In pt_BR, this message translates to:
  /// **'Calculando tamanhos...'**
  String get calculatingSizes;

  /// Label tamanho da origem
  ///
  /// In pt_BR, this message translates to:
  /// **'Tamanho da origem'**
  String get sourceSize;

  /// Não disponível
  ///
  /// In pt_BR, this message translates to:
  /// **'Não disponível'**
  String get notAvailable;

  /// Label espaço disponível
  ///
  /// In pt_BR, this message translates to:
  /// **'Espaço disponível no destino'**
  String get availableSpace;

  /// Campo retenção
  ///
  /// In pt_BR, this message translates to:
  /// **'Retenção (quantidade de versões)'**
  String get retention;

  /// Mensagem de espaço suficiente
  ///
  /// In pt_BR, this message translates to:
  /// **'Espaço suficiente! Margem de {percent}% disponível.'**
  String sufficientSpace(String percent);

  /// Mensagem de espaço insuficiente
  ///
  /// In pt_BR, this message translates to:
  /// **'Espaço insuficiente! Faltam {size} no disco de destino.'**
  String insufficientSpace(String size);

  /// Mensagem de seleção cancelada
  ///
  /// In pt_BR, this message translates to:
  /// **'Seleção de arquivos cancelada.'**
  String get fileSelectionCancelled;

  /// Mensagem de arquivos adicionados
  ///
  /// In pt_BR, this message translates to:
  /// **'{count, plural, =1{1 arquivo adicionado à origem.} other{{count} arquivos adicionados à origem.}}'**
  String filesAdded(int count);

  /// Erro ao selecionar arquivos
  ///
  /// In pt_BR, this message translates to:
  /// **'Falha ao selecionar arquivos: {error}'**
  String failedToSelectFiles(String error);

  /// Mensagem de seleção cancelada
  ///
  /// In pt_BR, this message translates to:
  /// **'Seleção de pasta de origem cancelada.'**
  String get folderSelectionCancelled;

  /// Mensagem de pasta selecionada
  ///
  /// In pt_BR, this message translates to:
  /// **'Pasta de origem selecionada.'**
  String get sourceFolderSelected;

  /// Erro ao selecionar pasta de origem
  ///
  /// In pt_BR, this message translates to:
  /// **'Falha ao selecionar pasta de origem: {error}'**
  String failedToSelectSourceFolder(String error);

  /// Informação sobre local de salvamento no iOS
  ///
  /// In pt_BR, this message translates to:
  /// **'No iOS, os backups serão salvos em: Documentos/Backups'**
  String get iosSaveLocation;

  /// Mensagem de seleção cancelada
  ///
  /// In pt_BR, this message translates to:
  /// **'Seleção de pasta de destino cancelada.'**
  String get destinationSelectionCancelled;

  /// Mensagem de pasta selecionada
  ///
  /// In pt_BR, this message translates to:
  /// **'Pasta de destino selecionada.'**
  String get destinationFolderSelected;

  /// Erro ao selecionar pasta de destino
  ///
  /// In pt_BR, this message translates to:
  /// **'Falha ao selecionar pasta de destino: {error}'**
  String failedToSelectDestination(String error);

  /// Erro ao validar nome da rotina
  ///
  /// In pt_BR, this message translates to:
  /// **'Informe o nome da rotina.'**
  String get enterRoutineName;

  /// Erro ao validar origens
  ///
  /// In pt_BR, this message translates to:
  /// **'Informe ao menos uma origem.'**
  String get enterAtLeastOneSource;

  /// Erro ao validar destino
  ///
  /// In pt_BR, this message translates to:
  /// **'Informe o caminho de destino.'**
  String get enterDestinationPath;

  /// Erro ao validar retenção
  ///
  /// In pt_BR, this message translates to:
  /// **'Retenção deve ser um número maior que zero.'**
  String get retentionMustBePositive;

  /// Erro ao habilitar criptografia sem senha configurada
  ///
  /// In pt_BR, this message translates to:
  /// **'Configure uma senha de criptografia nas Configurações antes de habilitar a criptografia.'**
  String get configureEncryptionPassword;

  /// Título do diálogo de descriptografia
  ///
  /// In pt_BR, this message translates to:
  /// **'Descriptografar Arquivo'**
  String get decryptFile;

  /// Descrição do diálogo de descriptografia
  ///
  /// In pt_BR, this message translates to:
  /// **'Descriptografe arquivos protegidos pelo ShadowSync'**
  String get decryptionDescription;

  /// Label arquivo criptografado
  ///
  /// In pt_BR, this message translates to:
  /// **'Arquivo Criptografado'**
  String get encryptedFile;

  /// Placeholder selecionar arquivo
  ///
  /// In pt_BR, this message translates to:
  /// **'Selecionar arquivo...'**
  String get selectFileEllipsis;

  /// Label pasta de destino
  ///
  /// In pt_BR, this message translates to:
  /// **'Pasta de Destino'**
  String get destinationFolder;

  /// Placeholder selecionar pasta
  ///
  /// In pt_BR, this message translates to:
  /// **'Selecionar pasta...'**
  String get selectFolderEllipsis;

  /// Label nome do arquivo de saída
  ///
  /// In pt_BR, this message translates to:
  /// **'Nome do arquivo de saída:'**
  String get outputFileName;

  /// Label senha de descriptografia
  ///
  /// In pt_BR, this message translates to:
  /// **'Senha de descriptografia:'**
  String get decryptionPassword;

  /// Hint da senha de descriptografia
  ///
  /// In pt_BR, this message translates to:
  /// **'Digite a senha usada na criptografia'**
  String get enterEncryptionPassword;

  /// Tooltip selecionar arquivo criptografado
  ///
  /// In pt_BR, this message translates to:
  /// **'Selecionar arquivo criptografado'**
  String get selectEncryptedFile;

  /// Tooltip selecionar pasta de destino
  ///
  /// In pt_BR, this message translates to:
  /// **'Selecionar pasta de destino'**
  String get selectDestinationFolderTooltip;

  /// Botão executar
  ///
  /// In pt_BR, this message translates to:
  /// **'Executar'**
  String get execute;

  /// Status descriptografando
  ///
  /// In pt_BR, this message translates to:
  /// **'Descriptografando...'**
  String get decrypting;

  /// Botão fechar
  ///
  /// In pt_BR, this message translates to:
  /// **'Fechar'**
  String get close;

  /// Botão descriptografar outro
  ///
  /// In pt_BR, this message translates to:
  /// **'Descriptografar Outro'**
  String get decryptAnother;

  /// Status iniciando descriptografia
  ///
  /// In pt_BR, this message translates to:
  /// **'Iniciando descriptografia...'**
  String get startingDecryption;

  /// Status preparando descriptografia
  ///
  /// In pt_BR, this message translates to:
  /// **'Preparando descriptografia...'**
  String get preparingDecryption;

  /// Status descriptografando arquivo
  ///
  /// In pt_BR, this message translates to:
  /// **'Descriptografando arquivo...'**
  String get decryptingFile;

  /// Status extraindo conteúdo
  ///
  /// In pt_BR, this message translates to:
  /// **'Extraindo conteúdo...'**
  String get extractingContent;

  /// Status finalizando
  ///
  /// In pt_BR, this message translates to:
  /// **'Finalizando...'**
  String get finalizing;

  /// Mensagem de sucesso ao descriptografar
  ///
  /// In pt_BR, this message translates to:
  /// **'Descriptografado com sucesso! {count, plural, =1{1 arquivo extraído.} other{{count} arquivos extraídos.}}'**
  String decryptedSuccessfully(int count);

  /// Erro ao selecionar arquivo
  ///
  /// In pt_BR, this message translates to:
  /// **'Erro ao selecionar arquivo: {error}'**
  String errorSelectingFile(String error);

  /// Erro ao selecionar destino
  ///
  /// In pt_BR, this message translates to:
  /// **'Erro ao selecionar destino: {error}'**
  String errorSelectingDestination(String error);

  /// Título do diálogo de verificação de disco
  ///
  /// In pt_BR, this message translates to:
  /// **'Verificar Disco'**
  String get verifyDiskTitle;

  /// Descrição do diálogo de verificação
  ///
  /// In pt_BR, this message translates to:
  /// **'Selecione um disco para verificar sua integridade'**
  String get selectDiskToVerify;

  /// Título verificando disco
  ///
  /// In pt_BR, this message translates to:
  /// **'Verificando: {diskName}'**
  String verifying(String diskName);

  /// Tooltip voltar à seleção
  ///
  /// In pt_BR, this message translates to:
  /// **'Voltar à seleção'**
  String get backToSelection;

  /// Status carregando discos
  ///
  /// In pt_BR, this message translates to:
  /// **'Carregando discos...'**
  String get loadingDisks;

  /// Erro ao carregar discos
  ///
  /// In pt_BR, this message translates to:
  /// **'Erro ao carregar discos: {error}'**
  String errorLoadingDisks(String error);

  /// Botão tentar novamente
  ///
  /// In pt_BR, this message translates to:
  /// **'Tentar novamente'**
  String get tryAgain;

  /// Mensagem quando não há discos
  ///
  /// In pt_BR, this message translates to:
  /// **'Nenhum disco encontrado'**
  String get noDisksFound;

  /// Espaço livre do disco
  ///
  /// In pt_BR, this message translates to:
  /// **'{size} livres'**
  String freeSpace(String size);

  /// Mensagem quando informações de espaço em disco não estão disponíveis
  ///
  /// In pt_BR, this message translates to:
  /// **'Informações de espaço indisponíveis'**
  String get diskSpaceUnavailable;

  /// Nome do armazenamento interno do dispositivo
  ///
  /// In pt_BR, this message translates to:
  /// **'Armazenamento Interno'**
  String get internalStorage;

  /// Nome do cartão SD
  ///
  /// In pt_BR, this message translates to:
  /// **'Cartão SD'**
  String get sdCard;

  /// Nome do cartão SD externo
  ///
  /// In pt_BR, this message translates to:
  /// **'Cartão SD Externo'**
  String get externalSdCard;

  /// Nome do armazenamento principal
  ///
  /// In pt_BR, this message translates to:
  /// **'Armazenamento Principal'**
  String get primaryStorage;

  /// Nome do armazenamento externo
  ///
  /// In pt_BR, this message translates to:
  /// **'Armazenamento Externo'**
  String get externalStorage;

  /// Nome do armazenamento do dispositivo
  ///
  /// In pt_BR, this message translates to:
  /// **'Armazenamento do Dispositivo'**
  String get deviceStorage;

  /// Nome do armazenamento do app
  ///
  /// In pt_BR, this message translates to:
  /// **'Armazenamento do App'**
  String get appStorage;

  /// Título testes a executar
  ///
  /// In pt_BR, this message translates to:
  /// **'Testes que serão executados:'**
  String get testsToRun;

  /// Título resultados dos testes
  ///
  /// In pt_BR, this message translates to:
  /// **'Resultados dos Testes'**
  String get testResults;

  /// Status verificação em andamento
  ///
  /// In pt_BR, this message translates to:
  /// **'Verificação em andamento...'**
  String get verificationInProgress;

  /// Status disco verificado sem problemas
  ///
  /// In pt_BR, this message translates to:
  /// **'Disco verificado - Nenhum problema encontrado'**
  String get diskVerifiedNoProblems;

  /// Status verificação com avisos
  ///
  /// In pt_BR, this message translates to:
  /// **'Verificação concluída com avisos'**
  String get verificationCompletedWithWarnings;

  /// Status problemas detectados
  ///
  /// In pt_BR, this message translates to:
  /// **'Problemas detectados no disco'**
  String get problemsDetected;

  /// Status aguardando
  ///
  /// In pt_BR, this message translates to:
  /// **'Aguardando...'**
  String get waiting;

  /// Tempo total da verificação
  ///
  /// In pt_BR, this message translates to:
  /// **'Tempo total: {duration}'**
  String totalTime(String duration);

  /// Label ponto de montagem
  ///
  /// In pt_BR, this message translates to:
  /// **'Ponto de montagem'**
  String get mountPoint;

  /// Label dispositivo
  ///
  /// In pt_BR, this message translates to:
  /// **'Dispositivo'**
  String get device;

  /// Label sistema de arquivos
  ///
  /// In pt_BR, this message translates to:
  /// **'Sistema de arquivos'**
  String get fileSystem;

  /// Label capacidade total
  ///
  /// In pt_BR, this message translates to:
  /// **'Capacidade total'**
  String get totalCapacity;

  /// Label espaço disponível
  ///
  /// In pt_BR, this message translates to:
  /// **'Espaço disponível'**
  String get availableSpaceLabel;

  /// Label tipo de mídia
  ///
  /// In pt_BR, this message translates to:
  /// **'Tipo de mídia'**
  String get mediaType;

  /// Label para tipo
  ///
  /// In pt_BR, this message translates to:
  /// **'Tipo'**
  String get type;

  /// Tipo removível
  ///
  /// In pt_BR, this message translates to:
  /// **'Removível'**
  String get removable;

  /// Tipo interno
  ///
  /// In pt_BR, this message translates to:
  /// **'Interno'**
  String get internal;

  /// Botão iniciar verificação
  ///
  /// In pt_BR, this message translates to:
  /// **'Iniciar Verificação'**
  String get startVerification;

  /// Botão verificar novamente
  ///
  /// In pt_BR, this message translates to:
  /// **'Verificar Novamente'**
  String get verifyAgain;

  /// Nome do teste de acessibilidade de disco
  ///
  /// In pt_BR, this message translates to:
  /// **'Verificação de Acessibilidade'**
  String get testAccessibilityCheck;

  /// Nome do teste de análise de espaço em disco
  ///
  /// In pt_BR, this message translates to:
  /// **'Análise de Espaço em Disco'**
  String get testSpaceAnalysis;

  /// Nome do teste de leitura de disco
  ///
  /// In pt_BR, this message translates to:
  /// **'Teste de Leitura'**
  String get testReadTest;

  /// Nome do teste de verificação do sistema de arquivos
  ///
  /// In pt_BR, this message translates to:
  /// **'Verificação do Sistema de Arquivos'**
  String get testFileSystemCheck;

  /// Nome do teste de status S.M.A.R.T.
  ///
  /// In pt_BR, this message translates to:
  /// **'Status S.M.A.R.T.'**
  String get testSmartStatus;

  /// Seleção de idioma
  ///
  /// In pt_BR, this message translates to:
  /// **'Idioma'**
  String get language;

  /// Nome do idioma Português
  ///
  /// In pt_BR, this message translates to:
  /// **'Português (Brasil)'**
  String get languagePortuguese;

  /// Nome do idioma Inglês
  ///
  /// In pt_BR, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// Nome do idioma Francês
  ///
  /// In pt_BR, this message translates to:
  /// **'Français'**
  String get languageFrench;

  /// Nome do idioma Alemão
  ///
  /// In pt_BR, this message translates to:
  /// **'Deutsch'**
  String get languageGerman;

  /// Nome do idioma Espanhol
  ///
  /// In pt_BR, this message translates to:
  /// **'Español'**
  String get languageSpanish;

  /// Nome do idioma Italiano
  ///
  /// In pt_BR, this message translates to:
  /// **'Italiano'**
  String get languageItalian;

  /// Nome do idioma Japonês
  ///
  /// In pt_BR, this message translates to:
  /// **'日本語'**
  String get languageJapanese;

  /// Nome do idioma Chinês Simplificado
  ///
  /// In pt_BR, this message translates to:
  /// **'中文 (简体)'**
  String get languageChinese;

  /// Nome do idioma Coreano
  ///
  /// In pt_BR, this message translates to:
  /// **'한국어'**
  String get languageKorean;

  /// Tipo de agendamento: Manual
  ///
  /// In pt_BR, this message translates to:
  /// **'Manual'**
  String get scheduleTypeManual;

  /// Tipo de agendamento: Diário
  ///
  /// In pt_BR, this message translates to:
  /// **'Diário'**
  String get scheduleTypeDaily;

  /// Tipo de agendamento: Semanal
  ///
  /// In pt_BR, this message translates to:
  /// **'Semanal'**
  String get scheduleTypeWeekly;

  /// Tipo de agendamento: Intervalo
  ///
  /// In pt_BR, this message translates to:
  /// **'Intervalo'**
  String get scheduleTypeInterval;

  /// Label nome do backup
  ///
  /// In pt_BR, this message translates to:
  /// **'Nome'**
  String get backupName;

  /// Label origine(s) do backup
  ///
  /// In pt_BR, this message translates to:
  /// **'Origens'**
  String get backupSource;

  /// Label compactação do backup
  ///
  /// In pt_BR, this message translates to:
  /// **'Compactação'**
  String get backupCompression;

  /// Label criptografia do backup
  ///
  /// In pt_BR, this message translates to:
  /// **'Criptografia'**
  String get backupEncryption;

  /// Status de criptografia ativa
  ///
  /// In pt_BR, this message translates to:
  /// **'Ativa'**
  String get encryptionActive;

  /// Mensagem quando nenhuma rotina foi configurada
  ///
  /// In pt_BR, this message translates to:
  /// **'Nenhuma rotina configurada'**
  String get noRoutinesConfigured;

  /// Formato do próximo backup agendado
  ///
  /// In pt_BR, this message translates to:
  /// **'Próximo: \"{routineName}\" {time}'**
  String nextBackupFormat(String routineName, String time);

  /// Mensagem quando há espaço disponível
  ///
  /// In pt_BR, this message translates to:
  /// **'Espaço suficiente! Margem de {margin}% disponível.'**
  String diskSpaceSufficient(String margin);

  /// Mensagem quando não há espaço disponível
  ///
  /// In pt_BR, this message translates to:
  /// **'Espaço insuficiente! Faltam {deficit} no disco de destino.'**
  String diskSpaceInsufficient(String deficit);

  /// Rótulo para data de hoje
  ///
  /// In pt_BR, this message translates to:
  /// **'hoje'**
  String get dateToday;

  /// Rótulo para data de amanhã
  ///
  /// In pt_BR, this message translates to:
  /// **'amanhã'**
  String get dateTomorrow;

  /// Abreviação de segunda-feira
  ///
  /// In pt_BR, this message translates to:
  /// **'seg'**
  String get weekdayMonday;

  /// Abreviação de terça-feira
  ///
  /// In pt_BR, this message translates to:
  /// **'ter'**
  String get weekdayTuesday;

  /// Abreviação de quarta-feira
  ///
  /// In pt_BR, this message translates to:
  /// **'qua'**
  String get weekdayWednesday;

  /// Abreviação de quinta-feira
  ///
  /// In pt_BR, this message translates to:
  /// **'qui'**
  String get weekdayThursday;

  /// Abreviação de sexta-feira
  ///
  /// In pt_BR, this message translates to:
  /// **'sex'**
  String get weekdayFriday;

  /// Abreviação de sábado
  ///
  /// In pt_BR, this message translates to:
  /// **'sáb'**
  String get weekdaySaturday;

  /// Abreviação de domingo
  ///
  /// In pt_BR, this message translates to:
  /// **'dom'**
  String get weekdaySunday;

  /// Opção de menu Sobre
  ///
  /// In pt_BR, this message translates to:
  /// **'Sobre'**
  String get about;

  /// Título do diálogo de Sobre
  ///
  /// In pt_BR, this message translates to:
  /// **'Sobre o ShadowSync'**
  String get aboutTitle;

  /// Rótulo de versão do app
  ///
  /// In pt_BR, this message translates to:
  /// **'Versão'**
  String get version;

  /// Rótulo de desenvolvedor
  ///
  /// In pt_BR, this message translates to:
  /// **'Desenvolvedor'**
  String get developer;

  /// Botão para visitar o site
  ///
  /// In pt_BR, this message translates to:
  /// **'Visitar Site'**
  String get visitWebsite;

  /// Título de notificação para backup bem-sucedido
  ///
  /// In pt_BR, this message translates to:
  /// **'Backup Concluído ✓'**
  String get backupCompleted;

  /// Mensagem de notificação para backup bem-sucedido
  ///
  /// In pt_BR, this message translates to:
  /// **'O backup \"{routineName}\" foi concluído com sucesso.'**
  String backupCompletedMessage(String routineName);

  /// Mensagem de notificação para backup com falha
  ///
  /// In pt_BR, this message translates to:
  /// **'O backup \"{routineName}\" falhou: {errorMessage}'**
  String backupFailedMessage(String routineName, String errorMessage);

  /// Título de notificação para próximo backup
  ///
  /// In pt_BR, this message translates to:
  /// **'Próximo Backup Agendado'**
  String get nextBackupScheduled;

  /// Mensagem de notificação para próximo backup
  ///
  /// In pt_BR, this message translates to:
  /// **'\"{routineName}\" será executado {timeDescription}.'**
  String nextBackupMessage(String routineName, String timeDescription);

  /// Descrição de tempo para menos de 1 minuto
  ///
  /// In pt_BR, this message translates to:
  /// **'em menos de 1 minuto'**
  String get inLessThanMinute;

  /// Descrição de tempo para 1 minuto
  ///
  /// In pt_BR, this message translates to:
  /// **'em 1 minuto'**
  String get inMinute;

  /// Descrição de tempo para múltiplos minutos
  ///
  /// In pt_BR, this message translates to:
  /// **'em {count} minutos'**
  String inMinutes(int count);

  /// Descrição de tempo para 1 hora
  ///
  /// In pt_BR, this message translates to:
  /// **'em 1 hora'**
  String get inHour;

  /// Descrição de tempo para múltiplas horas
  ///
  /// In pt_BR, this message translates to:
  /// **'em {count} horas'**
  String inHours(int count);

  /// Descrição de tempo para horas e minutos
  ///
  /// In pt_BR, this message translates to:
  /// **'em {hours}h{minutes}min'**
  String inHoursMinutes(int hours, int minutes);

  /// Descrição de tempo para 1 dia
  ///
  /// In pt_BR, this message translates to:
  /// **'em 1 dia'**
  String get inDay;

  /// Descrição de tempo para múltiplos dias
  ///
  /// In pt_BR, this message translates to:
  /// **'em {count} dias'**
  String inDays(int count);

  /// Nome do canal de notificação Android
  ///
  /// In pt_BR, this message translates to:
  /// **'Backups do ShadowSync'**
  String get notificationChannelName;

  /// Descrição do canal de notificação Android
  ///
  /// In pt_BR, this message translates to:
  /// **'Notificações sobre status de backups e agendamentos'**
  String get notificationChannelDescription;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'pt':
      {
        switch (locale.countryCode) {
          case 'BR':
            return AppLocalizationsPtBr();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
