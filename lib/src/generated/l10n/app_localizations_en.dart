// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'ShadowSync';

  @override
  String get appSubtitle => 'Backup Manager';

  @override
  String get myRoutines => 'My Routines';

  @override
  String get verifyDisk => 'Verify Disk';

  @override
  String get decrypt => 'Decrypt';

  @override
  String get settings => 'Settings';

  @override
  String startingBackup(String routineName) {
    return 'Starting backup \"$routineName\"...';
  }

  @override
  String get deleteRoutine => 'Delete routine';

  @override
  String deleteRoutineConfirm(String routineName) {
    return 'Do you really want to delete the routine \"$routineName\"? This action cannot be undone.';
  }

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get noRoutines => 'No routines configured';

  @override
  String get noScheduledBackups => 'No automatic backups scheduled';

  @override
  String get serviceActive => 'Service active';

  @override
  String nextBackup(String name, String time) {
    return 'Next: \"$name\" $time';
  }

  @override
  String get today => 'today';

  @override
  String get tomorrow => 'tomorrow';

  @override
  String get monday => 'mon';

  @override
  String get tuesday => 'tue';

  @override
  String get wednesday => 'wed';

  @override
  String get thursday => 'thu';

  @override
  String get friday => 'fri';

  @override
  String get saturday => 'sat';

  @override
  String get sunday => 'sun';

  @override
  String get newBackup => 'New Backup';

  @override
  String get runBackup => 'Run backup';

  @override
  String get deleteRoutineTooltip => 'Delete routine';

  @override
  String get manualExecution => 'Manual execution';

  @override
  String get noScheduleAvailable => 'Not scheduled';

  @override
  String scheduledDaily(String time) {
    return 'Scheduled: Daily at $time';
  }

  @override
  String scheduledWeekly(String date) {
    return 'Scheduled: Weekly • $date';
  }

  @override
  String scheduledInterval(String interval) {
    return 'Scheduled: Every $interval';
  }

  @override
  String get mode => 'Mode: ';

  @override
  String get next => 'Next: ';

  @override
  String get last => 'Last: ';

  @override
  String get lastBackupLabel => 'Last backup: ';

  @override
  String fileCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count files',
      one: '1 file',
    );
    return '$_temp0';
  }

  @override
  String extractedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count extracted',
      one: '1 extracted',
    );
    return '$_temp0';
  }

  @override
  String get general => 'General';

  @override
  String get telegram => 'Telegram';

  @override
  String get email => 'Email';

  @override
  String get userName => 'User Name';

  @override
  String get enterYourName => 'Enter your name';

  @override
  String get encryptionPassword => 'Encryption Password';

  @override
  String get encryptionPasswordHint => 'Used to protect your encrypted backups';

  @override
  String get enterPassword => 'Enter password';

  @override
  String get backupFileName => 'Backup File Name';

  @override
  String get useCustomName => 'Use custom name';

  @override
  String get customName => 'Custom name';

  @override
  String get telegramNotifications => 'Telegram Notifications';

  @override
  String get telegramDescription =>
      'Receive alerts about your backups via Telegram';

  @override
  String get enableNotifications => 'Enable notifications';

  @override
  String get botToken => 'Bot Token';

  @override
  String get botTokenHint => 'Create a bot with @BotFather on Telegram';

  @override
  String get botTokenExample => '123456789:ABCdefGHI...';

  @override
  String get chatId => 'Chat ID';

  @override
  String get chatIdHint =>
      'Send /start to the bot and use @userinfobot to get it';

  @override
  String get chatIdExample => 'Your Chat ID (e.g., 123456789)';

  @override
  String get whenNotify => 'When to Notify';

  @override
  String get backupSuccess => 'Backup completed successfully';

  @override
  String get backupFailed => 'Backup Failed ✗';

  @override
  String get backupStarted => 'Backup started';

  @override
  String get sending => 'Sending...';

  @override
  String get sendTest => 'Send Test';

  @override
  String get emailNotifications => 'Email Notifications';

  @override
  String get emailDescription => 'Receive alerts about your backups via email';

  @override
  String get emailProvider => 'Email Provider';

  @override
  String get emailProviderHint => 'Select your provider or configure manually';

  @override
  String get selectProvider => 'Select a provider';

  @override
  String get smtpServer => 'SMTP Server';

  @override
  String get smtpServerExample => 'E.g., smtp.gmail.com';

  @override
  String get smtpServerPlaceholder => 'smtp.example.com';

  @override
  String get smtpPort => 'SMTP Port';

  @override
  String get smtpPortHint => '587 for TLS, 465 for SSL';

  @override
  String get smtpPortPlaceholder => '587';

  @override
  String get yourEmail => 'Your Email';

  @override
  String get yourEmailHint => 'Email to be used to send notifications';

  @override
  String get yourEmailPlaceholder => 'youremail@gmail.com';

  @override
  String get emailPassword => 'Password or App Password';

  @override
  String get emailPasswordHint =>
      'Use App Password if you have 2-step authentication';

  @override
  String get emailPasswordPlaceholder => 'Your password or App Password';

  @override
  String get destinationEmails => 'Destination Emails';

  @override
  String get destinationEmailsHint => 'Separate multiple emails with comma';

  @override
  String get destinationEmailsPlaceholder =>
      'email1@example.com, email2@example.com';

  @override
  String get security => 'Security';

  @override
  String get useStartTls => 'Use STARTTLS (recommended)';

  @override
  String get useSsl => 'Use SSL';

  @override
  String get save => 'Save';

  @override
  String get fillBotTokenAndChatId =>
      'Fill in the Bot Token and Chat ID to send a test';

  @override
  String get testMessageSent => 'Test message sent successfully!';

  @override
  String errorWithMessage(String message) {
    return 'Error: $message';
  }

  @override
  String get fillAllFields => 'Fill in all required fields';

  @override
  String get enterAtLeastOneEmail => 'Enter at least one destination email';

  @override
  String get testEmailSent => 'Test email sent successfully!';

  @override
  String get basicData => 'Basic Data';

  @override
  String get scheduling => 'Scheduling';

  @override
  String get processing => 'Processing';

  @override
  String get review => 'Review';

  @override
  String get nextStep => 'Next';

  @override
  String get saveRoutine => 'Save Routine';

  @override
  String get back => 'Back';

  @override
  String get routineName => 'Routine name';

  @override
  String get backupSources => 'Backup Sources';

  @override
  String get selectFilesAndFolders => 'You can select files and/or folders.';

  @override
  String get sourcePathsExample =>
      '/Users/myuser/Documents;/Users/myuser/Projects';

  @override
  String get addSource => 'Add Source';

  @override
  String get selecting => 'Selecting...';

  @override
  String get selectFiles => 'Select File(s)';

  @override
  String get selectFolder => 'Select Folder';

  @override
  String get backupDestination => 'Backup Destination';

  @override
  String get destinationDescription =>
      'Choose the folder where files will be saved.';

  @override
  String get destinationExample => '/Volumes/Backup/Destination';

  @override
  String get selectDestinationFolder => 'Select Destination Folder';

  @override
  String get frequency => 'Frequency';

  @override
  String get manual => 'Manual';

  @override
  String get daily => 'Daily';

  @override
  String get weekly => 'Weekly';

  @override
  String get interval => 'Interval';

  @override
  String get runAt => 'Run at:';

  @override
  String get runEvery => 'Run every:';

  @override
  String get manualExecutionInfo =>
      'The backup will be executed manually when you press the play button on the card.';

  @override
  String get oneMinute => '1 minute';

  @override
  String nMinutes(int n) {
    return '$n minutes';
  }

  @override
  String get oneHour => '1 hour';

  @override
  String nHours(int n) {
    return '$n hours';
  }

  @override
  String get oneDay => '1 day';

  @override
  String nDays(int n) {
    return '$n days';
  }

  @override
  String get compressBackup => 'Compress backup';

  @override
  String get compressionFormat => 'Compression format';

  @override
  String get encryptBackup => 'Encrypt backup';

  @override
  String get name => 'Name';

  @override
  String get sources => 'Sources';

  @override
  String get destination => 'Destination';

  @override
  String get schedule => 'Schedule';

  @override
  String get compression => 'Compression';

  @override
  String activeWithFormat(String format) {
    return 'Active ($format)';
  }

  @override
  String get deactivated => 'Deactivated';

  @override
  String get encryption => 'Encryption';

  @override
  String get active => 'Active';

  @override
  String get diskSpace => 'Disk Space';

  @override
  String get calculatingSizes => 'Calculating sizes...';

  @override
  String get sourceSize => 'Source size';

  @override
  String get notAvailable => 'Not available';

  @override
  String get availableSpace => 'Available space at destination';

  @override
  String get retention => 'Retention (number of versions)';

  @override
  String sufficientSpace(String percent) {
    return 'Sufficient space! $percent% margin available.';
  }

  @override
  String insufficientSpace(String size) {
    return 'Insufficient space! $size missing on destination disk.';
  }

  @override
  String get fileSelectionCancelled => 'File selection cancelled.';

  @override
  String filesAdded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count files added to source.',
      one: '1 file added to source.',
    );
    return '$_temp0';
  }

  @override
  String failedToSelectFiles(String error) {
    return 'Failed to select files: $error';
  }

  @override
  String get folderSelectionCancelled => 'Source folder selection cancelled.';

  @override
  String get sourceFolderSelected => 'Source folder selected.';

  @override
  String failedToSelectSourceFolder(String error) {
    return 'Failed to select source folder: $error';
  }

  @override
  String get iosSaveLocation =>
      'On iOS, backups will be saved to: Documents/Backups';

  @override
  String get destinationSelectionCancelled =>
      'Destination folder selection cancelled.';

  @override
  String get destinationFolderSelected => 'Destination folder selected.';

  @override
  String failedToSelectDestination(String error) {
    return 'Failed to select destination folder: $error';
  }

  @override
  String get enterRoutineName => 'Enter the routine name.';

  @override
  String get enterAtLeastOneSource => 'Enter at least one source.';

  @override
  String get enterDestinationPath => 'Enter the destination path.';

  @override
  String get retentionMustBePositive =>
      'Retention must be a number greater than zero.';

  @override
  String get configureEncryptionPassword =>
      'Configure an encryption password in Settings before enabling encryption.';

  @override
  String get decryptFile => 'Decrypt File';

  @override
  String get decryptionDescription => 'Decrypt files protected by ShadowSync';

  @override
  String get encryptedFile => 'Encrypted File';

  @override
  String get selectFileEllipsis => 'Select file...';

  @override
  String get destinationFolder => 'Destination Folder';

  @override
  String get selectFolderEllipsis => 'Select folder...';

  @override
  String get outputFileName => 'Output file name:';

  @override
  String get decryptionPassword => 'Decryption password:';

  @override
  String get enterEncryptionPassword =>
      'Enter the password used for encryption';

  @override
  String get selectEncryptedFile => 'Select encrypted file';

  @override
  String get selectDestinationFolderTooltip => 'Select destination folder';

  @override
  String get execute => 'Execute';

  @override
  String get decrypting => 'Decrypting...';

  @override
  String get close => 'Close';

  @override
  String get decryptAnother => 'Decrypt Another';

  @override
  String get startingDecryption => 'Starting decryption...';

  @override
  String get preparingDecryption => 'Preparing decryption...';

  @override
  String get decryptingFile => 'Decrypting file...';

  @override
  String get extractingContent => 'Extracting content...';

  @override
  String get finalizing => 'Finalizing...';

  @override
  String decryptedSuccessfully(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count files extracted.',
      one: '1 file extracted.',
    );
    return 'Decrypted successfully! $_temp0';
  }

  @override
  String errorSelectingFile(String error) {
    return 'Error selecting file: $error';
  }

  @override
  String errorSelectingDestination(String error) {
    return 'Error selecting destination: $error';
  }

  @override
  String get verifyDiskTitle => 'Verify Disk';

  @override
  String get selectDiskToVerify => 'Select a disk to verify its integrity';

  @override
  String verifying(String diskName) {
    return 'Verifying: $diskName';
  }

  @override
  String get backToSelection => 'Back to selection';

  @override
  String get loadingDisks => 'Loading disks...';

  @override
  String errorLoadingDisks(String error) {
    return 'Error loading disks: $error';
  }

  @override
  String get tryAgain => 'Try again';

  @override
  String get noDisksFound => 'No disks found';

  @override
  String freeSpace(String size) {
    return '$size free';
  }

  @override
  String get diskSpaceUnavailable => 'Space info unavailable';

  @override
  String get internalStorage => 'Internal Storage';

  @override
  String get sdCard => 'SD Card';

  @override
  String get externalSdCard => 'External SD Card';

  @override
  String get primaryStorage => 'Primary Storage';

  @override
  String get externalStorage => 'External Storage';

  @override
  String get deviceStorage => 'Device Storage';

  @override
  String get appStorage => 'App Storage';

  @override
  String get testsToRun => 'Tests to be run:';

  @override
  String get testResults => 'Test Results';

  @override
  String get verificationInProgress => 'Verification in progress...';

  @override
  String get diskVerifiedNoProblems => 'Disk verified - No problems found';

  @override
  String get verificationCompletedWithWarnings =>
      'Verification completed with warnings';

  @override
  String get problemsDetected => 'Problems detected on disk';

  @override
  String get waiting => 'Waiting...';

  @override
  String totalTime(String duration) {
    return 'Total time: $duration';
  }

  @override
  String get mountPoint => 'Mount point';

  @override
  String get device => 'Device';

  @override
  String get fileSystem => 'File system';

  @override
  String get totalCapacity => 'Total capacity';

  @override
  String get availableSpaceLabel => 'Available space';

  @override
  String get mediaType => 'Media type';

  @override
  String get type => 'Type';

  @override
  String get removable => 'Removable';

  @override
  String get internal => 'Internal';

  @override
  String get startVerification => 'Start Verification';

  @override
  String get verifyAgain => 'Verify Again';

  @override
  String get testAccessibilityCheck => 'Accessibility Check';

  @override
  String get testSpaceAnalysis => 'Disk Space Analysis';

  @override
  String get testReadTest => 'Read Test';

  @override
  String get testFileSystemCheck => 'File System Check';

  @override
  String get testSmartStatus => 'S.M.A.R.T. Status';

  @override
  String get language => 'Language';

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
  String get scheduleTypeDaily => 'Daily';

  @override
  String get scheduleTypeWeekly => 'Weekly';

  @override
  String get scheduleTypeInterval => 'Interval';

  @override
  String get backupName => 'Name';

  @override
  String get backupSource => 'Sources';

  @override
  String get backupCompression => 'Compression';

  @override
  String get backupEncryption => 'Encryption';

  @override
  String get encryptionActive => 'Active';

  @override
  String get noRoutinesConfigured => 'No routines configured';

  @override
  String nextBackupFormat(String routineName, String time) {
    return 'Next: \"$routineName\" $time';
  }

  @override
  String diskSpaceSufficient(String margin) {
    return 'Sufficient space! $margin% margin available.';
  }

  @override
  String diskSpaceInsufficient(String deficit) {
    return 'Insufficient space! $deficit missing on destination disk.';
  }

  @override
  String get dateToday => 'today';

  @override
  String get dateTomorrow => 'tomorrow';

  @override
  String get weekdayMonday => 'Mon';

  @override
  String get weekdayTuesday => 'Tue';

  @override
  String get weekdayWednesday => 'Wed';

  @override
  String get weekdayThursday => 'Thu';

  @override
  String get weekdayFriday => 'Fri';

  @override
  String get weekdaySaturday => 'Sat';

  @override
  String get weekdaySunday => 'Sun';

  @override
  String get about => 'About';

  @override
  String get aboutTitle => 'About ShadowSync';

  @override
  String get version => 'Version';

  @override
  String get developer => 'Developer';

  @override
  String get visitWebsite => 'Visit Website';

  @override
  String get backupCompleted => 'Backup Completed ✓';

  @override
  String backupCompletedMessage(String routineName) {
    return 'The backup \"$routineName\" has been completed successfully.';
  }

  @override
  String backupFailedMessage(String routineName, String errorMessage) {
    return 'The backup \"$routineName\" failed: $errorMessage';
  }

  @override
  String get nextBackupScheduled => 'Next Backup Scheduled';

  @override
  String nextBackupMessage(String routineName, String timeDescription) {
    return '\"$routineName\" will be executed $timeDescription.';
  }

  @override
  String get inLessThanMinute => 'in less than 1 minute';

  @override
  String get inMinute => 'in 1 minute';

  @override
  String inMinutes(int count) {
    return 'in $count minutes';
  }

  @override
  String get inHour => 'in 1 hour';

  @override
  String inHours(int count) {
    return 'in $count hours';
  }

  @override
  String inHoursMinutes(int hours, int minutes) {
    return 'in ${hours}h${minutes}min';
  }

  @override
  String get inDay => 'in 1 day';

  @override
  String inDays(int count) {
    return 'in $count days';
  }

  @override
  String get notificationChannelName => 'ShadowSync Backups';

  @override
  String get notificationChannelDescription =>
      'Notifications about backup status and schedules';
}
