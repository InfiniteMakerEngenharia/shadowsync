// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'ShadowSync';

  @override
  String get appSubtitle => 'Gestore di Backup';

  @override
  String get myRoutines => 'Le mie Routine';

  @override
  String get verifyDisk => 'Verifica Disco';

  @override
  String get decrypt => 'Decrittografa';

  @override
  String get settings => 'Impostazioni';

  @override
  String startingBackup(String routineName) {
    return 'Avvio backup \"$routineName\"...';
  }

  @override
  String get deleteRoutine => 'Elimina routine';

  @override
  String deleteRoutineConfirm(String routineName) {
    return 'Vuoi davvero eliminare la routine \"$routineName\"? Questa azione non può essere annullata.';
  }

  @override
  String get cancel => 'Annulla';

  @override
  String get delete => 'Elimina';

  @override
  String get noRoutines => 'Nessuna routine configurata';

  @override
  String get noScheduledBackups => 'Nessun backup pianificato';

  @override
  String get serviceActive => 'Servizio attivo';

  @override
  String nextBackup(String name, String time) {
    return 'Prossimo: \"$name\" $time';
  }

  @override
  String get today => 'oggi';

  @override
  String get tomorrow => 'domani';

  @override
  String get monday => 'lun';

  @override
  String get tuesday => 'mar';

  @override
  String get wednesday => 'mer';

  @override
  String get thursday => 'gio';

  @override
  String get friday => 'ven';

  @override
  String get saturday => 'sab';

  @override
  String get sunday => 'dom';

  @override
  String get newBackup => 'Nuovo Backup';

  @override
  String get runBackup => 'Esegui backup';

  @override
  String get deleteRoutineTooltip => 'Elimina routine';

  @override
  String get manualExecution => 'Esecuzione manuale';

  @override
  String get noScheduleAvailable => 'Non programmato';

  @override
  String scheduledDaily(String time) {
    return 'Programmato: Giornalmente alle $time';
  }

  @override
  String scheduledWeekly(String date) {
    return 'Programmato: Settimanalmente • $date';
  }

  @override
  String scheduledInterval(String interval) {
    return 'Programmato: Ogni $interval';
  }

  @override
  String get mode => 'Modalità: ';

  @override
  String get next => 'Prossimo: ';

  @override
  String get last => 'Ultimo: ';

  @override
  String get lastBackupLabel => 'Ultimo backup: ';

  @override
  String fileCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count file',
      one: '1 file',
    );
    return '$_temp0';
  }

  @override
  String extractedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count estratti',
      one: '1 estratto',
    );
    return '$_temp0';
  }

  @override
  String get general => 'Generale';

  @override
  String get telegram => 'Telegram';

  @override
  String get email => 'Email';

  @override
  String get userName => 'Nome Utente';

  @override
  String get enterYourName => 'Inserisci il tuo nome';

  @override
  String get encryptionPassword => 'Password di Crittografia';

  @override
  String get encryptionPasswordHint =>
      'Usata per proteggere i tuoi backup crittografati';

  @override
  String get enterPassword => 'Inserisci la password';

  @override
  String get backupFileName => 'Nome del File di Backup';

  @override
  String get useCustomName => 'Usa nome personalizzato';

  @override
  String get customName => 'Nome personalizzato';

  @override
  String get telegramNotifications => 'Notifiche via Telegram';

  @override
  String get telegramDescription =>
      'Ricevi avvisi sui tuoi backup tramite Telegram';

  @override
  String get enableNotifications => 'Abilita notifiche';

  @override
  String get botToken => 'Bot Token';

  @override
  String get botTokenHint => 'Crea un bot con @BotFather su Telegram';

  @override
  String get botTokenExample => '123456789:ABCdefGHI...';

  @override
  String get chatId => 'Chat ID';

  @override
  String get chatIdHint =>
      'Invia /start al bot e usa @userinfobot per ottenerlo';

  @override
  String get chatIdExample => 'Il tuo Chat ID (es: 123456789)';

  @override
  String get whenNotify => 'Quando Notificare';

  @override
  String get backupSuccess => 'Backup completato con successo';

  @override
  String get backupFailed => 'Backup fallito';

  @override
  String get backupStarted => 'Backup avviato';

  @override
  String get sending => 'Invio in corso...';

  @override
  String get sendTest => 'Invia Test';

  @override
  String get emailNotifications => 'Notifiche via Email';

  @override
  String get emailDescription => 'Ricevi avvisi sui tuoi backup per email';

  @override
  String get emailProvider => 'Provider Email';

  @override
  String get emailProviderHint =>
      'Seleziona il tuo provider o configura manualmente';

  @override
  String get selectProvider => 'Seleziona un provider';

  @override
  String get smtpServer => 'Server SMTP';

  @override
  String get smtpServerExample => 'Es: smtp.gmail.com';

  @override
  String get smtpServerPlaceholder => 'smtp.example.com';

  @override
  String get smtpPort => 'Porta SMTP';

  @override
  String get smtpPortHint => '587 per TLS, 465 per SSL';

  @override
  String get smtpPortPlaceholder => '587';

  @override
  String get yourEmail => 'La tua Email';

  @override
  String get yourEmailHint => 'Email che verrà usata per inviare le notifiche';

  @override
  String get yourEmailPlaceholder => 'tuaemail@gmail.com';

  @override
  String get emailPassword => 'Password o App Password';

  @override
  String get emailPasswordHint =>
      'Usa App Password se hai l\'autenticazione a 2 fattori';

  @override
  String get emailPasswordPlaceholder => 'La tua password o App Password';

  @override
  String get destinationEmails => 'Email di Destinazione';

  @override
  String get destinationEmailsHint => 'Separa più email con una virgola';

  @override
  String get destinationEmailsPlaceholder =>
      'email1@esempio.com, email2@esempio.com';

  @override
  String get security => 'Sicurezza';

  @override
  String get useStartTls => 'Usa STARTTLS (consigliato)';

  @override
  String get useSsl => 'Usa SSL';

  @override
  String get save => 'Salva';

  @override
  String get fillBotTokenAndChatId =>
      'Compila Bot Token e Chat ID per inviare un test';

  @override
  String get testMessageSent => 'Messaggio di test inviato con successo!';

  @override
  String errorWithMessage(String message) {
    return 'Errore: $message';
  }

  @override
  String get fillAllFields => 'Compila tutti i campi obbligatori';

  @override
  String get enterAtLeastOneEmail =>
      'Inserisci almeno un\'email di destinazione';

  @override
  String get testEmailSent => 'Email di test inviata con successo!';

  @override
  String get basicData => 'Dati di base';

  @override
  String get scheduling => 'Programmazione';

  @override
  String get processing => 'Elaborazione';

  @override
  String get review => 'Revisione';

  @override
  String get nextStep => 'Avanti';

  @override
  String get saveRoutine => 'Salva Routine';

  @override
  String get back => 'Indietro';

  @override
  String get routineName => 'Nome della routine';

  @override
  String get backupSources => 'Origini del Backup';

  @override
  String get selectFilesAndFolders => 'Puoi selezionare file e/o cartelle.';

  @override
  String get sourcePathsExample =>
      '/Users/mioutente/Documents;/Users/mioutente/Progetti';

  @override
  String get addSource => 'Aggiungi Origine';

  @override
  String get selecting => 'Selezione in corso...';

  @override
  String get selectFiles => 'Seleziona File';

  @override
  String get selectFolder => 'Seleziona Cartella';

  @override
  String get backupDestination => 'Destinazione del Backup';

  @override
  String get destinationDescription =>
      'Scegli la cartella dove verranno salvati i file.';

  @override
  String get destinationExample => '/Volumes/Backup/Destinazione';

  @override
  String get selectDestinationFolder => 'Seleziona Cartella di Destinazione';

  @override
  String get frequency => 'Frequenza';

  @override
  String get manual => 'Manuale';

  @override
  String get daily => 'Giornaliero';

  @override
  String get weekly => 'Settimanale';

  @override
  String get interval => 'Intervallo';

  @override
  String get runAt => 'Esegui alle:';

  @override
  String get runEvery => 'Esegui ogni:';

  @override
  String get manualExecutionInfo =>
      'Il backup verrà eseguito manualmente quando premi il pulsante play sulla scheda.';

  @override
  String get oneMinute => '1 minuto';

  @override
  String nMinutes(int n) {
    return '$n minuti';
  }

  @override
  String get oneHour => '1 ora';

  @override
  String nHours(int n) {
    return '$n ore';
  }

  @override
  String get oneDay => '1 giorno';

  @override
  String nDays(int n) {
    return '$n giorni';
  }

  @override
  String get compressBackup => 'Comprimi backup';

  @override
  String get compressionFormat => 'Formato di compressione';

  @override
  String get encryptBackup => 'Crittografa backup';

  @override
  String get name => 'Nome';

  @override
  String get sources => 'Origini';

  @override
  String get destination => 'Destinazione';

  @override
  String get schedule => 'Programmazione';

  @override
  String get compression => 'Compressione';

  @override
  String activeWithFormat(String format) {
    return 'Attiva ($format)';
  }

  @override
  String get deactivated => 'Disattivata';

  @override
  String get encryption => 'Crittografia';

  @override
  String get active => 'Attiva';

  @override
  String get diskSpace => 'Spazio su Disco';

  @override
  String get calculatingSizes => 'Calcolo dimensioni in corso...';

  @override
  String get sourceSize => 'Dimensione dell\'origine';

  @override
  String get notAvailable => 'Non disponibile';

  @override
  String get availableSpace => 'Spazio disponibile nella destinazione';

  @override
  String get retention => 'Ritenzione (quantità di versioni)';

  @override
  String sufficientSpace(String percent) {
    return 'Spazio sufficiente! Margine del $percent% disponibile.';
  }

  @override
  String insufficientSpace(String size) {
    return 'Spazio insufficiente! Mancano $size sul disco di destinazione.';
  }

  @override
  String get fileSelectionCancelled => 'Selezione file annullata.';

  @override
  String filesAdded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count file aggiunti all\'origine.',
      one: '1 file aggiunto all\'origine.',
    );
    return '$_temp0';
  }

  @override
  String failedToSelectFiles(String error) {
    return 'Errore nella selezione dei file: $error';
  }

  @override
  String get folderSelectionCancelled =>
      'Selezione cartella di origine annullata.';

  @override
  String get sourceFolderSelected => 'Cartella di origine selezionata.';

  @override
  String failedToSelectSourceFolder(String error) {
    return 'Errore nella selezione della cartella di origine: $error';
  }

  @override
  String get iosSaveLocation =>
      'Su iOS, i backup verranno salvati in: Documenti/Backups';

  @override
  String get destinationSelectionCancelled =>
      'Selezione cartella di destinazione annullata.';

  @override
  String get destinationFolderSelected =>
      'Cartella di destinazione selezionata.';

  @override
  String failedToSelectDestination(String error) {
    return 'Errore nella selezione della cartella di destinazione: $error';
  }

  @override
  String get enterRoutineName => 'Inserisci il nome della routine.';

  @override
  String get enterAtLeastOneSource => 'Inserisci almeno un\'origine.';

  @override
  String get enterDestinationPath => 'Inserisci il percorso di destinazione.';

  @override
  String get retentionMustBePositive =>
      'La ritenzione deve essere un numero maggiore di zero.';

  @override
  String get configureEncryptionPassword =>
      'Configura una password di crittografia nelle Impostazioni prima di abilitare la crittografia.';

  @override
  String get decryptFile => 'Decrittografa File';

  @override
  String get decryptionDescription =>
      'Decrittografa file protetti da ShadowSync';

  @override
  String get encryptedFile => 'File Crittografato';

  @override
  String get selectFileEllipsis => 'Seleziona file...';

  @override
  String get destinationFolder => 'Cartella di Destinazione';

  @override
  String get selectFolderEllipsis => 'Seleziona cartella...';

  @override
  String get outputFileName => 'Nome del file di output:';

  @override
  String get decryptionPassword => 'Password di decrittografia:';

  @override
  String get enterEncryptionPassword =>
      'Inserisci la password usata nella crittografia';

  @override
  String get selectEncryptedFile => 'Seleziona file crittografato';

  @override
  String get selectDestinationFolderTooltip =>
      'Seleziona cartella di destinazione';

  @override
  String get execute => 'Esegui';

  @override
  String get decrypting => 'Decrittografia in corso...';

  @override
  String get close => 'Chiudi';

  @override
  String get decryptAnother => 'Decrittografa Altro';

  @override
  String get startingDecryption => 'Avvio decrittografia...';

  @override
  String get preparingDecryption => 'Preparazione decrittografia...';

  @override
  String get decryptingFile => 'Decrittografia file in corso...';

  @override
  String get extractingContent => 'Estrazione contenuto in corso...';

  @override
  String get finalizing => 'Finalizzazione in corso...';

  @override
  String decryptedSuccessfully(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count file estratti.',
      one: '1 file estratto.',
    );
    return 'Decrittografato con successo! $_temp0';
  }

  @override
  String errorSelectingFile(String error) {
    return 'Errore nella selezione del file: $error';
  }

  @override
  String errorSelectingDestination(String error) {
    return 'Errore nella selezione della destinazione: $error';
  }

  @override
  String get verifyDiskTitle => 'Verifica Disco';

  @override
  String get selectDiskToVerify =>
      'Seleziona un disco per verificarne l\'integrità';

  @override
  String verifying(String diskName) {
    return 'Verifica in corso: $diskName';
  }

  @override
  String get backToSelection => 'Torna alla selezione';

  @override
  String get loadingDisks => 'Caricamento dischi in corso...';

  @override
  String errorLoadingDisks(String error) {
    return 'Errore nel caricamento dei dischi: $error';
  }

  @override
  String get tryAgain => 'Riprova';

  @override
  String get noDisksFound => 'Nessun disco trovato';

  @override
  String freeSpace(String size) {
    return '$size liberi';
  }

  @override
  String get diskSpaceUnavailable => 'Informazioni spazio non disponibili';

  @override
  String get internalStorage => 'Archiviazione Interna';

  @override
  String get sdCard => 'Scheda SD';

  @override
  String get externalSdCard => 'Scheda SD Esterna';

  @override
  String get primaryStorage => 'Archiviazione Principale';

  @override
  String get externalStorage => 'Archiviazione Esterna';

  @override
  String get deviceStorage => 'Archiviazione del Dispositivo';

  @override
  String get appStorage => 'Archiviazione dell\'App';

  @override
  String get testsToRun => 'Test da eseguire:';

  @override
  String get testResults => 'Risultati dei Test';

  @override
  String get verificationInProgress => 'Verifica in corso...';

  @override
  String get diskVerifiedNoProblems =>
      'Disco verificato - Nessun problema riscontrato';

  @override
  String get verificationCompletedWithWarnings =>
      'Verifica completata con avvisi';

  @override
  String get problemsDetected => 'Problemi rilevati sul disco';

  @override
  String get waiting => 'In attesa...';

  @override
  String totalTime(String duration) {
    return 'Tempo totale: $duration';
  }

  @override
  String get mountPoint => 'Punto di montaggio';

  @override
  String get device => 'Dispositivo';

  @override
  String get fileSystem => 'File system';

  @override
  String get totalCapacity => 'Capacità totale';

  @override
  String get availableSpaceLabel => 'Spazio disponibile';

  @override
  String get mediaType => 'Tipo di supporto';

  @override
  String get type => 'Tipo';

  @override
  String get removable => 'Rimovibile';

  @override
  String get internal => 'Interno';

  @override
  String get startVerification => 'Avvia Verifica';

  @override
  String get verifyAgain => 'Verifica di Nuovo';

  @override
  String get testAccessibilityCheck => 'Verifica di Accessibilità';

  @override
  String get testSpaceAnalysis => 'Analisi dello Spazio su Disco';

  @override
  String get testReadTest => 'Test di Lettura';

  @override
  String get testFileSystemCheck => 'Verifica del File System';

  @override
  String get testSmartStatus => 'Stato S.M.A.R.T.';

  @override
  String get language => 'Lingua';

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
  String get scheduleTypeManual => 'Manuale';

  @override
  String get scheduleTypeDaily => 'Giornaliero';

  @override
  String get scheduleTypeWeekly => 'Settimanale';

  @override
  String get scheduleTypeInterval => 'Intervallo';

  @override
  String get backupName => 'Nome';

  @override
  String get backupSource => 'Fonti';

  @override
  String get backupCompression => 'Compressione';

  @override
  String get backupEncryption => 'Crittografia';

  @override
  String get encryptionActive => 'Attiva';

  @override
  String get noRoutinesConfigured => 'Nessuna routine configurata';

  @override
  String nextBackupFormat(String routineName, String time) {
    return 'Successivo: \"$routineName\" $time';
  }

  @override
  String diskSpaceSufficient(String margin) {
    return 'Spazio sufficiente! Margine di $margin% disponibile.';
  }

  @override
  String diskSpaceInsufficient(String deficit) {
    return 'Spazio insufficiente! $deficit mancanti sul disco di destinazione.';
  }

  @override
  String get dateToday => 'Oggi';

  @override
  String get dateTomorrow => 'Domani';

  @override
  String get weekdayMonday => 'Lun';

  @override
  String get weekdayTuesday => 'Mar';

  @override
  String get weekdayWednesday => 'Mer';

  @override
  String get weekdayThursday => 'Gio';

  @override
  String get weekdayFriday => 'Ven';

  @override
  String get weekdaySaturday => 'Sab';

  @override
  String get weekdaySunday => 'Dom';

  @override
  String get about => 'About';

  @override
  String get aboutTitle => 'Informazioni su ShadowSync';

  @override
  String get version => 'Versione';

  @override
  String get developer => 'Sviluppatore';

  @override
  String get visitWebsite => 'Visita il sito web';
}
