// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'ShadowSync';

  @override
  String get appSubtitle => '备份管理器';

  @override
  String get myRoutines => '我的例程';

  @override
  String get verifyDisk => '验证磁盘';

  @override
  String get decrypt => '解密';

  @override
  String get settings => '设置';

  @override
  String startingBackup(String routineName) {
    return '正在启动备份\"$routineName\"...';
  }

  @override
  String get deleteRoutine => '删除例程';

  @override
  String deleteRoutineConfirm(String routineName) {
    return '确定要删除例程\"$routineName\"吗？此操作无法撤销。';
  }

  @override
  String get cancel => '取消';

  @override
  String get delete => '删除';

  @override
  String get noRoutines => '未配置例程';

  @override
  String get noScheduledBackups => '没有定时等候的备份';

  @override
  String get serviceActive => '服务何动';

  @override
  String nextBackup(String name, String time) {
    return '下一个：\"$name\" $time';
  }

  @override
  String get today => '今天';

  @override
  String get tomorrow => '明天';

  @override
  String get monday => '周一';

  @override
  String get tuesday => '周二';

  @override
  String get wednesday => '周三';

  @override
  String get thursday => '周四';

  @override
  String get friday => '周五';

  @override
  String get saturday => '周六';

  @override
  String get sunday => '周日';

  @override
  String get newBackup => '新建备份';

  @override
  String get runBackup => '运行备份';

  @override
  String get deleteRoutineTooltip => '删除例程';

  @override
  String get manualExecution => '手动执行';

  @override
  String get noScheduleAvailable => '未安排';

  @override
  String scheduledDaily(String time) {
    return '计划：每天 $time';
  }

  @override
  String scheduledWeekly(String date) {
    return '计划：每周 • $date';
  }

  @override
  String scheduledInterval(String interval) {
    return '计划：每 $interval';
  }

  @override
  String get mode => '模式：';

  @override
  String get next => '下一个：';

  @override
  String get last => '上一个：';

  @override
  String get lastBackupLabel => '上次備份：';

  @override
  String fileCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 个文件',
      one: '1 个文件',
    );
    return '$_temp0';
  }

  @override
  String extractedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '已提取 $count 个',
      one: '已提取 1 个',
    );
    return '$_temp0';
  }

  @override
  String get general => '常规';

  @override
  String get telegram => 'Telegram';

  @override
  String get email => '电子邮件';

  @override
  String get userName => '用户名';

  @override
  String get enterYourName => '输入您的姓名';

  @override
  String get encryptionPassword => '加密密码';

  @override
  String get encryptionPasswordHint => '用于保护您的加密备份';

  @override
  String get enterPassword => '输入密码';

  @override
  String get backupFileName => '备份文件名';

  @override
  String get useCustomName => '使用自定义名称';

  @override
  String get customName => '自定义名称';

  @override
  String get telegramNotifications => 'Telegram 通知';

  @override
  String get telegramDescription => '通过 Telegram 接收备份提醒';

  @override
  String get enableNotifications => '启用通知';

  @override
  String get botToken => '机器人令牌';

  @override
  String get botTokenHint => '在 Telegram 中使用 @BotFather 创建机器人';

  @override
  String get botTokenExample => '123456789:ABCdefGHI...';

  @override
  String get chatId => '聊天 ID';

  @override
  String get chatIdHint => '向机器人发送 /start 并使用 @userinfobot 获取';

  @override
  String get chatIdExample => '您的聊天 ID（例如：123456789）';

  @override
  String get whenNotify => '何时通知';

  @override
  String get backupSuccess => '备份成功完成';

  @override
  String get backupFailed => '备份失败';

  @override
  String get backupStarted => '备份已开始';

  @override
  String get sending => '发送中...';

  @override
  String get sendTest => '发送测试';

  @override
  String get emailNotifications => '电子邮件通知';

  @override
  String get emailDescription => '通过电子邮件接收备份提醒';

  @override
  String get emailProvider => '电子邮件提供商';

  @override
  String get emailProviderHint => '选择您的提供商或手动配置';

  @override
  String get selectProvider => '选择提供商';

  @override
  String get smtpServer => 'SMTP 服务器';

  @override
  String get smtpServerExample => '例如：smtp.gmail.com';

  @override
  String get smtpServerPlaceholder => 'smtp.example.com';

  @override
  String get smtpPort => 'SMTP 端口';

  @override
  String get smtpPortHint => 'TLS 使用 587，SSL 使用 465';

  @override
  String get smtpPortPlaceholder => '587';

  @override
  String get yourEmail => '您的电子邮件';

  @override
  String get yourEmailHint => '用于发送通知的电子邮件';

  @override
  String get yourEmailPlaceholder => 'youremail@gmail.com';

  @override
  String get emailPassword => '密码或应用密码';

  @override
  String get emailPasswordHint => '如果启用了两步验证，请使用应用密码';

  @override
  String get emailPasswordPlaceholder => '您的密码或应用密码';

  @override
  String get destinationEmails => '目标电子邮件';

  @override
  String get destinationEmailsHint => '用逗号分隔多个电子邮件';

  @override
  String get destinationEmailsPlaceholder =>
      'email1@example.com, email2@example.com';

  @override
  String get security => '安全';

  @override
  String get useStartTls => '使用 STARTTLS（推荐）';

  @override
  String get useSsl => '使用 SSL';

  @override
  String get save => '保存';

  @override
  String get fillBotTokenAndChatId => '填写机器人令牌和聊天 ID 以发送测试';

  @override
  String get testMessageSent => '测试消息发送成功！';

  @override
  String errorWithMessage(String message) {
    return '错误：$message';
  }

  @override
  String get fillAllFields => '填写所有必填字段';

  @override
  String get enterAtLeastOneEmail => '至少输入一个目标电子邮件';

  @override
  String get testEmailSent => '测试电子邮件发送成功！';

  @override
  String get basicData => '基本数据';

  @override
  String get scheduling => '日程安排';

  @override
  String get processing => '处理';

  @override
  String get review => '审查';

  @override
  String get nextStep => '下一步';

  @override
  String get saveRoutine => '保存例程';

  @override
  String get back => '返回';

  @override
  String get routineName => '例程名称';

  @override
  String get backupSources => '备份源';

  @override
  String get selectFilesAndFolders => '您可以选择文件和/或文件夹。';

  @override
  String get sourcePathsExample =>
      '/Users/myuser/Documents;/Users/myuser/Projects';

  @override
  String get addSource => '添加源';

  @override
  String get selecting => '选择中...';

  @override
  String get selectFiles => '选择文件';

  @override
  String get selectFolder => '选择文件夹';

  @override
  String get backupDestination => '备份目标';

  @override
  String get destinationDescription => '选择保存文件的文件夹。';

  @override
  String get destinationExample => '/Volumes/Backup/Destination';

  @override
  String get selectDestinationFolder => '选择目标文件夹';

  @override
  String get frequency => '頻率';

  @override
  String get manual => '手动';

  @override
  String get daily => '每日';

  @override
  String get weekly => '每周';

  @override
  String get interval => '间隔';

  @override
  String get runAt => '运行于：';

  @override
  String get runEvery => '运行频率：';

  @override
  String get manualExecutionInfo => '按卡片上的播放按钮时，备份将手动运行。';

  @override
  String get oneMinute => '1 分钟';

  @override
  String nMinutes(int n) {
    return '$n 分钟';
  }

  @override
  String get oneHour => '1 小时';

  @override
  String nHours(int n) {
    return '$n 小时';
  }

  @override
  String get oneDay => '1 天';

  @override
  String nDays(int n) {
    return '$n 天';
  }

  @override
  String get compressBackup => '压缩备份';

  @override
  String get compressionFormat => '压缩格式';

  @override
  String get encryptBackup => '加密备份';

  @override
  String get name => '名称';

  @override
  String get sources => '源';

  @override
  String get destination => '目的地';

  @override
  String get schedule => '计划';

  @override
  String get compression => '压缩';

  @override
  String activeWithFormat(String format) {
    return '活动（$format）';
  }

  @override
  String get deactivated => '未激活';

  @override
  String get encryption => '加密';

  @override
  String get active => '活动';

  @override
  String get diskSpace => '磁盘空间';

  @override
  String get calculatingSizes => '正在计算大小...';

  @override
  String get sourceSize => '源大小';

  @override
  String get notAvailable => '不可用';

  @override
  String get availableSpace => '目标可用空间';

  @override
  String get retention => '保留（版本数量）';

  @override
  String sufficientSpace(String percent) {
    return '空间充足！可用余量 $percent%。';
  }

  @override
  String insufficientSpace(String size) {
    return '空间不足！目标磁盘缺少 $size。';
  }

  @override
  String get fileSelectionCancelled => '文件选择已取消。';

  @override
  String filesAdded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 个文件已添加到源。',
      one: '1 个文件已添加到源。',
    );
    return '$_temp0';
  }

  @override
  String failedToSelectFiles(String error) {
    return '选择文件失败：$error';
  }

  @override
  String get folderSelectionCancelled => '源文件夹选择已取消。';

  @override
  String get sourceFolderSelected => '源文件夹已选择。';

  @override
  String failedToSelectSourceFolder(String error) {
    return '选择源文件夹失败：$error';
  }

  @override
  String get iosSaveLocation => '在 iOS 上，备份将保存在：文档/备份';

  @override
  String get destinationSelectionCancelled => '目标文件夹选择已取消。';

  @override
  String get destinationFolderSelected => '目标文件夹已选择。';

  @override
  String failedToSelectDestination(String error) {
    return '选择目标文件夹失败：$error';
  }

  @override
  String get enterRoutineName => '输入例程名称。';

  @override
  String get enterAtLeastOneSource => '至少输入一个源。';

  @override
  String get enterDestinationPath => '输入目标路径。';

  @override
  String get retentionMustBePositive => '保留必须是大于零的数字。';

  @override
  String get configureEncryptionPassword => '在启用加密之前，请在设置中配置加密密码。';

  @override
  String get decryptFile => '解密文件';

  @override
  String get decryptionDescription => '解密由 ShadowSync 保护的文件';

  @override
  String get encryptedFile => '加密文件';

  @override
  String get selectFileEllipsis => '选择文件...';

  @override
  String get destinationFolder => '目标文件夹';

  @override
  String get selectFolderEllipsis => '选择文件夹...';

  @override
  String get outputFileName => '输出文件名：';

  @override
  String get decryptionPassword => '解密密码：';

  @override
  String get enterEncryptionPassword => '输入加密时使用的密码';

  @override
  String get selectEncryptedFile => '选择加密文件';

  @override
  String get selectDestinationFolderTooltip => '选择目标文件夹';

  @override
  String get execute => '执行';

  @override
  String get decrypting => '解密中...';

  @override
  String get close => '关闭';

  @override
  String get decryptAnother => '解密另一个';

  @override
  String get startingDecryption => '正在启动解密...';

  @override
  String get preparingDecryption => '正在准备解密...';

  @override
  String get decryptingFile => '正在解密文件...';

  @override
  String get extractingContent => '正在提取内容...';

  @override
  String get finalizing => '正在完成...';

  @override
  String decryptedSuccessfully(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '已提取 $count 个文件。',
      one: '已提取 1 个文件。',
    );
    return '解密成功！$_temp0';
  }

  @override
  String errorSelectingFile(String error) {
    return '选择文件时出错：$error';
  }

  @override
  String errorSelectingDestination(String error) {
    return '选择目标时出错：$error';
  }

  @override
  String get verifyDiskTitle => '验证磁盘';

  @override
  String get selectDiskToVerify => '选择要验证完整性的磁盘';

  @override
  String verifying(String diskName) {
    return '正在验证：$diskName';
  }

  @override
  String get backToSelection => '返回选择';

  @override
  String get loadingDisks => '正在加载磁盘...';

  @override
  String errorLoadingDisks(String error) {
    return '加载磁盘时出错：$error';
  }

  @override
  String get tryAgain => '重试';

  @override
  String get noDisksFound => '未找到磁盘';

  @override
  String freeSpace(String size) {
    return '$size 可用';
  }

  @override
  String get diskSpaceUnavailable => '磁盤空間資訊不可用';

  @override
  String get internalStorage => '內部儲存';

  @override
  String get sdCard => 'SD卡';

  @override
  String get externalSdCard => '外部 SD 卡';

  @override
  String get primaryStorage => '主要儲存';

  @override
  String get externalStorage => '外部儲存';

  @override
  String get deviceStorage => '設備儲存';

  @override
  String get appStorage => '應用儲存';

  @override
  String get testsToRun => '将执行的测试：';

  @override
  String get testResults => '测试结果';

  @override
  String get verificationInProgress => '验证进行中...';

  @override
  String get diskVerifiedNoProblems => '磁盘已验证 - 未发现问题';

  @override
  String get verificationCompletedWithWarnings => '验证完成，但有警告';

  @override
  String get problemsDetected => '检测到磁盘问题';

  @override
  String get waiting => '等待中...';

  @override
  String totalTime(String duration) {
    return '总时间：$duration';
  }

  @override
  String get mountPoint => '挂载点';

  @override
  String get device => '设备';

  @override
  String get fileSystem => '文件系统';

  @override
  String get totalCapacity => '总容量';

  @override
  String get availableSpaceLabel => '可用空间';

  @override
  String get mediaType => '媒体类型';

  @override
  String get type => '类型';

  @override
  String get removable => '可移动';

  @override
  String get internal => '内部';

  @override
  String get startVerification => '开始验证';

  @override
  String get verifyAgain => '再次验证';

  @override
  String get testAccessibilityCheck => '可訪問性檢查';

  @override
  String get testSpaceAnalysis => '磁盤空間分析';

  @override
  String get testReadTest => '讀取測試';

  @override
  String get testFileSystemCheck => '文件系統檢查';

  @override
  String get testSmartStatus => 'S.M.A.R.T. 狀態';

  @override
  String get fullDiskAccessRequired =>
      '存取被拒絕。在 macOS 上，請在「系統設定」>「隱私權與安全性」>「完整磁碟取用權限」中授予 ShadowSync「完整磁碟取用權限」。';

  @override
  String get fileSystemCheckRequiresPrivileges =>
      '檔案系統驗證需要特權系統存取。請使用 macOS 的「磁碟工具程式」應用程式手動驗證此磁碟區。';

  @override
  String get language => '语言';

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
  String get scheduleTypeManual => '手动';

  @override
  String get scheduleTypeDaily => '每日';

  @override
  String get scheduleTypeWeekly => '每周';

  @override
  String get scheduleTypeInterval => '间隔';

  @override
  String get backupName => '名称';

  @override
  String get backupSource => '源';

  @override
  String get backupCompression => '压缩';

  @override
  String get backupEncryption => '加密';

  @override
  String get encryptionActive => '启用';

  @override
  String get noRoutinesConfigured => '未设置任何视程';

  @override
  String nextBackupFormat(String routineName, String time) {
    return '下一次: \"$routineName\" $time';
  }

  @override
  String diskSpaceSufficient(String margin) {
    return '空間充足! $margin% 的餘量可用。';
  }

  @override
  String diskSpaceInsufficient(String deficit) {
    return '空間不足! 目標磁盤上缺少 $deficit。';
  }

  @override
  String get dateToday => '今日';

  @override
  String get dateTomorrow => '明日';

  @override
  String get weekdayMonday => '星期一';

  @override
  String get weekdayTuesday => '星期二';

  @override
  String get weekdayWednesday => '星期三';

  @override
  String get weekdayThursday => '星期四';

  @override
  String get weekdayFriday => '星期五';

  @override
  String get weekdaySaturday => '星期六';

  @override
  String get weekdaySunday => '星期日';

  @override
  String get about => '关于';

  @override
  String get aboutTitle => '关于 ShadowSync';

  @override
  String get version => '版本';

  @override
  String get developer => '开发者';

  @override
  String get visitWebsite => '访问网站';
}

