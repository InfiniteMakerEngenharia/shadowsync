// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'ShadowSync';

  @override
  String get appSubtitle => 'バックアップマネージャー';

  @override
  String get myRoutines => 'マイルーチン';

  @override
  String get verifyDisk => 'ディスクを確認';

  @override
  String get decrypt => '復号化';

  @override
  String get settings => '設定';

  @override
  String startingBackup(String routineName) {
    return 'バックアップ\"$routineName\"を開始しています...';
  }

  @override
  String get deleteRoutine => 'ルーチンを削除';

  @override
  String deleteRoutineConfirm(String routineName) {
    return 'ルーチン\"$routineName\"を削除してもよろしいですか？この操作は元に戻せません。';
  }

  @override
  String get cancel => 'キャンセル';

  @override
  String get delete => '削除';

  @override
  String get noRoutines => 'ルーチンが設定されていません';

  @override
  String get noScheduledBackups => 'スケジュール済みのバックアップがあります';

  @override
  String get serviceActive => 'サービスがアクティブ';

  @override
  String nextBackup(String name, String time) {
    return '次回：\"$name\"$time';
  }

  @override
  String get today => '今日';

  @override
  String get tomorrow => '明日';

  @override
  String get monday => '月';

  @override
  String get tuesday => '火';

  @override
  String get wednesday => '水';

  @override
  String get thursday => '木';

  @override
  String get friday => '金';

  @override
  String get saturday => '土';

  @override
  String get sunday => '日';

  @override
  String get newBackup => '新規バックアップ';

  @override
  String get runBackup => 'バックアップを実行';

  @override
  String get deleteRoutineTooltip => 'ルーチンを削除';

  @override
  String get manualExecution => '手動実行';

  @override
  String get noScheduleAvailable => 'スケジュールなし';

  @override
  String scheduledDaily(String time) {
    return '予定：毎日 $time';
  }

  @override
  String scheduledWeekly(String date) {
    return '予定：毎週 • $date';
  }

  @override
  String scheduledInterval(String interval) {
    return '予定：$intervalごと';
  }

  @override
  String get mode => 'モード：';

  @override
  String get next => '次回：';

  @override
  String get last => '前回：';

  @override
  String get lastBackupLabel => '前回のバックアップ：';

  @override
  String fileCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countファイル',
      one: '1ファイル',
    );
    return '$_temp0';
  }

  @override
  String extractedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count個抽出済み',
      one: '1個抽出済み',
    );
    return '$_temp0';
  }

  @override
  String get general => '一般';

  @override
  String get telegram => 'Telegram';

  @override
  String get email => 'メール';

  @override
  String get userName => 'ユーザー名';

  @override
  String get enterYourName => '名前を入力';

  @override
  String get encryptionPassword => '暗号化パスワード';

  @override
  String get encryptionPasswordHint => '暗号化されたバックアップを保護するために使用されます';

  @override
  String get enterPassword => 'パスワードを入力';

  @override
  String get backupFileName => 'バックアップファイル名';

  @override
  String get useCustomName => 'カスタム名を使用';

  @override
  String get customName => 'カスタム名';

  @override
  String get telegramNotifications => 'Telegram通知';

  @override
  String get telegramDescription => 'Telegramでバックアップに関する通知を受け取る';

  @override
  String get enableNotifications => '通知を有効にする';

  @override
  String get botToken => 'ボットトークン';

  @override
  String get botTokenHint => 'Telegramで@BotFatherを使ってボットを作成';

  @override
  String get botTokenExample => '123456789:ABCdefGHI...';

  @override
  String get chatId => 'チャットID';

  @override
  String get chatIdHint => 'ボットに/startを送信し、@userinfobot を使って取得';

  @override
  String get chatIdExample => 'チャットID（例：123456789）';

  @override
  String get whenNotify => '通知のタイミング';

  @override
  String get backupSuccess => 'バックアップが正常に完了';

  @override
  String get backupFailed => 'バックアップが失敗';

  @override
  String get backupStarted => 'バックアップが開始';

  @override
  String get sending => '送信中...';

  @override
  String get sendTest => 'テスト送信';

  @override
  String get emailNotifications => 'メール通知';

  @override
  String get emailDescription => 'メールでバックアップに関する通知を受け取る';

  @override
  String get emailProvider => 'メールプロバイダー';

  @override
  String get emailProviderHint => 'プロバイダーを選択するか、手動で設定';

  @override
  String get selectProvider => 'プロバイダーを選択';

  @override
  String get smtpServer => 'SMTPサーバー';

  @override
  String get smtpServerExample => '例：smtp.gmail.com';

  @override
  String get smtpServerPlaceholder => 'smtp.example.com';

  @override
  String get smtpPort => 'SMTPポート';

  @override
  String get smtpPortHint => 'TLSは587、SSLは465';

  @override
  String get smtpPortPlaceholder => '587';

  @override
  String get yourEmail => 'メールアドレス';

  @override
  String get yourEmailHint => '通知の送信に使用するメール';

  @override
  String get yourEmailPlaceholder => 'yourmail@gmail.com';

  @override
  String get emailPassword => 'パスワードまたはアプリパスワード';

  @override
  String get emailPasswordHint => '2段階認証の場合はアプリパスワードを使用';

  @override
  String get emailPasswordPlaceholder => 'パスワードまたはアプリパスワード';

  @override
  String get destinationEmails => '宛先メール';

  @override
  String get destinationEmailsHint => '複数のメールはカンマで区切る';

  @override
  String get destinationEmailsPlaceholder =>
      'email1@example.com, email2@example.com';

  @override
  String get security => 'セキュリティ';

  @override
  String get useStartTls => 'STARTTLS を使用（推奨）';

  @override
  String get useSsl => 'SSL を使用';

  @override
  String get save => '保存';

  @override
  String get fillBotTokenAndChatId => 'テスト送信にはボットトークンとチャットIDを入力してください';

  @override
  String get testMessageSent => 'テストメッセージが正常に送信されました！';

  @override
  String errorWithMessage(String message) {
    return 'エラー：$message';
  }

  @override
  String get fillAllFields => 'すべての必須フィールドを入力してください';

  @override
  String get enterAtLeastOneEmail => '宛先メールを少なくとも1つ入力してください';

  @override
  String get testEmailSent => 'テストメールが正常に送信されました！';

  @override
  String get basicData => '基本データ';

  @override
  String get scheduling => 'スケジュール';

  @override
  String get processing => '処理';

  @override
  String get review => '確認';

  @override
  String get nextStep => '次へ';

  @override
  String get saveRoutine => 'ルーチンを保存';

  @override
  String get back => '戻る';

  @override
  String get routineName => 'ルーチン名';

  @override
  String get backupSources => 'バックアップ元';

  @override
  String get selectFilesAndFolders => 'ファイルやフォルダを選択できます。';

  @override
  String get sourcePathsExample =>
      '/Users/myuser/Documents;/Users/myuser/Projects';

  @override
  String get addSource => 'バックアップ元を追加';

  @override
  String get selecting => '選択中...';

  @override
  String get selectFiles => 'ファイルを選択';

  @override
  String get selectFolder => 'フォルダを選択';

  @override
  String get backupDestination => 'バックアップ先';

  @override
  String get destinationDescription => 'ファイルを保存するフォルダを選択してください。';

  @override
  String get destinationExample => '/Volumes/Backup/Destination';

  @override
  String get selectDestinationFolder => '保存先フォルダを選択';

  @override
  String get frequency => '頻度';

  @override
  String get manual => '手動';

  @override
  String get daily => '毎日';

  @override
  String get weekly => '毎週';

  @override
  String get interval => '間隔';

  @override
  String get runAt => '実行時刻：';

  @override
  String get runEvery => '実行間隔：';

  @override
  String get manualExecutionInfo => 'カードの再生ボタンを押すと手動で実行されます。';

  @override
  String get oneMinute => '1分';

  @override
  String nMinutes(int n) {
    return '$n分';
  }

  @override
  String get oneHour => '1時間';

  @override
  String nHours(int n) {
    return '$n時間';
  }

  @override
  String get oneDay => '1日';

  @override
  String nDays(int n) {
    return '$n日';
  }

  @override
  String get compressBackup => 'バックアップを圧縮';

  @override
  String get compressionFormat => '圧縮形式';

  @override
  String get encryptBackup => 'バックアップを暗号化';

  @override
  String get name => '名前';

  @override
  String get sources => 'バックアップ元';

  @override
  String get destination => '宛先';

  @override
  String get schedule => 'スケジュール';

  @override
  String get compression => '圧縮';

  @override
  String activeWithFormat(String format) {
    return '有効（$format）';
  }

  @override
  String get deactivated => '無効';

  @override
  String get encryption => '暗号化';

  @override
  String get active => '有効';

  @override
  String get diskSpace => 'ディスク容量';

  @override
  String get calculatingSizes => 'サイズを計算中...';

  @override
  String get sourceSize => 'バックアップ元のサイズ';

  @override
  String get notAvailable => '利用不可';

  @override
  String get availableSpace => '保存先の空き容量';

  @override
  String get retention => '保持（バージョン数）';

  @override
  String sufficientSpace(String percent) {
    return '十分な容量があります！$percent%の余裕があります。';
  }

  @override
  String insufficientSpace(String size) {
    return '容量不足！保存先に$size不足しています。';
  }

  @override
  String get fileSelectionCancelled => 'ファイル選択がキャンセルされました。';

  @override
  String filesAdded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countファイルがバックアップ元に追加されました。',
      one: '1ファイルがバックアップ元に追加されました。',
    );
    return '$_temp0';
  }

  @override
  String failedToSelectFiles(String error) {
    return 'ファイル選択に失敗しました：$error';
  }

  @override
  String get folderSelectionCancelled => 'バックアップ元フォルダの選択がキャンセルされました。';

  @override
  String get sourceFolderSelected => 'バックアップ元フォルダが選択されました。';

  @override
  String failedToSelectSourceFolder(String error) {
    return 'バックアップ元フォルダの選択に失敗しました：$error';
  }

  @override
  String get iosSaveLocation => 'iOSでは、バックアップは次の場所に保存されます：Documents/Backups';

  @override
  String get destinationSelectionCancelled => '保存先フォルダの選択がキャンセルされました。';

  @override
  String get destinationFolderSelected => '保存先フォルダが選択されました。';

  @override
  String failedToSelectDestination(String error) {
    return '保存先フォルダの選択に失敗しました：$error';
  }

  @override
  String get enterRoutineName => 'ルーチン名を入力してください。';

  @override
  String get enterAtLeastOneSource => 'バックアップ元を少なくとも1つ入力してください。';

  @override
  String get enterDestinationPath => '保存先パスを入力してください。';

  @override
  String get retentionMustBePositive => '保持数は0より大きい数値である必要があります。';

  @override
  String get configureEncryptionPassword => '暗号化を有効にする前に、設定で暗号化パスワードを設定してください。';

  @override
  String get decryptFile => 'ファイルを復号化';

  @override
  String get decryptionDescription => 'ShadowSyncで保護されたファイルを復号化';

  @override
  String get encryptedFile => '暗号化ファイル';

  @override
  String get selectFileEllipsis => 'ファイルを選択...';

  @override
  String get destinationFolder => '保存先フォルダ';

  @override
  String get selectFolderEllipsis => 'フォルダを選択...';

  @override
  String get outputFileName => '出力ファイル名：';

  @override
  String get decryptionPassword => '復号化パスワード：';

  @override
  String get enterEncryptionPassword => '暗号化時に使用したパスワードを入力';

  @override
  String get selectEncryptedFile => '暗号化ファイルを選択';

  @override
  String get selectDestinationFolderTooltip => '保存先フォルダを選択';

  @override
  String get execute => '実行';

  @override
  String get decrypting => '復号化中...';

  @override
  String get close => '閉じる';

  @override
  String get decryptAnother => '別のファイルを復号化';

  @override
  String get startingDecryption => '復号化を開始しています...';

  @override
  String get preparingDecryption => '復号化を準備中...';

  @override
  String get decryptingFile => 'ファイルを復号化中...';

  @override
  String get extractingContent => 'コンテンツを抽出中...';

  @override
  String get finalizing => '完了処理中...';

  @override
  String decryptedSuccessfully(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countファイルが抽出されました。',
      one: '1ファイルが抽出されました。',
    );
    return '復号化に成功しました！$_temp0';
  }

  @override
  String errorSelectingFile(String error) {
    return 'ファイル選択エラー：$error';
  }

  @override
  String errorSelectingDestination(String error) {
    return '保存先選択エラー：$error';
  }

  @override
  String get verifyDiskTitle => 'ディスクを確認';

  @override
  String get selectDiskToVerify => '整合性を確認するディスクを選択';

  @override
  String verifying(String diskName) {
    return '確認中：$diskName';
  }

  @override
  String get backToSelection => '選択に戻る';

  @override
  String get loadingDisks => 'ディスクを読み込み中...';

  @override
  String errorLoadingDisks(String error) {
    return 'ディスク読み込みエラー：$error';
  }

  @override
  String get tryAgain => '再試行';

  @override
  String get noDisksFound => 'ディスクが見つかりません';

  @override
  String freeSpace(String size) {
    return '$size空き';
  }

  @override
  String get diskSpaceUnavailable => '容量情報が利用不可能';

  @override
  String get internalStorage => '内部ストレージ';

  @override
  String get sdCard => 'SDカード';

  @override
  String get externalSdCard => '外部SDカード';

  @override
  String get primaryStorage => 'プライマリストレージ';

  @override
  String get externalStorage => '外部ストレージ';

  @override
  String get deviceStorage => 'デバイスストレージ';

  @override
  String get appStorage => 'アプリストレージ';

  @override
  String get testsToRun => '実行するテスト：';

  @override
  String get testResults => 'テスト結果';

  @override
  String get verificationInProgress => '確認実行中...';

  @override
  String get diskVerifiedNoProblems => 'ディスクを確認しました - 問題は見つかりませんでした';

  @override
  String get verificationCompletedWithWarnings => '確認が完了しました（警告あり）';

  @override
  String get problemsDetected => 'ディスクに問題が検出されました';

  @override
  String get waiting => '待機中...';

  @override
  String totalTime(String duration) {
    return '合計時間：$duration';
  }

  @override
  String get mountPoint => 'マウントポイント';

  @override
  String get device => 'デバイス';

  @override
  String get fileSystem => 'ファイルシステム';

  @override
  String get totalCapacity => '合計容量';

  @override
  String get availableSpaceLabel => '空き容量';

  @override
  String get mediaType => 'メディアタイプ';

  @override
  String get type => 'タイプ';

  @override
  String get removable => 'リムーバブル';

  @override
  String get internal => '内蔵';

  @override
  String get startVerification => '確認を開始';

  @override
  String get verifyAgain => '再確認';

  @override
  String get testAccessibilityCheck => 'アクセシビリティチェック';

  @override
  String get testSpaceAnalysis => 'ディスク容量分析';

  @override
  String get testReadTest => '読み込みテスト';

  @override
  String get testFileSystemCheck => 'ファイルシステムチェック';

  @override
  String get testSmartStatus => 'S.M.A.R.T. ステータス';

  @override
  String get language => '言語';

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
  String get scheduleTypeManual => '手動';

  @override
  String get scheduleTypeDaily => '日々';

  @override
  String get scheduleTypeWeekly => '週間';

  @override
  String get scheduleTypeInterval => '間隔';

  @override
  String get backupName => '名前';

  @override
  String get backupSource => 'ソース';

  @override
  String get backupCompression => '圧縮';

  @override
  String get backupEncryption => '暗号化';

  @override
  String get encryptionActive => '有効';

  @override
  String get noRoutinesConfigured => 'ルーチンが構成されていません';

  @override
  String nextBackupFormat(String routineName, String time) {
    return '次: \"$routineName\" $time';
  }

  @override
  String diskSpaceSufficient(String margin) {
    return '十分な空き容量! $margin% の余裕が利用可能。';
  }

  @override
  String diskSpaceInsufficient(String deficit) {
    return '空き容量が不足しています! 宛先ディスクに $deficit 必要です。';
  }

  @override
  String get dateToday => '今日';

  @override
  String get dateTomorrow => '明日';

  @override
  String get weekdayMonday => '月';

  @override
  String get weekdayTuesday => '火';

  @override
  String get weekdayWednesday => '水';

  @override
  String get weekdayThursday => '木';

  @override
  String get weekdayFriday => '金';

  @override
  String get weekdaySaturday => '土';

  @override
  String get weekdaySunday => '日';

  @override
  String get about => 'について';

  @override
  String get aboutTitle => 'ShadowSyncについて';

  @override
  String get version => 'バージョン';

  @override
  String get developer => '開発者';

  @override
  String get visitWebsite => 'ウェブサイトを訪問';
}
