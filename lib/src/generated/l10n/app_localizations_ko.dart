// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'ShadowSync';

  @override
  String get appSubtitle => '백업 관리자';

  @override
  String get myRoutines => '내 루틴';

  @override
  String get verifyDisk => '디스크 확인';

  @override
  String get decrypt => '복호화';

  @override
  String get settings => '설정';

  @override
  String startingBackup(String routineName) {
    return '\"$routineName\" 백업 시작 중...';
  }

  @override
  String get deleteRoutine => '루틴 삭제';

  @override
  String deleteRoutineConfirm(String routineName) {
    return '\"$routineName\" 루틴을 삭제하시겠습니까? 이 작업은 취소할 수 없습니다.';
  }

  @override
  String get cancel => '취소';

  @override
  String get delete => '삭제';

  @override
  String get noRoutines => '구성된 루틴이 없습니다';

  @override
  String get noScheduledBackups => '예정된 백업이 없습니다';

  @override
  String get serviceActive => '서비스 활성';

  @override
  String nextBackup(String name, String time) {
    return '다음: \"$name\" $time';
  }

  @override
  String get today => '오늘';

  @override
  String get tomorrow => '내일';

  @override
  String get monday => '월';

  @override
  String get tuesday => '화';

  @override
  String get wednesday => '수';

  @override
  String get thursday => '목';

  @override
  String get friday => '금';

  @override
  String get saturday => '토';

  @override
  String get sunday => '일';

  @override
  String get newBackup => '새 백업';

  @override
  String get runBackup => '백업 실행';

  @override
  String get deleteRoutineTooltip => '루틴 삭제';

  @override
  String get manualExecution => '수동 실행';

  @override
  String get noScheduleAvailable => '예약되지 않음';

  @override
  String scheduledDaily(String time) {
    return '예약됨: 매일 $time';
  }

  @override
  String scheduledWeekly(String date) {
    return '예약됨: 매주 • $date';
  }

  @override
  String scheduledInterval(String interval) {
    return '예약됨: $interval마다';
  }

  @override
  String get mode => '모드: ';

  @override
  String get next => '다음: ';

  @override
  String get last => '마지막: ';

  @override
  String get lastBackupLabel => '마지막 백업: ';

  @override
  String fileCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '파일 $count개',
      one: '파일 1개',
    );
    return '$_temp0';
  }

  @override
  String extractedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '추출 $count개',
      one: '추출 1개',
    );
    return '$_temp0';
  }

  @override
  String get general => '일반';

  @override
  String get telegram => 'Telegram';

  @override
  String get email => '이메일';

  @override
  String get userName => '사용자 이름';

  @override
  String get enterYourName => '이름을 입력하세요';

  @override
  String get encryptionPassword => '암호화 비밀번호';

  @override
  String get encryptionPasswordHint => '암호화된 백업을 보호하는 데 사용됩니다';

  @override
  String get enterPassword => '비밀번호를 입력하세요';

  @override
  String get backupFileName => '백업 파일 이름';

  @override
  String get useCustomName => '사용자 정의 이름 사용';

  @override
  String get customName => '사용자 정의 이름';

  @override
  String get telegramNotifications => 'Telegram 알림';

  @override
  String get telegramDescription => 'Telegram을 통해 백업 알림을 받으세요';

  @override
  String get enableNotifications => '알림 활성화';

  @override
  String get botToken => '봇 토큰';

  @override
  String get botTokenHint => 'Telegram에서 @BotFather로 봇을 생성하세요';

  @override
  String get botTokenExample => '123456789:ABCdefGHI...';

  @override
  String get chatId => '채팅 ID';

  @override
  String get chatIdHint => '봇에 /start를 보내고 @userinfobot을 사용하여 ID를 받으세요';

  @override
  String get chatIdExample => '채팅 ID (예: 123456789)';

  @override
  String get whenNotify => '알림 시기';

  @override
  String get backupSuccess => '백업 성공';

  @override
  String get backupFailed => '백업 실패';

  @override
  String get backupStarted => '백업 시작';

  @override
  String get sending => '전송 중...';

  @override
  String get sendTest => '테스트 전송';

  @override
  String get emailNotifications => '이메일 알림';

  @override
  String get emailDescription => '이메일을 통해 백업 알림을 받으세요';

  @override
  String get emailProvider => '이메일 제공업체';

  @override
  String get emailProviderHint => '제공업체를 선택하거나 수동으로 구성하세요';

  @override
  String get selectProvider => '제공업체 선택';

  @override
  String get smtpServer => 'SMTP 서버';

  @override
  String get smtpServerExample => '예: smtp.gmail.com';

  @override
  String get smtpServerPlaceholder => 'smtp.example.com';

  @override
  String get smtpPort => 'SMTP 포트';

  @override
  String get smtpPortHint => 'TLS의 경우 587, SSL의 경우 465';

  @override
  String get smtpPortPlaceholder => '587';

  @override
  String get yourEmail => '이메일';

  @override
  String get yourEmailHint => '알림을 보내는 데 사용될 이메일';

  @override
  String get yourEmailPlaceholder => 'youremail@gmail.com';

  @override
  String get emailPassword => '비밀번호 또는 앱 비밀번호';

  @override
  String get emailPasswordHint => '2단계 인증이 있는 경우 앱 비밀번호를 사용하세요';

  @override
  String get emailPasswordPlaceholder => '비밀번호 또는 앱 비밀번호';

  @override
  String get destinationEmails => '수신 이메일';

  @override
  String get destinationEmailsHint => '여러 이메일은 쉼표로 구분하세요';

  @override
  String get destinationEmailsPlaceholder =>
      'email1@example.com, email2@example.com';

  @override
  String get security => '보안';

  @override
  String get useStartTls => 'STARTTLS 사용 (권장)';

  @override
  String get useSsl => 'SSL 사용';

  @override
  String get save => '저장';

  @override
  String get fillBotTokenAndChatId => '테스트를 보내려면 봇 토큰과 채팅 ID를 입력하세요';

  @override
  String get testMessageSent => '테스트 메시지가 성공적으로 전송되었습니다!';

  @override
  String errorWithMessage(String message) {
    return '오류: $message';
  }

  @override
  String get fillAllFields => '모든 필수 필드를 입력하세요';

  @override
  String get enterAtLeastOneEmail => '하나 이상의 수신 이메일을 입력하세요';

  @override
  String get testEmailSent => '테스트 이메일이 성공적으로 전송되었습니다!';

  @override
  String get basicData => '기본 데이터';

  @override
  String get scheduling => '일정';

  @override
  String get processing => '처리';

  @override
  String get review => '검토';

  @override
  String get nextStep => '다음';

  @override
  String get saveRoutine => '루틴 저장';

  @override
  String get back => '뒤로';

  @override
  String get routineName => '루틴 이름';

  @override
  String get backupSources => '백업 소스';

  @override
  String get selectFilesAndFolders => '파일 및/또는 폴더를 선택할 수 있습니다.';

  @override
  String get sourcePathsExample =>
      '/Users/myuser/Documents;/Users/myuser/Projects';

  @override
  String get addSource => '소스 추가';

  @override
  String get selecting => '선택 중...';

  @override
  String get selectFiles => '파일 선택';

  @override
  String get selectFolder => '폴더 선택';

  @override
  String get backupDestination => '백업 대상';

  @override
  String get destinationDescription => '파일을 저장할 폴더를 선택하세요.';

  @override
  String get destinationExample => '/Volumes/Backup/Destination';

  @override
  String get selectDestinationFolder => '대상 폴더 선택';

  @override
  String get frequency => '빈도';

  @override
  String get manual => '수동';

  @override
  String get daily => '매일';

  @override
  String get weekly => '매주';

  @override
  String get interval => '간격';

  @override
  String get runAt => '실행 시간:';

  @override
  String get runEvery => '실행 주기:';

  @override
  String get manualExecutionInfo => '카드의 재생 버튼을 누르면 수동으로 백업이 실행됩니다.';

  @override
  String get oneMinute => '1분';

  @override
  String nMinutes(int n) {
    return '$n분';
  }

  @override
  String get oneHour => '1시간';

  @override
  String nHours(int n) {
    return '$n시간';
  }

  @override
  String get oneDay => '1일';

  @override
  String nDays(int n) {
    return '$n일';
  }

  @override
  String get compressBackup => '백업 압축';

  @override
  String get compressionFormat => '압축 형식';

  @override
  String get encryptBackup => '백업 암호화';

  @override
  String get name => '이름';

  @override
  String get sources => '소스';

  @override
  String get destination => '대상';

  @override
  String get schedule => '예약';

  @override
  String get compression => '압축';

  @override
  String activeWithFormat(String format) {
    return '활성 ($format)';
  }

  @override
  String get deactivated => '비활성';

  @override
  String get encryption => '암호화';

  @override
  String get active => '활성';

  @override
  String get diskSpace => '디스크 공간';

  @override
  String get calculatingSizes => '크기 계산 중...';

  @override
  String get sourceSize => '소스 크기';

  @override
  String get notAvailable => '사용할 수 없음';

  @override
  String get availableSpace => '대상의 사용 가능한 공간';

  @override
  String get retention => '보존 기간 (버전 수)';

  @override
  String sufficientSpace(String percent) {
    return '충분한 공간! $percent% 여유 공간이 있습니다.';
  }

  @override
  String insufficientSpace(String size) {
    return '공간 부족! 대상 디스크에 $size가 부족합니다.';
  }

  @override
  String get fileSelectionCancelled => '파일 선택이 취소되었습니다.';

  @override
  String filesAdded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '소스에 파일 $count개가 추가되었습니다.',
      one: '소스에 파일 1개가 추가되었습니다.',
    );
    return '$_temp0';
  }

  @override
  String failedToSelectFiles(String error) {
    return '파일 선택 실패: $error';
  }

  @override
  String get folderSelectionCancelled => '소스 폴더 선택이 취소되었습니다.';

  @override
  String get sourceFolderSelected => '소스 폴더가 선택되었습니다.';

  @override
  String failedToSelectSourceFolder(String error) {
    return '소스 폴더 선택 실패: $error';
  }

  @override
  String get iosSaveLocation => 'iOS에서는 백업이 Documents/Backups에 저장됩니다';

  @override
  String get destinationSelectionCancelled => '대상 폴더 선택이 취소되었습니다.';

  @override
  String get destinationFolderSelected => '대상 폴더가 선택되었습니다.';

  @override
  String failedToSelectDestination(String error) {
    return '대상 폴더 선택 실패: $error';
  }

  @override
  String get enterRoutineName => '루틴 이름을 입력하세요.';

  @override
  String get enterAtLeastOneSource => '하나 이상의 소스를 입력하세요.';

  @override
  String get enterDestinationPath => '대상 경로를 입력하세요.';

  @override
  String get retentionMustBePositive => '보존 기간은 0보다 큰 숫자여야 합니다.';

  @override
  String get configureEncryptionPassword =>
      '암호화를 활성화하기 전에 설정에서 암호화 비밀번호를 설정하세요.';

  @override
  String get decryptFile => '파일 복호화';

  @override
  String get decryptionDescription => 'ShadowSync로 보호된 파일을 복호화합니다';

  @override
  String get encryptedFile => '암호화된 파일';

  @override
  String get selectFileEllipsis => '파일 선택...';

  @override
  String get destinationFolder => '대상 폴더';

  @override
  String get selectFolderEllipsis => '폴더 선택...';

  @override
  String get outputFileName => '출력 파일 이름:';

  @override
  String get decryptionPassword => '복호화 비밀번호:';

  @override
  String get enterEncryptionPassword => '암호화에 사용된 비밀번호를 입력하세요';

  @override
  String get selectEncryptedFile => '암호화된 파일 선택';

  @override
  String get selectDestinationFolderTooltip => '대상 폴더 선택';

  @override
  String get execute => '실행';

  @override
  String get decrypting => '복호화 중...';

  @override
  String get close => '닫기';

  @override
  String get decryptAnother => '다른 파일 복호화';

  @override
  String get startingDecryption => '복호화 시작 중...';

  @override
  String get preparingDecryption => '복호화 준비 중...';

  @override
  String get decryptingFile => '파일 복호화 중...';

  @override
  String get extractingContent => '내용 추출 중...';

  @override
  String get finalizing => '완료 중...';

  @override
  String decryptedSuccessfully(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '파일 $count개가 추출되었습니다.',
      one: '파일 1개가 추출되었습니다.',
    );
    return '복호화 성공! $_temp0';
  }

  @override
  String errorSelectingFile(String error) {
    return '파일 선택 오류: $error';
  }

  @override
  String errorSelectingDestination(String error) {
    return '대상 선택 오류: $error';
  }

  @override
  String get verifyDiskTitle => '디스크 확인';

  @override
  String get selectDiskToVerify => '무결성을 확인할 디스크를 선택하세요';

  @override
  String verifying(String diskName) {
    return '확인 중: $diskName';
  }

  @override
  String get backToSelection => '선택으로 돌아가기';

  @override
  String get loadingDisks => '디스크 로드 중...';

  @override
  String errorLoadingDisks(String error) {
    return '디스크 로드 오류: $error';
  }

  @override
  String get tryAgain => '다시 시도';

  @override
  String get noDisksFound => '디스크를 찾을 수 없습니다';

  @override
  String freeSpace(String size) {
    return '$size 여유 공간';
  }

  @override
  String get diskSpaceUnavailable => '저장소 정보 없음';

  @override
  String get internalStorage => '내부 저장소';

  @override
  String get sdCard => 'SD 카드';

  @override
  String get externalSdCard => '외부 SD 카드';

  @override
  String get primaryStorage => '기본 저장소';

  @override
  String get externalStorage => '외부 저장소';

  @override
  String get deviceStorage => '기기 저장소';

  @override
  String get appStorage => '앱 저장소';

  @override
  String get testsToRun => '실행할 테스트:';

  @override
  String get testResults => '테스트 결과';

  @override
  String get verificationInProgress => '확인 진행 중...';

  @override
  String get diskVerifiedNoProblems => '디스크 확인 완료 - 문제가 발견되지 않았습니다';

  @override
  String get verificationCompletedWithWarnings => '경고와 함께 확인 완료';

  @override
  String get problemsDetected => '디스크에서 문제가 감지되었습니다';

  @override
  String get waiting => '대기 중...';

  @override
  String totalTime(String duration) {
    return '총 시간: $duration';
  }

  @override
  String get mountPoint => '마운트 지점';

  @override
  String get device => '장치';

  @override
  String get fileSystem => '파일 시스템';

  @override
  String get totalCapacity => '총 용량';

  @override
  String get availableSpaceLabel => '사용 가능한 공간';

  @override
  String get mediaType => '미디어 유형';

  @override
  String get type => '유형';

  @override
  String get removable => '탈착식';

  @override
  String get internal => '내장';

  @override
  String get startVerification => '확인 시작';

  @override
  String get verifyAgain => '다시 확인';

  @override
  String get testAccessibilityCheck => '접근성 확인';

  @override
  String get testSpaceAnalysis => '디스크 공간 분석';

  @override
  String get testReadTest => '읽기 테스트';

  @override
  String get testFileSystemCheck => '파일 시스템 확인';

  @override
  String get testSmartStatus => 'S.M.A.R.T. 상태';

  @override
  String get language => '언어';

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
  String get scheduleTypeManual => '수동';

  @override
  String get scheduleTypeDaily => '매일';

  @override
  String get scheduleTypeWeekly => '매주';

  @override
  String get scheduleTypeInterval => '간격';

  @override
  String get backupName => '이름';

  @override
  String get backupSource => '원본';

  @override
  String get backupCompression => '압축';

  @override
  String get backupEncryption => '암호화';

  @override
  String get encryptionActive => '활성화됨';

  @override
  String get noRoutinesConfigured => '구성된 루팁이 없습니다';

  @override
  String nextBackupFormat(String routineName, String time) {
    return '다음: \"$routineName\" $time';
  }

  @override
  String diskSpaceSufficient(String margin) {
    return '충분한 공간! $margin% 여유 사용 가능.';
  }

  @override
  String diskSpaceInsufficient(String deficit) {
    return '공간 부족! 대상 디스크에 $deficit가 부족합니다.';
  }

  @override
  String get dateToday => '오늘';

  @override
  String get dateTomorrow => '내일';

  @override
  String get weekdayMonday => '월';

  @override
  String get weekdayTuesday => '화';

  @override
  String get weekdayWednesday => '수';

  @override
  String get weekdayThursday => '목';

  @override
  String get weekdayFriday => '금';

  @override
  String get weekdaySaturday => '토';

  @override
  String get weekdaySunday => '일';

  @override
  String get about => '정보';

  @override
  String get aboutTitle => 'ShadowSync 정보';

  @override
  String get version => '버전';

  @override
  String get developer => '개발자';

  @override
  String get visitWebsite => '웹사이트 방문';
}
