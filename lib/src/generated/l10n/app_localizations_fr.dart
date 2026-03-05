// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'ShadowSync';

  @override
  String get appSubtitle => 'Gestionnaire de Sauvegardes';

  @override
  String get myRoutines => 'Mes Routines';

  @override
  String get verifyDisk => 'Vérifier le Disque';

  @override
  String get decrypt => 'Déchiffrer';

  @override
  String get settings => 'Paramètres';

  @override
  String startingBackup(String routineName) {
    return 'Démarrage de la sauvegarde \"$routineName\"...';
  }

  @override
  String get deleteRoutine => 'Supprimer la routine';

  @override
  String deleteRoutineConfirm(String routineName) {
    return 'Voulez-vous vraiment supprimer la routine \"$routineName\" ? Cette action ne peut pas être annulée.';
  }

  @override
  String get cancel => 'Annuler';

  @override
  String get delete => 'Supprimer';

  @override
  String get noRoutines => 'Aucune routine configurée';

  @override
  String get noScheduledBackups => 'Aucune sauvegarde automatique programmée';

  @override
  String get serviceActive => 'Service actif';

  @override
  String nextBackup(String name, String time) {
    return 'Suivant : \"$name\" $time';
  }

  @override
  String get today => 'aujourd\'hui';

  @override
  String get tomorrow => 'demain';

  @override
  String get monday => 'lun';

  @override
  String get tuesday => 'mar';

  @override
  String get wednesday => 'mer';

  @override
  String get thursday => 'jeu';

  @override
  String get friday => 'ven';

  @override
  String get saturday => 'sam';

  @override
  String get sunday => 'dim';

  @override
  String get newBackup => 'Nouvelle Sauvegarde';

  @override
  String get runBackup => 'Exécuter la sauvegarde';

  @override
  String get deleteRoutineTooltip => 'Supprimer la routine';

  @override
  String get manualExecution => 'Exécution manuelle';

  @override
  String get noScheduleAvailable => 'Non prévu';

  @override
  String scheduledDaily(String time) {
    return 'Programmé : Quotidiennement à $time';
  }

  @override
  String scheduledWeekly(String date) {
    return 'Programmé : Hebdomadairement • $date';
  }

  @override
  String scheduledInterval(String interval) {
    return 'Programmé : Toutes les $interval';
  }

  @override
  String get mode => 'Mode : ';

  @override
  String get next => 'Suivant : ';

  @override
  String get last => 'Dernier : ';

  @override
  String get lastBackupLabel => 'Dernière sauvegarde : ';

  @override
  String fileCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count fichiers',
      one: '1 fichier',
    );
    return '$_temp0';
  }

  @override
  String extractedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count extraits',
      one: '1 extrait',
    );
    return '$_temp0';
  }

  @override
  String get general => 'Général';

  @override
  String get telegram => 'Telegram';

  @override
  String get email => 'Email';

  @override
  String get userName => 'Nom d\'utilisateur';

  @override
  String get enterYourName => 'Entrez votre nom';

  @override
  String get encryptionPassword => 'Mot de passe de chiffrement';

  @override
  String get encryptionPasswordHint =>
      'Utilisé pour protéger vos sauvegardes chiffrées';

  @override
  String get enterPassword => 'Entrez le mot de passe';

  @override
  String get backupFileName => 'Nom du fichier de sauvegarde';

  @override
  String get useCustomName => 'Utiliser un nom personnalisé';

  @override
  String get customName => 'Nom personnalisé';

  @override
  String get telegramNotifications => 'Notifications via Telegram';

  @override
  String get telegramDescription =>
      'Recevez des alertes sur vos sauvegardes via Telegram';

  @override
  String get enableNotifications => 'Activer les notifications';

  @override
  String get botToken => 'Token du Bot';

  @override
  String get botTokenHint => 'Créez un bot avec @BotFather sur Telegram';

  @override
  String get botTokenExample => '123456789:ABCdefGHI...';

  @override
  String get chatId => 'Chat ID';

  @override
  String get chatIdHint =>
      'Envoyez /start au bot et utilisez @userinfobot pour obtenir';

  @override
  String get chatIdExample => 'Votre Chat ID (ex : 123456789)';

  @override
  String get whenNotify => 'Quand notifier';

  @override
  String get backupSuccess => 'Sauvegarde terminée avec succès';

  @override
  String get backupFailed => 'Sauvegarde échouée';

  @override
  String get backupStarted => 'Sauvegarde démarrée';

  @override
  String get sending => 'Envoi...';

  @override
  String get sendTest => 'Envoyer un Test';

  @override
  String get emailNotifications => 'Notifications via Email';

  @override
  String get emailDescription =>
      'Recevez des alertes sur vos sauvegardes par email';

  @override
  String get emailProvider => 'Fournisseur d\'email';

  @override
  String get emailProviderHint =>
      'Sélectionnez votre fournisseur ou configurez manuellement';

  @override
  String get selectProvider => 'Sélectionnez un fournisseur';

  @override
  String get smtpServer => 'Serveur SMTP';

  @override
  String get smtpServerExample => 'Ex : smtp.gmail.com';

  @override
  String get smtpServerPlaceholder => 'smtp.exemple.com';

  @override
  String get smtpPort => 'Port SMTP';

  @override
  String get smtpPortHint => '587 pour TLS, 465 pour SSL';

  @override
  String get smtpPortPlaceholder => '587';

  @override
  String get yourEmail => 'Votre Email';

  @override
  String get yourEmailHint =>
      'Email qui sera utilisé pour envoyer les notifications';

  @override
  String get yourEmailPlaceholder => 'votreemail@gmail.com';

  @override
  String get emailPassword => 'Mot de passe ou App Password';

  @override
  String get emailPasswordHint =>
      'Utilisez App Password si vous avez l\'authentification en 2 étapes';

  @override
  String get emailPasswordPlaceholder => 'Votre mot de passe ou App Password';

  @override
  String get destinationEmails => 'Emails de destination';

  @override
  String get destinationEmailsHint =>
      'Séparez plusieurs emails par une virgule';

  @override
  String get destinationEmailsPlaceholder =>
      'email1@exemple.com, email2@exemple.com';

  @override
  String get security => 'Sécurité';

  @override
  String get useStartTls => 'Utiliser STARTTLS (recommandé)';

  @override
  String get useSsl => 'Utiliser SSL';

  @override
  String get save => 'Enregistrer';

  @override
  String get fillBotTokenAndChatId =>
      'Remplissez le Token du Bot et le Chat ID pour envoyer un test';

  @override
  String get testMessageSent => 'Message de test envoyé avec succès !';

  @override
  String errorWithMessage(String message) {
    return 'Erreur : $message';
  }

  @override
  String get fillAllFields => 'Remplissez tous les champs obligatoires';

  @override
  String get enterAtLeastOneEmail => 'Entrez au moins un email de destination';

  @override
  String get testEmailSent => 'Email de test envoyé avec succès !';

  @override
  String get basicData => 'Données de base';

  @override
  String get scheduling => 'Planification';

  @override
  String get processing => 'Traitement';

  @override
  String get review => 'Révision';

  @override
  String get nextStep => 'Suivant';

  @override
  String get saveRoutine => 'Enregistrer la Routine';

  @override
  String get back => 'Retour';

  @override
  String get routineName => 'Nom de la routine';

  @override
  String get backupSources => 'Sources de sauvegarde';

  @override
  String get selectFilesAndFolders =>
      'Vous pouvez sélectionner des fichiers et/ou des dossiers.';

  @override
  String get sourcePathsExample =>
      '/Users/monuser/Documents;/Users/monuser/Projets';

  @override
  String get addSource => 'Ajouter une Source';

  @override
  String get selecting => 'Sélection...';

  @override
  String get selectFiles => 'Sélectionner Fichier(s)';

  @override
  String get selectFolder => 'Sélectionner Dossier';

  @override
  String get backupDestination => 'Destination de la sauvegarde';

  @override
  String get destinationDescription =>
      'Choisissez le dossier où les fichiers seront enregistrés.';

  @override
  String get destinationExample => '/Volumes/Sauvegarde/Destination';

  @override
  String get selectDestinationFolder =>
      'Sélectionner le Dossier de Destination';

  @override
  String get frequency => 'Fréquence';

  @override
  String get manual => 'Manuel';

  @override
  String get daily => 'Quotidien';

  @override
  String get weekly => 'Hebdomadaire';

  @override
  String get interval => 'Intervalle';

  @override
  String get runAt => 'Exécuter à :';

  @override
  String get runEvery => 'Exécuter toutes les :';

  @override
  String get manualExecutionInfo =>
      'La sauvegarde sera exécutée manuellement lorsque vous appuierez sur le bouton play de la carte.';

  @override
  String get oneMinute => '1 minute';

  @override
  String nMinutes(int n) {
    return '$n minutes';
  }

  @override
  String get oneHour => '1 heure';

  @override
  String nHours(int n) {
    return '$n heures';
  }

  @override
  String get oneDay => '1 jour';

  @override
  String nDays(int n) {
    return '$n jours';
  }

  @override
  String get compressBackup => 'Compresser la sauvegarde';

  @override
  String get compressionFormat => 'Format de compression';

  @override
  String get encryptBackup => 'Chiffrer la sauvegarde';

  @override
  String get name => 'Nom';

  @override
  String get sources => 'Sources';

  @override
  String get destination => 'Destination';

  @override
  String get schedule => 'Programmation';

  @override
  String get compression => 'Compression';

  @override
  String activeWithFormat(String format) {
    return 'Active ($format)';
  }

  @override
  String get deactivated => 'Désactivée';

  @override
  String get encryption => 'Chiffrement';

  @override
  String get active => 'Active';

  @override
  String get diskSpace => 'Espace disque';

  @override
  String get calculatingSizes => 'Calcul des tailles...';

  @override
  String get sourceSize => 'Taille de la source';

  @override
  String get notAvailable => 'Non disponible';

  @override
  String get availableSpace => 'Espace disponible sur la destination';

  @override
  String get retention => 'Rétention (nombre de versions)';

  @override
  String sufficientSpace(String percent) {
    return 'Espace suffisant ! Marge de $percent% disponible.';
  }

  @override
  String insufficientSpace(String size) {
    return 'Espace insuffisant ! Il manque $size sur le disque de destination.';
  }

  @override
  String get fileSelectionCancelled => 'Sélection de fichiers annulée.';

  @override
  String filesAdded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count fichiers ajoutés à la source.',
      one: '1 fichier ajouté à la source.',
    );
    return '$_temp0';
  }

  @override
  String failedToSelectFiles(String error) {
    return 'Échec de la sélection des fichiers : $error';
  }

  @override
  String get folderSelectionCancelled => 'Sélection du dossier source annulée.';

  @override
  String get sourceFolderSelected => 'Dossier source sélectionné.';

  @override
  String failedToSelectSourceFolder(String error) {
    return 'Échec de la sélection du dossier source : $error';
  }

  @override
  String get iosSaveLocation =>
      'Sur iOS, les sauvegardes seront enregistrées dans : Documents/Backups';

  @override
  String get destinationSelectionCancelled =>
      'Sélection du dossier de destination annulée.';

  @override
  String get destinationFolderSelected => 'Dossier de destination sélectionné.';

  @override
  String failedToSelectDestination(String error) {
    return 'Échec de la sélection du dossier de destination : $error';
  }

  @override
  String get enterRoutineName => 'Veuillez entrer le nom de la routine.';

  @override
  String get enterAtLeastOneSource => 'Veuillez entrer au moins une source.';

  @override
  String get enterDestinationPath =>
      'Veuillez entrer le chemin de destination.';

  @override
  String get retentionMustBePositive =>
      'La rétention doit être un nombre supérieur à zéro.';

  @override
  String get configureEncryptionPassword =>
      'Configurez un mot de passe de chiffrement dans les Paramètres avant d\'activer le chiffrement.';

  @override
  String get decryptFile => 'Déchiffrer le Fichier';

  @override
  String get decryptionDescription =>
      'Déchiffrez les fichiers protégés par ShadowSync';

  @override
  String get encryptedFile => 'Fichier Chiffré';

  @override
  String get selectFileEllipsis => 'Sélectionner le fichier...';

  @override
  String get destinationFolder => 'Dossier de Destination';

  @override
  String get selectFolderEllipsis => 'Sélectionner le dossier...';

  @override
  String get outputFileName => 'Nom du fichier de sortie :';

  @override
  String get decryptionPassword => 'Mot de passe de déchiffrement :';

  @override
  String get enterEncryptionPassword =>
      'Entrez le mot de passe utilisé lors du chiffrement';

  @override
  String get selectEncryptedFile => 'Sélectionner le fichier chiffré';

  @override
  String get selectDestinationFolderTooltip =>
      'Sélectionner le dossier de destination';

  @override
  String get execute => 'Exécuter';

  @override
  String get decrypting => 'Déchiffrement...';

  @override
  String get close => 'Fermer';

  @override
  String get decryptAnother => 'Déchiffrer un Autre';

  @override
  String get startingDecryption => 'Démarrage du déchiffrement...';

  @override
  String get preparingDecryption => 'Préparation du déchiffrement...';

  @override
  String get decryptingFile => 'Déchiffrement du fichier...';

  @override
  String get extractingContent => 'Extraction du contenu...';

  @override
  String get finalizing => 'Finalisation...';

  @override
  String decryptedSuccessfully(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count fichiers extraits.',
      one: '1 fichier extrait.',
    );
    return 'Déchiffré avec succès ! $_temp0';
  }

  @override
  String errorSelectingFile(String error) {
    return 'Erreur lors de la sélection du fichier : $error';
  }

  @override
  String errorSelectingDestination(String error) {
    return 'Erreur lors de la sélection de la destination : $error';
  }

  @override
  String get verifyDiskTitle => 'Vérifier le Disque';

  @override
  String get selectDiskToVerify =>
      'Sélectionnez un disque pour vérifier son intégrité';

  @override
  String verifying(String diskName) {
    return 'Vérification : $diskName';
  }

  @override
  String get backToSelection => 'Retour à la sélection';

  @override
  String get loadingDisks => 'Chargement des disques...';

  @override
  String errorLoadingDisks(String error) {
    return 'Erreur lors du chargement des disques : $error';
  }

  @override
  String get tryAgain => 'Réessayer';

  @override
  String get noDisksFound => 'Aucun disque trouvé';

  @override
  String freeSpace(String size) {
    return '$size libres';
  }

  @override
  String get diskSpaceUnavailable => 'Informations d\'espace indisponibles';

  @override
  String get internalStorage => 'Stockage Interne';

  @override
  String get sdCard => 'Carte SD';

  @override
  String get externalSdCard => 'Carte SD Externe';

  @override
  String get primaryStorage => 'Stockage Principal';

  @override
  String get externalStorage => 'Stockage Externe';

  @override
  String get deviceStorage => 'Stockage de l\'Appareil';

  @override
  String get appStorage => 'Stockage de l\'Application';

  @override
  String get testsToRun => 'Tests qui seront exécutés :';

  @override
  String get testResults => 'Résultats des Tests';

  @override
  String get verificationInProgress => 'Vérification en cours...';

  @override
  String get diskVerifiedNoProblems => 'Disque vérifié - Aucun problème trouvé';

  @override
  String get verificationCompletedWithWarnings =>
      'Vérification terminée avec des avertissements';

  @override
  String get problemsDetected => 'Problèmes détectés sur le disque';

  @override
  String get waiting => 'En attente...';

  @override
  String totalTime(String duration) {
    return 'Temps total : $duration';
  }

  @override
  String get mountPoint => 'Point de montage';

  @override
  String get device => 'Périphérique';

  @override
  String get fileSystem => 'Système de fichiers';

  @override
  String get totalCapacity => 'Capacité totale';

  @override
  String get availableSpaceLabel => 'Espace disponible';

  @override
  String get mediaType => 'Type de média';

  @override
  String get type => 'Type';

  @override
  String get removable => 'Amovible';

  @override
  String get internal => 'Interne';

  @override
  String get startVerification => 'Démarrer la Vérification';

  @override
  String get verifyAgain => 'Vérifier à Nouveau';

  @override
  String get testAccessibilityCheck => 'Vérification d\'Accessibilité';

  @override
  String get testSpaceAnalysis => 'Analyse de l\'Espace Disque';

  @override
  String get testReadTest => 'Test de Lecture';

  @override
  String get testFileSystemCheck => 'Vérification du Système de Fichiers';

  @override
  String get testSmartStatus => 'État S.M.A.R.T.';

  @override
  String get language => 'Langue';

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
  String get scheduleTypeManual => 'Manuel';

  @override
  String get scheduleTypeDaily => 'Quotidien';

  @override
  String get scheduleTypeWeekly => 'Hebdomadaire';

  @override
  String get scheduleTypeInterval => 'Intervalle';

  @override
  String get backupName => 'Nom';

  @override
  String get backupSource => 'Sources';

  @override
  String get backupCompression => 'Compression';

  @override
  String get backupEncryption => 'Chiffrement';

  @override
  String get encryptionActive => 'Actif';

  @override
  String get noRoutinesConfigured => 'Aucune routine configurée';

  @override
  String nextBackupFormat(String routineName, String time) {
    return 'Suivant : \"$routineName\" $time';
  }

  @override
  String diskSpaceSufficient(String margin) {
    return 'Espace suffisant ! Marge de $margin% disponible.';
  }

  @override
  String diskSpaceInsufficient(String deficit) {
    return 'Espace insuffisant ! Il manque $deficit sur le disque de destination.';
  }

  @override
  String get dateToday => 'aujourd\'hui';

  @override
  String get dateTomorrow => 'demain';

  @override
  String get weekdayMonday => 'lun';

  @override
  String get weekdayTuesday => 'mar';

  @override
  String get weekdayWednesday => 'mer';

  @override
  String get weekdayThursday => 'jeu';

  @override
  String get weekdayFriday => 'ven';

  @override
  String get weekdaySaturday => 'sam';

  @override
  String get weekdaySunday => 'dim';

  @override
  String get about => 'À propos';

  @override
  String get aboutTitle => 'À propos de ShadowSync';

  @override
  String get version => 'Version';

  @override
  String get developer => 'Développeur';

  @override
  String get visitWebsite => 'Visiter le site web';
}
