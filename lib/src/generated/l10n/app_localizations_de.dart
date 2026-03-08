// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'ShadowSync';

  @override
  String get appSubtitle => 'Backup-Manager';

  @override
  String get myRoutines => 'Meine Routinen';

  @override
  String get verifyDisk => 'Datenträger überprüfen';

  @override
  String get decrypt => 'Entschlüsseln';

  @override
  String get settings => 'Einstellungen';

  @override
  String startingBackup(String routineName) {
    return 'Backup \"$routineName\" wird gestartet...';
  }

  @override
  String get deleteRoutine => 'Routine löschen';

  @override
  String deleteRoutineConfirm(String routineName) {
    return 'Möchten Sie die Routine \"$routineName\" wirklich löschen? Diese Aktion kann nicht rückgängig gemacht werden.';
  }

  @override
  String get cancel => 'Abbrechen';

  @override
  String get delete => 'Löschen';

  @override
  String get noRoutines => 'Keine Routine konfiguriert';

  @override
  String get noScheduledBackups => 'Keine geplanten Sicherungen';

  @override
  String get serviceActive => 'Service aktiv';

  @override
  String nextBackup(String name, String time) {
    return 'Nächstes: \"$name\" $time';
  }

  @override
  String get today => 'heute';

  @override
  String get tomorrow => 'morgen';

  @override
  String get monday => 'Mo';

  @override
  String get tuesday => 'Di';

  @override
  String get wednesday => 'Mi';

  @override
  String get thursday => 'Do';

  @override
  String get friday => 'Fr';

  @override
  String get saturday => 'Sa';

  @override
  String get sunday => 'So';

  @override
  String get newBackup => 'Neues Backup';

  @override
  String get runBackup => 'Backup ausführen';

  @override
  String get deleteRoutineTooltip => 'Routine löschen';

  @override
  String get manualExecution => 'Manuelle Ausführung';

  @override
  String get noScheduleAvailable => 'Nicht geplant';

  @override
  String scheduledDaily(String time) {
    return 'Geplant: Täglich um $time';
  }

  @override
  String scheduledWeekly(String date) {
    return 'Geplant: Wöchentlich • $date';
  }

  @override
  String scheduledInterval(String interval) {
    return 'Geplant: Alle $interval';
  }

  @override
  String get mode => 'Modus: ';

  @override
  String get next => 'Nächstes: ';

  @override
  String get last => 'Letztes: ';

  @override
  String get lastBackupLabel => 'Letztes Backup: ';

  @override
  String fileCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Dateien',
      one: '1 Datei',
    );
    return '$_temp0';
  }

  @override
  String extractedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count extrahiert',
      one: '1 extrahiert',
    );
    return '$_temp0';
  }

  @override
  String get general => 'Allgemein';

  @override
  String get telegram => 'Telegram';

  @override
  String get email => 'E-Mail';

  @override
  String get userName => 'Benutzername';

  @override
  String get enterYourName => 'Geben Sie Ihren Namen ein';

  @override
  String get encryptionPassword => 'Verschlüsselungspasswort';

  @override
  String get encryptionPasswordHint =>
      'Wird verwendet, um Ihre verschlüsselten Backups zu schützen';

  @override
  String get enterPassword => 'Passwort eingeben';

  @override
  String get backupFileName => 'Backup-Dateiname';

  @override
  String get useCustomName => 'Benutzerdefinierten Namen verwenden';

  @override
  String get customName => 'Benutzerdefinierter Name';

  @override
  String get telegramNotifications => 'Benachrichtigungen über Telegram';

  @override
  String get telegramDescription =>
      'Erhalten Sie Benachrichtigungen über Ihre Backups per Telegram';

  @override
  String get enableNotifications => 'Benachrichtigungen aktivieren';

  @override
  String get botToken => 'Bot-Token';

  @override
  String get botTokenHint =>
      'Erstellen Sie einen Bot mit @BotFather auf Telegram';

  @override
  String get botTokenExample => '123456789:ABCdefGHI...';

  @override
  String get chatId => 'Chat-ID';

  @override
  String get chatIdHint =>
      'Senden Sie /start an den Bot und verwenden Sie @userinfobot zum Abrufen';

  @override
  String get chatIdExample => 'Ihre Chat-ID (z.B.: 123456789)';

  @override
  String get whenNotify => 'Wann benachrichtigen';

  @override
  String get backupSuccess => 'Backup erfolgreich abgeschlossen';

  @override
  String get backupFailed => 'Backup fehlgeschlagen';

  @override
  String get backupStarted => 'Backup gestartet';

  @override
  String get sending => 'Wird gesendet...';

  @override
  String get sendTest => 'Test senden';

  @override
  String get emailNotifications => 'Benachrichtigungen per E-Mail';

  @override
  String get emailDescription =>
      'Erhalten Sie Benachrichtigungen über Ihre Backups per E-Mail';

  @override
  String get emailProvider => 'E-Mail-Anbieter';

  @override
  String get emailProviderHint =>
      'Wählen Sie Ihren Anbieter aus oder konfigurieren Sie manuell';

  @override
  String get selectProvider => 'Anbieter auswählen';

  @override
  String get smtpServer => 'SMTP-Server';

  @override
  String get smtpServerExample => 'Z.B.: smtp.gmail.com';

  @override
  String get smtpServerPlaceholder => 'smtp.example.com';

  @override
  String get smtpPort => 'SMTP-Port';

  @override
  String get smtpPortHint => '587 für TLS, 465 für SSL';

  @override
  String get smtpPortPlaceholder => '587';

  @override
  String get yourEmail => 'Ihre E-Mail';

  @override
  String get yourEmailHint =>
      'E-Mail, die zum Senden von Benachrichtigungen verwendet wird';

  @override
  String get yourEmailPlaceholder => 'ihreemail@gmail.com';

  @override
  String get emailPassword => 'Passwort oder App-Passwort';

  @override
  String get emailPasswordHint =>
      'Verwenden Sie App-Passwort bei Zwei-Faktor-Authentifizierung';

  @override
  String get emailPasswordPlaceholder => 'Ihr Passwort oder App-Passwort';

  @override
  String get destinationEmails => 'Ziel-E-Mails';

  @override
  String get destinationEmailsHint => 'Trennen Sie mehrere E-Mails durch Komma';

  @override
  String get destinationEmailsPlaceholder =>
      'email1@beispiel.com, email2@beispiel.com';

  @override
  String get security => 'Sicherheit';

  @override
  String get useStartTls => 'STARTTLS verwenden (empfohlen)';

  @override
  String get useSsl => 'SSL verwenden';

  @override
  String get save => 'Speichern';

  @override
  String get fillBotTokenAndChatId =>
      'Füllen Sie Bot-Token und Chat-ID aus, um einen Test zu senden';

  @override
  String get testMessageSent => 'Testnachricht erfolgreich gesendet!';

  @override
  String errorWithMessage(String message) {
    return 'Fehler: $message';
  }

  @override
  String get fillAllFields => 'Füllen Sie alle Pflichtfelder aus';

  @override
  String get enterAtLeastOneEmail =>
      'Geben Sie mindestens eine Ziel-E-Mail ein';

  @override
  String get testEmailSent => 'Test-E-Mail erfolgreich gesendet!';

  @override
  String get basicData => 'Basisdaten';

  @override
  String get scheduling => 'Planung';

  @override
  String get processing => 'Verarbeitung';

  @override
  String get review => 'Überprüfung';

  @override
  String get nextStep => 'Weiter';

  @override
  String get saveRoutine => 'Routine speichern';

  @override
  String get back => 'Zurück';

  @override
  String get routineName => 'Routinenname';

  @override
  String get backupSources => 'Backup-Quellen';

  @override
  String get selectFilesAndFolders =>
      'Sie können Dateien und/oder Ordner auswählen.';

  @override
  String get sourcePathsExample =>
      '/Users/meinbenutzer/Documents;/Users/meinbenutzer/Projekte';

  @override
  String get addSource => 'Quelle hinzufügen';

  @override
  String get selecting => 'Wird ausgewählt...';

  @override
  String get selectFiles => 'Datei(en) auswählen';

  @override
  String get selectFolder => 'Ordner auswählen';

  @override
  String get backupDestination => 'Backup-Ziel';

  @override
  String get destinationDescription =>
      'Wählen Sie den Ordner aus, in dem die Dateien gespeichert werden.';

  @override
  String get destinationExample => '/Volumes/Backup/Ziel';

  @override
  String get selectDestinationFolder => 'Zielordner auswählen';

  @override
  String get frequency => 'Häufigkeit';

  @override
  String get manual => 'Manuell';

  @override
  String get daily => 'Täglich';

  @override
  String get weekly => 'Wöchentlich';

  @override
  String get interval => 'Intervall';

  @override
  String get runAt => 'Ausführen um:';

  @override
  String get runEvery => 'Ausführen alle:';

  @override
  String get manualExecutionInfo =>
      'Das Backup wird manuell ausgeführt, wenn Sie die Play-Schaltfläche auf der Karte drücken.';

  @override
  String get oneMinute => '1 Minute';

  @override
  String nMinutes(int n) {
    return '$n Minuten';
  }

  @override
  String get oneHour => '1 Stunde';

  @override
  String nHours(int n) {
    return '$n Stunden';
  }

  @override
  String get oneDay => '1 Tag';

  @override
  String nDays(int n) {
    return '$n Tage';
  }

  @override
  String get compressBackup => 'Backup komprimieren';

  @override
  String get compressionFormat => 'Komprimierungsformat';

  @override
  String get encryptBackup => 'Backup verschlüsseln';

  @override
  String get name => 'Name';

  @override
  String get sources => 'Quellen';

  @override
  String get destination => 'Ziel';

  @override
  String get schedule => 'Planung';

  @override
  String get compression => 'Komprimierung';

  @override
  String activeWithFormat(String format) {
    return 'Aktiv ($format)';
  }

  @override
  String get deactivated => 'Deaktiviert';

  @override
  String get encryption => 'Verschlüsselung';

  @override
  String get active => 'Aktiv';

  @override
  String get diskSpace => 'Speicherplatz';

  @override
  String get calculatingSizes => 'Größen werden berechnet...';

  @override
  String get sourceSize => 'Größe der Quelle';

  @override
  String get notAvailable => 'Nicht verfügbar';

  @override
  String get availableSpace => 'Verfügbarer Speicherplatz am Ziel';

  @override
  String get retention => 'Aufbewahrung (Anzahl der Versionen)';

  @override
  String sufficientSpace(String percent) {
    return 'Ausreichend Speicherplatz! $percent% Puffer verfügbar.';
  }

  @override
  String insufficientSpace(String size) {
    return 'Nicht genügend Speicherplatz! Es fehlen $size auf dem Zieldatenträger.';
  }

  @override
  String get fileSelectionCancelled => 'Dateiauswahl abgebrochen.';

  @override
  String filesAdded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Dateien zur Quelle hinzugefügt.',
      one: '1 Datei zur Quelle hinzugefügt.',
    );
    return '$_temp0';
  }

  @override
  String failedToSelectFiles(String error) {
    return 'Fehler beim Auswählen der Dateien: $error';
  }

  @override
  String get folderSelectionCancelled =>
      'Auswahl des Quellordners abgebrochen.';

  @override
  String get sourceFolderSelected => 'Quellordner ausgewählt.';

  @override
  String failedToSelectSourceFolder(String error) {
    return 'Fehler beim Auswählen des Quellordners: $error';
  }

  @override
  String get iosSaveLocation =>
      'Unter iOS werden die Backups gespeichert in: Dokumente/Backups';

  @override
  String get destinationSelectionCancelled =>
      'Auswahl des Zielordners abgebrochen.';

  @override
  String get destinationFolderSelected => 'Zielordner ausgewählt.';

  @override
  String failedToSelectDestination(String error) {
    return 'Fehler beim Auswählen des Zielordners: $error';
  }

  @override
  String get enterRoutineName => 'Geben Sie den Routinennamen ein.';

  @override
  String get enterAtLeastOneSource => 'Geben Sie mindestens eine Quelle ein.';

  @override
  String get enterDestinationPath => 'Geben Sie den Zielpfad ein.';

  @override
  String get retentionMustBePositive =>
      'Aufbewahrung muss eine Zahl größer als Null sein.';

  @override
  String get configureEncryptionPassword =>
      'Konfigurieren Sie ein Verschlüsselungspasswort in den Einstellungen, bevor Sie die Verschlüsselung aktivieren.';

  @override
  String get decryptFile => 'Datei entschlüsseln';

  @override
  String get decryptionDescription =>
      'Entschlüsseln Sie durch ShadowSync geschützte Dateien';

  @override
  String get encryptedFile => 'Verschlüsselte Datei';

  @override
  String get selectFileEllipsis => 'Datei auswählen...';

  @override
  String get destinationFolder => 'Zielordner';

  @override
  String get selectFolderEllipsis => 'Ordner auswählen...';

  @override
  String get outputFileName => 'Name der Ausgabedatei:';

  @override
  String get decryptionPassword => 'Entschlüsselungspasswort:';

  @override
  String get enterEncryptionPassword =>
      'Geben Sie das bei der Verschlüsselung verwendete Passwort ein';

  @override
  String get selectEncryptedFile => 'Verschlüsselte Datei auswählen';

  @override
  String get selectDestinationFolderTooltip => 'Zielordner auswählen';

  @override
  String get execute => 'Ausführen';

  @override
  String get decrypting => 'Wird entschlüsselt...';

  @override
  String get close => 'Schließen';

  @override
  String get decryptAnother => 'Weitere entschlüsseln';

  @override
  String get startingDecryption => 'Entschlüsselung wird gestartet...';

  @override
  String get preparingDecryption => 'Entschlüsselung wird vorbereitet...';

  @override
  String get decryptingFile => 'Datei wird entschlüsselt...';

  @override
  String get extractingContent => 'Inhalt wird extrahiert...';

  @override
  String get finalizing => 'Wird abgeschlossen...';

  @override
  String decryptedSuccessfully(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Dateien extrahiert.',
      one: '1 Datei extrahiert.',
    );
    return 'Erfolgreich entschlüsselt! $_temp0';
  }

  @override
  String errorSelectingFile(String error) {
    return 'Fehler beim Auswählen der Datei: $error';
  }

  @override
  String errorSelectingDestination(String error) {
    return 'Fehler beim Auswählen des Ziels: $error';
  }

  @override
  String get verifyDiskTitle => 'Datenträger überprüfen';

  @override
  String get selectDiskToVerify =>
      'Wählen Sie einen Datenträger aus, um dessen Integrität zu überprüfen';

  @override
  String verifying(String diskName) {
    return 'Überprüfen: $diskName';
  }

  @override
  String get backToSelection => 'Zurück zur Auswahl';

  @override
  String get loadingDisks => 'Datenträger werden geladen...';

  @override
  String errorLoadingDisks(String error) {
    return 'Fehler beim Laden der Datenträger: $error';
  }

  @override
  String get tryAgain => 'Erneut versuchen';

  @override
  String get noDisksFound => 'Keine Datenträger gefunden';

  @override
  String freeSpace(String size) {
    return '$size frei';
  }

  @override
  String get diskSpaceUnavailable => 'Speicherinformationen nicht verfügbar';

  @override
  String get internalStorage => 'Interner Speicher';

  @override
  String get sdCard => 'SD-Karte';

  @override
  String get externalSdCard => 'Externe SD-Karte';

  @override
  String get primaryStorage => 'Primärer Speicher';

  @override
  String get externalStorage => 'Externer Speicher';

  @override
  String get deviceStorage => 'Gerätespeicher';

  @override
  String get appStorage => 'App-Speicher';

  @override
  String get testsToRun => 'Auszuführende Tests:';

  @override
  String get testResults => 'Testergebnisse';

  @override
  String get verificationInProgress => 'Überprüfung läuft...';

  @override
  String get diskVerifiedNoProblems =>
      'Datenträger überprüft - Keine Probleme gefunden';

  @override
  String get verificationCompletedWithWarnings =>
      'Überprüfung mit Warnungen abgeschlossen';

  @override
  String get problemsDetected => 'Probleme am Datenträger erkannt';

  @override
  String get waiting => 'Warten...';

  @override
  String totalTime(String duration) {
    return 'Gesamtzeit: $duration';
  }

  @override
  String get mountPoint => 'Einhängepunkt';

  @override
  String get device => 'Gerät';

  @override
  String get fileSystem => 'Dateisystem';

  @override
  String get totalCapacity => 'Gesamtkapazität';

  @override
  String get availableSpaceLabel => 'Verfügbarer Speicherplatz';

  @override
  String get mediaType => 'Medientyp';

  @override
  String get type => 'Typ';

  @override
  String get removable => 'Wechselmedium';

  @override
  String get internal => 'Intern';

  @override
  String get startVerification => 'Überprüfung starten';

  @override
  String get verifyAgain => 'Erneut überprüfen';

  @override
  String get testAccessibilityCheck => 'Barrierefreiheitsprüfung';

  @override
  String get testSpaceAnalysis => 'Speicherplatzanalyse';

  @override
  String get testReadTest => 'Lesetest';

  @override
  String get testFileSystemCheck => 'Dateisystemprüfung';

  @override
  String get testSmartStatus => 'S.M.A.R.T. Status';

  @override
  String get fullDiskAccessRequired =>
      'Zugriff verweigert. Unter macOS gewähren Sie ShadowSync \"Vollständiger Festplattenzugriff\" in Systemeinstellungen > Datenschutz & Sicherheit > Vollständiger Festplattenzugriff.';

  @override
  String get fileSystemCheckRequiresPrivileges =>
      'Die Dateisystemüberprüfung erfordert privilegierten Systemzugriff. Verwenden Sie die App \"Festplatten-Dienstprogramm\" unter macOS, um dieses Volume manuell zu überprüfen.';

  @override
  String get language => 'Sprache';

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
  String get scheduleTypeManual => 'Manuell';

  @override
  String get scheduleTypeDaily => 'Täglich';

  @override
  String get scheduleTypeWeekly => 'Wöchentlich';

  @override
  String get scheduleTypeInterval => 'Intervall';

  @override
  String get backupName => 'Name';

  @override
  String get backupSource => 'Quellen';

  @override
  String get backupCompression => 'Kompression';

  @override
  String get backupEncryption => 'Verschlüsselung';

  @override
  String get encryptionActive => 'Aktiviert';

  @override
  String get noRoutinesConfigured => 'Keine Routinen konfiguriert';

  @override
  String nextBackupFormat(String routineName, String time) {
    return 'Nächste: \"$routineName\" $time';
  }

  @override
  String diskSpaceSufficient(String margin) {
    return 'Ausreichend Speicherplatz! $margin% Spielraum verfügbar.';
  }

  @override
  String diskSpaceInsufficient(String deficit) {
    return 'Speicherplatz unzureichend! $deficit auf dem Zieldatenträger fehlt.';
  }

  @override
  String get dateToday => 'Heute';

  @override
  String get dateTomorrow => 'Morgen';

  @override
  String get weekdayMonday => 'Mo';

  @override
  String get weekdayTuesday => 'Di';

  @override
  String get weekdayWednesday => 'Mi';

  @override
  String get weekdayThursday => 'Do';

  @override
  String get weekdayFriday => 'Fr';

  @override
  String get weekdaySaturday => 'Sa';

  @override
  String get weekdaySunday => 'So';

  @override
  String get about => 'Über';

  @override
  String get aboutTitle => 'Über ShadowSync';

  @override
  String get version => 'Version';

  @override
  String get developer => 'Entwickler';

  @override
  String get visitWebsite => 'Website besuchen';
}