/// The translations for Chinese, as used in China (`zh_CN`).
class AppLocalizationsZhCn extends AppLocalizationsZh {
  AppLocalizationsZhCn() : super('zh_CN');

  @override
  String get appTitle => 'ShadowSync';

  @override
  String get appSubtitle => '备份管理器';

  @override
  String get myRoutines => '我的例程';

  @override
  String get verifyDisk => '验证磁盘';

  @override
  String get decrypt => '解密';

  @override
  String get settings => '设置';

  @override
  String startingBackup(String routineName) {
    return '正在启动备份\"$routineName\"...';
  }

  @override
  String get deleteRoutine => '删除例程';

  @override
  String deleteRoutineConfirm(String routineName) {
    return '确定要删除例程\"$routineName\"吗？此操作无法撤销。';
  }

  @override
  String get cancel => '取消';

  @override
  String get delete => '删除';

  @override
  String get noRoutines => '未配置例程';

  @override
  String get noScheduledBackups => '没有计划备份';

  @override
  String get serviceActive => '服务活跃';

  @override
  String nextBackup(String name, String time) {
    return '下一个：\"$name\" $time';
  }

  @override
  String get today => '今天';

  @override
  String get tomorrow => '明天';

  @override
  String get monday => '周一';

  @override
  String get tuesday => '周二';

