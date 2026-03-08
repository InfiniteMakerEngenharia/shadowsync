// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'ShadowSync';

  @override
  String get appSubtitle => 'Gestor de Copias de Seguridad';

  @override
  String get myRoutines => 'Mis Rutinas';

  @override
  String get verifyDisk => 'Verificar Disco';

  @override
  String get decrypt => 'Descifrar';

  @override
  String get settings => 'Configuración';

  @override
  String startingBackup(String routineName) {
    return 'Iniciando copia de seguridad \"$routineName\"...';
  }

  @override
  String get deleteRoutine => 'Eliminar rutina';

  @override
  String deleteRoutineConfirm(String routineName) {
    return '¿Realmente desea eliminar la rutina \"$routineName\"? Esta acción no se puede deshacer.';
  }

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String get noRoutines => 'Ninguna rutina configurada';

  @override
  String get noScheduledBackups => 'Sin copias de seguridad programadas';

  @override
  String get serviceActive => 'Servicio activo';

  @override
  String nextBackup(String name, String time) {
    return 'Próxima: \"$name\" $time';
  }

  @override
  String get today => 'hoy';

  @override
  String get tomorrow => 'mañana';

  @override
  String get monday => 'lun';

  @override
  String get tuesday => 'mar';

  @override
  String get wednesday => 'mié';

  @override
  String get thursday => 'jue';

  @override
  String get friday => 'vie';

  @override
  String get saturday => 'sáb';

  @override
  String get sunday => 'dom';

  @override
  String get newBackup => 'Nueva Copia de Seguridad';

  @override
  String get runBackup => 'Ejecutar copia de seguridad';

  @override
  String get deleteRoutineTooltip => 'Eliminar rutina';

  @override
  String get manualExecution => 'Ejecución manual';

  @override
  String get noScheduleAvailable => 'No programada';

  @override
  String scheduledDaily(String time) {
    return 'Programada: Diariamente a las $time';
  }

  @override
  String scheduledWeekly(String date) {
    return 'Programada: Semanalmente • $date';
  }

  @override
  String scheduledInterval(String interval) {
    return 'Programada: Cada $interval';
  }

  @override
  String get mode => 'Modo: ';

  @override
  String get next => 'Próxima: ';

  @override
  String get last => 'Última: ';

  @override
  String get lastBackupLabel => 'Última copia de seguridad: ';

  @override
  String fileCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count archivos',
      one: '1 archivo',
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
  String get general => 'General';

  @override
  String get telegram => 'Telegram';

  @override
  String get email => 'Email';

  @override
  String get userName => 'Nombre de Usuario';

  @override
  String get enterYourName => 'Ingrese su nombre';

  @override
  String get encryptionPassword => 'Contraseña de Cifrado';

  @override
  String get encryptionPasswordHint =>
      'Usada para proteger sus copias de seguridad cifradas';

  @override
  String get enterPassword => 'Ingrese la contraseña';

  @override
  String get backupFileName => 'Nombre del Archivo de Copia de Seguridad';

  @override
  String get useCustomName => 'Usar nombre personalizado';

  @override
  String get customName => 'Nombre personalizado';

  @override
  String get telegramNotifications => 'Notificaciones vía Telegram';

  @override
  String get telegramDescription =>
      'Reciba alertas sobre sus copias de seguridad por Telegram';

  @override
  String get enableNotifications => 'Habilitar notificaciones';

  @override
  String get botToken => 'Bot Token';

  @override
  String get botTokenHint => 'Cree un bot con @BotFather en Telegram';

  @override
  String get botTokenExample => '123456789:ABCdefGHI...';

  @override
  String get chatId => 'Chat ID';

  @override
  String get chatIdHint =>
      'Envíe /start al bot y use @userinfobot para obtener';

  @override
  String get chatIdExample => 'Su Chat ID (ej: 123456789)';

  @override
  String get whenNotify => 'Cuándo Notificar';

  @override
  String get backupSuccess => 'Copia de seguridad completada con éxito';

  @override
  String get backupFailed => 'Copia de seguridad falló';

  @override
  String get backupStarted => 'Copia de seguridad iniciada';

  @override
  String get sending => 'Enviando...';

  @override
  String get sendTest => 'Enviar Prueba';

  @override
  String get emailNotifications => 'Notificaciones vía Email';

  @override
  String get emailDescription =>
      'Reciba alertas sobre sus copias de seguridad por email';

  @override
  String get emailProvider => 'Proveedor de Email';

  @override
  String get emailProviderHint =>
      'Seleccione su proveedor o configure manualmente';

  @override
  String get selectProvider => 'Seleccione un proveedor';

  @override
  String get smtpServer => 'Servidor SMTP';

  @override
  String get smtpServerExample => 'Ej: smtp.gmail.com';

  @override
  String get smtpServerPlaceholder => 'smtp.example.com';

  @override
  String get smtpPort => 'Puerto SMTP';

  @override
  String get smtpPortHint => '587 para TLS, 465 para SSL';

  @override
  String get smtpPortPlaceholder => '587';

  @override
  String get yourEmail => 'Su Email';

  @override
  String get yourEmailHint => 'Email que será usado para enviar notificaciones';

  @override
  String get yourEmailPlaceholder => 'suemail@gmail.com';

  @override
  String get emailPassword => 'Contraseña o App Password';

  @override
  String get emailPasswordHint =>
      'Use App Password si tiene autenticación en 2 pasos';

  @override
  String get emailPasswordPlaceholder => 'Su contraseña o App Password';

  @override
  String get destinationEmails => 'Emails de Destino';

  @override
  String get destinationEmailsHint => 'Separe múltiples emails por coma';

  @override
  String get destinationEmailsPlaceholder =>
      'email1@ejemplo.com, email2@ejemplo.com';

  @override
  String get security => 'Seguridad';

  @override
  String get useStartTls => 'Usar STARTTLS (recomendado)';

  @override
  String get useSsl => 'Usar SSL';

  @override
  String get save => 'Guardar';

  @override
  String get fillBotTokenAndChatId =>
      'Complete el Bot Token y el Chat ID para enviar prueba';

  @override
  String get testMessageSent => '¡Mensaje de prueba enviado con éxito!';

  @override
  String errorWithMessage(String message) {
    return 'Error: $message';
  }

  @override
  String get fillAllFields => 'Complete todos los campos obligatorios';

  @override
  String get enterAtLeastOneEmail => 'Ingrese al menos un email de destino';

  @override
  String get testEmailSent => '¡Email de prueba enviado con éxito!';

  @override
  String get basicData => 'Datos básicos';

  @override
  String get scheduling => 'Programación';

  @override
  String get processing => 'Procesamiento';

  @override
  String get review => 'Revisión';

  @override
  String get nextStep => 'Siguiente';

  @override
  String get saveRoutine => 'Guardar Rutina';

  @override
  String get back => 'Volver';

  @override
  String get routineName => 'Nombre de la rutina';

  @override
  String get backupSources => 'Orígenes de la Copia de Seguridad';

  @override
  String get selectFilesAndFolders =>
      'Puede seleccionar archivos y/o carpetas.';

  @override
  String get sourcePathsExample =>
      '/Users/miusuario/Documents;/Users/miusuario/Proyectos';

  @override
  String get addSource => 'Agregar Origen';

  @override
  String get selecting => 'Seleccionando...';

  @override
  String get selectFiles => 'Seleccionar Archivo(s)';

  @override
  String get selectFolder => 'Seleccionar Carpeta';

  @override
  String get backupDestination => 'Destino de la Copia de Seguridad';

  @override
  String get destinationDescription =>
      'Elija la carpeta donde se guardarán los archivos.';

  @override
  String get destinationExample => '/Volumes/Backup/Destino';

  @override
  String get selectDestinationFolder => 'Seleccionar Carpeta de Destino';

  @override
  String get frequency => 'Frecuencia';

  @override
  String get manual => 'Manual';

  @override
  String get daily => 'Diaria';

  @override
  String get weekly => 'Semanal';

  @override
  String get interval => 'Intervalo';

  @override
  String get runAt => 'Ejecutar a las:';

  @override
  String get runEvery => 'Ejecutar cada:';

  @override
  String get manualExecutionInfo =>
      'La copia de seguridad se ejecutará manualmente cuando presione el botón play en la tarjeta.';

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
  String get oneDay => '1 día';

  @override
  String nDays(int n) {
    return '$n días';
  }

  @override
  String get compressBackup => 'Comprimir copia de seguridad';

  @override
  String get compressionFormat => 'Formato de compresión';

  @override
  String get encryptBackup => 'Cifrar copia de seguridad';

  @override
  String get name => 'Nombre';

  @override
  String get sources => 'Orígenes';

  @override
  String get destination => 'Destino';

  @override
  String get schedule => 'Programación';

  @override
  String get compression => 'Compresión';

  @override
  String activeWithFormat(String format) {
    return 'Activa ($format)';
  }

  @override
  String get deactivated => 'Desactivada';

  @override
  String get encryption => 'Cifrado';

  @override
  String get active => 'Activa';

  @override
  String get diskSpace => 'Espacio en Disco';

  @override
  String get calculatingSizes => 'Calculando tamaños...';

  @override
  String get sourceSize => 'Tamaño del origen';

  @override
  String get notAvailable => 'No disponible';

  @override
  String get availableSpace => 'Espacio disponible en el destino';

  @override
  String get retention => 'Retención (cantidad de versiones)';

  @override
  String sufficientSpace(String percent) {
    return '¡Espacio suficiente! Margen de $percent% disponible.';
  }

  @override
  String insufficientSpace(String size) {
    return '¡Espacio insuficiente! Faltan $size en el disco de destino.';
  }

  @override
  String get fileSelectionCancelled => 'Selección de archivos cancelada.';

  @override
  String filesAdded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count archivos agregados al origen.',
      one: '1 archivo agregado al origen.',
    );
    return '$_temp0';
  }

  @override
  String failedToSelectFiles(String error) {
    return 'Error al seleccionar archivos: $error';
  }

  @override
  String get folderSelectionCancelled =>
      'Selección de carpeta de origen cancelada.';

  @override
  String get sourceFolderSelected => 'Carpeta de origen seleccionada.';

  @override
  String failedToSelectSourceFolder(String error) {
    return 'Error al seleccionar carpeta de origen: $error';
  }

  @override
  String get iosSaveLocation =>
      'En iOS, las copias de seguridad se guardarán en: Documentos/Backups';

  @override
  String get destinationSelectionCancelled =>
      'Selección de carpeta de destino cancelada.';

  @override
  String get destinationFolderSelected => 'Carpeta de destino seleccionada.';

  @override
  String failedToSelectDestination(String error) {
    return 'Error al seleccionar carpeta de destino: $error';
  }

  @override
  String get enterRoutineName => 'Ingrese el nombre de la rutina.';

  @override
  String get enterAtLeastOneSource => 'Ingrese al menos un origen.';

  @override
  String get enterDestinationPath => 'Ingrese la ruta de destino.';

  @override
  String get retentionMustBePositive =>
      'La retención debe ser un número mayor que cero.';

  @override
  String get configureEncryptionPassword =>
      'Configure una contraseña de cifrado en Configuración antes de habilitar el cifrado.';

  @override
  String get decryptFile => 'Descifrar Archivo';

  @override
  String get decryptionDescription =>
      'Descifre archivos protegidos por ShadowSync';

  @override
  String get encryptedFile => 'Archivo Cifrado';

  @override
  String get selectFileEllipsis => 'Seleccionar archivo...';

  @override
  String get destinationFolder => 'Carpeta de Destino';

  @override
  String get selectFolderEllipsis => 'Seleccionar carpeta...';

  @override
  String get outputFileName => 'Nombre del archivo de salida:';

  @override
  String get decryptionPassword => 'Contraseña de descifrado:';

  @override
  String get enterEncryptionPassword =>
      'Ingrese la contraseña usada en el cifrado';

  @override
  String get selectEncryptedFile => 'Seleccionar archivo cifrado';

  @override
  String get selectDestinationFolderTooltip => 'Seleccionar carpeta de destino';

  @override
  String get execute => 'Ejecutar';

  @override
  String get decrypting => 'Descifrando...';

  @override
  String get close => 'Cerrar';

  @override
  String get decryptAnother => 'Descifrar Otro';

  @override
  String get startingDecryption => 'Iniciando descifrado...';

  @override
  String get preparingDecryption => 'Preparando descifrado...';

  @override
  String get decryptingFile => 'Descifrando archivo...';

  @override
  String get extractingContent => 'Extrayendo contenido...';

  @override
  String get finalizing => 'Finalizando...';

  @override
  String decryptedSuccessfully(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count archivos extraídos.',
      one: '1 archivo extraído.',
    );
    return '¡Descifrado con éxito! $_temp0';
  }

  @override
  String errorSelectingFile(String error) {
    return 'Error al seleccionar archivo: $error';
  }

  @override
  String errorSelectingDestination(String error) {
    return 'Error al seleccionar destino: $error';
  }

  @override
  String get verifyDiskTitle => 'Verificar Disco';

  @override
  String get selectDiskToVerify =>
      'Seleccione un disco para verificar su integridad';

  @override
  String verifying(String diskName) {
    return 'Verificando: $diskName';
  }

  @override
  String get backToSelection => 'Volver a la selección';

  @override
  String get loadingDisks => 'Cargando discos...';

  @override
  String errorLoadingDisks(String error) {
    return 'Error al cargar discos: $error';
  }

  @override
  String get tryAgain => 'Intentar de nuevo';

  @override
  String get noDisksFound => 'No se encontraron discos';

  @override
  String freeSpace(String size) {
    return '$size libres';
  }

  @override
  String get diskSpaceUnavailable => 'Información de espacio no disponible';

  @override
  String get internalStorage => 'Almacenamiento Interno';

  @override
  String get sdCard => 'Tarjeta SD';

  @override
  String get externalSdCard => 'Tarjeta SD Externa';

  @override
  String get primaryStorage => 'Almacenamiento Principal';

  @override
  String get externalStorage => 'Almacenamiento Externo';

  @override
  String get deviceStorage => 'Almacenamiento del Dispositivo';

  @override
  String get appStorage => 'Almacenamiento de la Aplicación';

  @override
  String get testsToRun => 'Pruebas que se ejecutarán:';

  @override
  String get testResults => 'Resultados de las Pruebas';

  @override
  String get verificationInProgress => 'Verificación en curso...';

  @override
  String get diskVerifiedNoProblems =>
      'Disco verificado - No se encontraron problemas';

  @override
  String get verificationCompletedWithWarnings =>
      'Verificación completada con advertencias';

  @override
  String get problemsDetected => 'Problemas detectados en el disco';

  @override
  String get waiting => 'Esperando...';

  @override
  String totalTime(String duration) {
    return 'Tiempo total: $duration';
  }

  @override
  String get mountPoint => 'Punto de montaje';

  @override
  String get device => 'Dispositivo';

  @override
  String get fileSystem => 'Sistema de archivos';

  @override
  String get totalCapacity => 'Capacidad total';

  @override
  String get availableSpaceLabel => 'Espacio disponible';

  @override
  String get mediaType => 'Tipo de medio';

  @override
  String get type => 'Tipo';

  @override
  String get removable => 'Extraíble';

  @override
  String get internal => 'Interno';

  @override
  String get startVerification => 'Iniciar Verificación';

  @override
  String get verifyAgain => 'Verificar Nuevamente';

  @override
  String get testAccessibilityCheck => 'Verificación de Accesibilidad';

  @override
  String get testSpaceAnalysis => 'Análisis de Espacio en Disco';

  @override
  String get testReadTest => 'Prueba de Lectura';

  @override
  String get testFileSystemCheck => 'Verificación del Sistema de Archivos';

  @override
  String get testSmartStatus => 'Estado S.M.A.R.T.';

  @override
  String get fullDiskAccessRequired =>
      'Acceso denegado. En macOS, conceda \"Acceso Completo al Disco\" a ShadowSync en Ajustes del Sistema > Privacidad y Seguridad > Acceso Completo al Disco.';

  @override
  String get fileSystemCheckRequiresPrivileges =>
      'La verificación del sistema de archivos requiere acceso privilegiado del sistema. Use la aplicación \"Utilidad de Discos\" de macOS para verificar este volumen manualmente.';

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
  String get scheduleTypeDaily => 'Diario';

  @override
  String get scheduleTypeWeekly => 'Semanal';

  @override
  String get scheduleTypeInterval => 'Intervalo';

  @override
  String get backupName => 'Nombre';

  @override
  String get backupSource => 'Fuentes';

  @override
  String get backupCompression => 'Compresión';

  @override
  String get backupEncryption => 'Cifrado';

  @override
  String get encryptionActive => 'Activo';

  @override
  String get noRoutinesConfigured => 'Ninguna rutina configurada';

  @override
  String nextBackupFormat(String routineName, String time) {
    return 'Siguiente: \"$routineName\" $time';
  }

  @override
  String diskSpaceSufficient(String margin) {
    return '¡Espacio suficiente! $margin% de margen disponible.';
  }

  @override
  String diskSpaceInsufficient(String deficit) {
    return '¡Espacio insuficiente! Faltan $deficit en el disco de destino.';
  }

  @override
  String get dateToday => 'Hoy';

  @override
  String get dateTomorrow => 'Mañana';

  @override
  String get weekdayMonday => 'Lun';

  @override
  String get weekdayTuesday => 'Mar';

  @override
  String get weekdayWednesday => 'Mié';

  @override
  String get weekdayThursday => 'Jue';

  @override
  String get weekdayFriday => 'Vie';

  @override
  String get weekdaySaturday => 'Sáb';

  @override
  String get weekdaySunday => 'Dom';

  @override
  String get about => 'Acerca de';

  @override
  String get aboutTitle => 'Acerca de ShadowSync';

  @override
  String get version => 'Versión';

  @override
  String get developer => 'Desarrollador';

  @override
  String get visitWebsite => 'Visitar Sitio Web';
}