  @override
  String get wednesday => '周三';

  @override
  String get thursday => '周四';

  @override
  String get friday => '周五';

  @override
  String get saturday => '周六';

  @override
  String get sunday => '周日';

  @override
  String get newBackup => '新建备份';

  @override
  String get runBackup => '运行备份';

  @override
  String get deleteRoutineTooltip => '删除例程';

  @override
  String get manualExecution => '手动执行';

  @override
  String get noScheduleAvailable => '未安排';

  @override
  String scheduledDaily(String time) {
    return '计划：每天 $time';
  }

  @override
  String scheduledWeekly(String date) {
    return '计划：每周 • $date';
  }

  @override
  String scheduledInterval(String interval) {
    return '计划：每 $interval';
  }

  @override
  String get mode => '模式：';

  @override
  String get next => '下一个：';

  @override
  String get last => '上一个：';

  @override
  String get lastBackupLabel => '上次备份：';

  @override
  String fileCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 个文件',
      one: '1 个文件',
    );
    return '$_temp0';
  }

  @override
  String extractedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '已提取 $count 个',
      one: '已提取 1 个',
    );
    return '$_temp0';
  }

  @override
  String get general => '常规';

  @override
  String get telegram => 'Telegram';

  @override
  String get email => '电子邮件';

  @override
  String get userName => '用户名';

  @override
  String get enterYourName => '输入您的姓名';

  @override
  String get encryptionPassword => '加密密码';

  @override
  String get encryptionPasswordHint => '用于保护您的加密备份';

  @override
  String get enterPassword => '输入密码';

  @override
  String get backupFileName => '备份文件名';

  @override
  String get useCustomName => '使用自定义名称';

  @override
  String get customName => '自定义名称';

  @override
  String get telegramNotifications => 'Telegram 通知';

  @override
  String get telegramDescription => '通过 Telegram 接收备份提醒';

  @override
  String get enableNotifications => '启用通知';

  @override
  String get botToken => '机器人令牌';

  @override
  String get botTokenHint => '在 Telegram 中使用 @BotFather 创建机器人';

  @override
  String get botTokenExample => '123456789:ABCdefGHI...';

  @override
  String get chatId => '聊天 ID';

  @override
  String get chatIdHint => '向机器人发送 /start 并使用 @userinfobot 获取';

  @override
  String get chatIdExample => '您的聊天 ID（例如：123456789）';

  @override
  String get whenNotify => '何时通知';

  @override
  String get backupSuccess => '备份成功完成';

  @override
  String get backupFailed => '备份失败';

  @override
  String get backupStarted => '备份已开始';

  @override
  String get sending => '发送中...';

  @override
  String get sendTest => '发送测试';

  @override
  String get emailNotifications => '电子邮件通知';

  @override
  String get emailDescription => '通过电子邮件接收备份提醒';

  @override
  String get emailProvider => '电子邮件提供商';

  @override
  String get emailProviderHint => '选择您的提供商或手动配置';

  @override
  String get selectProvider => '选择提供商';

  @override
  String get smtpServer => 'SMTP 服务器';

  @override
  String get smtpServerExample => '例如：smtp.gmail.com';

  @override
  String get smtpServerPlaceholder => 'smtp.example.com';

  @override
  String get smtpPort => 'SMTP 端口';

  @override
  String get smtpPortHint => 'TLS 使用 587，SSL 使用 465';

  @override
  String get smtpPortPlaceholder => '587';

  @override
  String get yourEmail => '您的电子邮件';

  @override
  String get yourEmailHint => '用于发送通知的电子邮件';

  @override
  String get yourEmailPlaceholder => 'youremail@gmail.com';

  @override
  String get emailPassword => '密码或应用密码';

  @override
  String get emailPasswordHint => '如果启用了两步验证，请使用应用密码';

  @override
  String get emailPasswordPlaceholder => '您的密码或应用密码';

  @override
  String get destinationEmails => '目标电子邮件';

  @override
  String get destinationEmailsHint => '用逗号分隔多个电子邮件';

  @override
  String get destinationEmailsPlaceholder =>
      'email1@example.com, email2@example.com';

  @override
  String get security => '安全';

  @override
  String get useStartTls => '使用 STARTTLS（推荐）';

  @override
  String get useSsl => '使用 SSL';

  @override
  String get save => '保存';

  @override
  String get fillBotTokenAndChatId => '填写机器人令牌和聊天 ID 以发送测试';

  @override
  String get testMessageSent => '测试消息发送成功！';

  @override
  String errorWithMessage(String message) {
    return '错误：$message';
  }

  @override
  String get fillAllFields => '填写所有必填字段';

  @override
  String get enterAtLeastOneEmail => '至少输入一个目标电子邮件';

  @override
  String get testEmailSent => '测试电子邮件发送成功！';

  @override
  String get basicData => '基本数据';

  @override
  String get scheduling => '日程安排';

  @override
  String get processing => '处理';

  @override
  String get review => '审查';

  @override
  String get nextStep => '下一步';

  @override
  String get saveRoutine => '保存例程';

  @override
  String get back => '返回';

  @override
  String get routineName => '例程名称';

  @override
  String get backupSources => '备份源';

  @override
  String get selectFilesAndFolders => '您可以选择文件和/或文件夹。';

  @override
  String get sourcePathsExample =>
      '/Users/myuser/Documents;/Users/myuser/Projects';

  @override
  String get addSource => '添加源';

  @override
  String get selecting => '选择中...';

  @override
  String get selectFiles => '选择文件';

  @override
  String get selectFolder => '选择文件夹';

  @override
  String get backupDestination => '备份目标';

  @override
  String get destinationDescription => '选择保存文件的文件夹。';

  @override
  String get destinationExample => '/Volumes/Backup/Destination';

  @override
  String get selectDestinationFolder => '选择目标文件夹';

  @override
  String get frequency => '频率';

  @override
  String get manual => '手动';

  @override
  String get daily => '每日';

  @override
  String get weekly => '每周';

  @override
  String get interval => '间隔';

  @override
  String get runAt => '运行于：';

  @override
  String get runEvery => '运行频率：';

  @override
  String get manualExecutionInfo => '按卡片上的播放按钮时，备份将手动运行。';

  @override
  String get oneMinute => '1 分钟';

  @override
  String nMinutes(int n) {
    return '$n 分钟';
  }

  @override
  String get oneHour => '1 小时';

  @override
  String nHours(int n) {
    return '$n 小时';
  }

  @override
  String get oneDay => '1 天';

  @override
  String nDays(int n) {
    return '$n 天';
  }

  @override
  String get compressBackup => '压缩备份';

  @override
  String get compressionFormat => '压缩格式';

  @override
  String get encryptBackup => '加密备份';

  @override
  String get name => '名称';

  @override
  String get sources => '源';

  @override
  String get destination => '目的地';

  @override
  String get schedule => '计划';

  @override
  String get compression => '压缩';

  @override
  String activeWithFormat(String format) {
    return '活动（$format）';
  }

  @override
  String get deactivated => '未激活';

  @override
  String get encryption => '加密';

  @override
  String get active => '活动';

  @override
  String get diskSpace => '磁盘空间';

  @override
  String get calculatingSizes => '正在计算大小...';

  @override
  String get sourceSize => '源大小';

  @override
  String get notAvailable => '不可用';

  @override
  String get availableSpace => '目标可用空间';

  @override
  String get retention => '保留（版本数量）';

  @override
  String sufficientSpace(String percent) {
    return '空间充足！可用余量 $percent%。';
  }

  @override
  String insufficientSpace(String size) {
    return '空间不足！目标磁盘缺少 $size。';
  }

  @override
  String get fileSelectionCancelled => '文件选择已取消。';

  @override
  String filesAdded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 个文件已添加到源。',
      one: '1 个文件已添加到源。',
    );
    return '$_temp0';
  }

  @override
  String failedToSelectFiles(String error) {
    return '选择文件失败：$error';
  }

  @override
  String get folderSelectionCancelled => '源文件夹选择已取消。';

  @override
  String get sourceFolderSelected => '源文件夹已选择。';

  @override
  String failedToSelectSourceFolder(String error) {
    return '选择源文件夹失败：$error';
  }

  @override
  String get iosSaveLocation => '在 iOS 上，备份将保存在：文档/备份';

  @override
  String get destinationSelectionCancelled => '目标文件夹选择已取消。';

  @override
  String get destinationFolderSelected => '目标文件夹已选择。';

  @override
  String failedToSelectDestination(String error) {
    return '选择目标文件夹失败：$error';
  }

  @override
  String get enterRoutineName => '输入例程名称。';

  @override
  String get enterAtLeastOneSource => '至少输入一个源。';

  @override
  String get enterDestinationPath => '输入目标路径。';

  @override
  String get retentionMustBePositive => '保留必须是大于零的数字。';

  @override
  String get configureEncryptionPassword => '在启用加密之前，请在设置中配置加密密码。';

  @override
  String get decryptFile => '解密文件';

  @override
  String get decryptionDescription => '解密由 ShadowSync 保护的文件';

  @override
  String get encryptedFile => '加密文件';

  @override
  String get selectFileEllipsis => '选择文件...';

  @override
  String get destinationFolder => '目标文件夹';

  @override
  String get selectFolderEllipsis => '选择文件夹...';

  @override
  String get outputFileName => '输出文件名：';

  @override
  String get decryptionPassword => '解密密码：';

  @override
  String get enterEncryptionPassword => '输入加密时使用的密码';

  @override
  String get selectEncryptedFile => '选择加密文件';

  @override
  String get selectDestinationFolderTooltip => '选择目标文件夹';

  @override
  String get execute => '执行';

  @override
  String get decrypting => '解密中...';

  @override
  String get close => '关闭';

  @override
  String get decryptAnother => '解密另一个';

  @override
  String get startingDecryption => '正在启动解密...';

  @override
  String get preparingDecryption => '正在准备解密...';

  @override
  String get decryptingFile => '正在解密文件...';

  @override
  String get extractingContent => '正在提取内容...';

  @override
  String get finalizing => '正在完成...';

  @override
  String decryptedSuccessfully(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '已提取 $count 个文件。',
      one: '已提取 1 个文件。',
    );
    return '解密成功！$_temp0';
  }

  @override
  String errorSelectingFile(String error) {
    return '选择文件时出错：$error';
  }

  @override
  String errorSelectingDestination(String error) {
    return '选择目标时出错：$error';
  }

  @override
  String get verifyDiskTitle => '验证磁盘';

  @override
  String get selectDiskToVerify => '选择要验证完整性的磁盘';

  @override
  String verifying(String diskName) {
    return '正在验证：$diskName';
  }

  @override
  String get backToSelection => '返回选择';

  @override
  String get loadingDisks => '正在加载磁盘...';

  @override
  String errorLoadingDisks(String error) {
    return '加载磁盘时出错：$error';
  }

  @override
  String get tryAgain => '重试';

  @override
  String get noDisksFound => '未找到磁盘';

  @override
  String freeSpace(String size) {
    return '$size 可用';
  }

  @override
  String get diskSpaceUnavailable => '磁盘空间信息不可用';

  @override
  String get internalStorage => '内部存储';

  @override
  String get sdCard => 'SD卡';

  @override
  String get externalSdCard => '外部 SD 卡';

  @override
  String get primaryStorage => '主要存储';

  @override
  String get externalStorage => '外部存储';

  @override
  String get deviceStorage => '设备存储';

  @override
  String get appStorage => '应用存储';

  @override
  String get testsToRun => '将执行的测试：';

  @override
  String get testResults => '测试结果';

  @override
  String get verificationInProgress => '验证进行中...';

  @override
  String get diskVerifiedNoProblems => '磁盘已验证 - 未发现问题';

  @override
  String get verificationCompletedWithWarnings => '验证完成，但有警告';

  @override
  String get problemsDetected => '检测到磁盘问题';

  @override
  String get waiting => '等待中...';

  @override
  String totalTime(String duration) {
    return '总时间：$duration';
  }

  @override
  String get mountPoint => '挂载点';

  @override
  String get device => '设备';

  @override
  String get fileSystem => '文件系统';

  @override
  String get totalCapacity => '总容量';

  @override
  String get availableSpaceLabel => '可用空间';

  @override
  String get mediaType => '媒体类型';

  @override
  String get type => '类型';

  @override
  String get removable => '可移动';

  @override
  String get internal => '内部';

  @override
  String get startVerification => '开始验证';

  @override
  String get verifyAgain => '再次验证';

  @override
  String get testAccessibilityCheck => '可访问性检查';

  @override
  String get testSpaceAnalysis => '磁盘空间分析';

  @override
  String get testReadTest => '读取测试';

  @override
  String get testFileSystemCheck => '文件系统检查';

  @override
  String get testSmartStatus => 'S.M.A.R.T. 状态';

  @override
  String get fullDiskAccessRequired =>
      '访问被拒绝。在 macOS 上，请在「系统设置」>「隐私与安全性」>「完全磁盘访问权限」中授予 ShadowSync「完全磁盘访问权限」。';

  @override
  String get fileSystemCheckRequiresPrivileges =>
      '文件系统验证需要特权系统访问。请使用 macOS 的「磁盘工具」应用手动验证此卷。';

  @override
  String get language => '语言';

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
  String get scheduleTypeManual => '手动';

  @override
  String get scheduleTypeDaily => '每天';

  @override
  String get scheduleTypeWeekly => '每周';

  @override
  String get scheduleTypeInterval => '间隔';

  @override
  String get backupName => '名称';

  @override
  String get backupSource => '源';

  @override
  String get backupCompression => '压缩';

  @override
  String get backupEncryption => '加密';

  @override
  String get encryptionActive => '启用';

  @override
  String get noRoutinesConfigured => '未配置任何例程';

  @override
  String nextBackupFormat(String routineName, String time) {
    return '下一次: \"$routineName\" $time';
  }

  @override
  String diskSpaceSufficient(String margin) {
    return '空间充足! $margin% 的余量可用。';
  }

  @override
  String diskSpaceInsufficient(String deficit) {
    return '空间不足! 目标磁盘上缺少 $deficit。';
  }

  @override
  String get dateToday => '今天';

  @override
  String get dateTomorrow => '明天';

  @override
  String get weekdayMonday => '周一';

  @override
  String get weekdayTuesday => '周二';

  @override
  String get weekdayWednesday => '周三';

  @override
  String get weekdayThursday => '周四';

  @override
  String get weekdayFriday => '周五';

  @override
  String get weekdaySaturday => '周六';

  @override
  String get weekdaySunday => '周日';

  @override
  String get about => '关于';

  @override
  String get aboutTitle => '关于 ShadowSync';

  @override
  String get version => '版本';

  @override
  String get developer => '开发者';

  @override
  String get visitWebsite => '访问网站';
}
