import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Serviço responsável por gerenciar o idioma/locale do aplicativo.
/// 
/// Funcionalidades:
/// - Detecção automática do idioma do sistema
/// - Fallback para inglês quando idioma não é suportado
/// - Permitir alteração manual pelo usuário
/// - Persistir preferência do usuário
class LocaleService extends ChangeNotifier {
  static const String _localeBoxName = 'locale_settings';
  static const String _languageCodeKey = 'language_code';
  static const String _countryCodeKey = 'country_code';
  
  /// Instância singleton
  static LocaleService? _instance;
  
  /// Retorna a instância singleton do LocaleService
  static LocaleService getInstance() {
    _instance ??= LocaleService._internal();
    return _instance!;
  }
  
  /// Construtor privado para singleton
  LocaleService._internal();
  
  /// Idiomas suportados pelo aplicativo
  static const List<Locale> supportedLocales = [
    Locale('pt', 'BR'), // Português (Brasil)
    Locale('pt'),       // Português (fallback)
    Locale('en'),       // Inglês
    Locale('fr'),       // Francês
    Locale('de'),       // Alemão
    Locale('es'),       // Espanhol
    Locale('it'),       // Italiano
    Locale('ja'),       // Japonês
    Locale('zh', 'CN'), // Chinês Simplificado
    Locale('zh'),       // Chinês (fallback)
    Locale('ko'),       // Coreano
  ];
  
  /// Locale padrão (inglês)
  static const Locale defaultLocale = Locale('en');
  
  /// Locale atual do aplicativo
  Locale _currentLocale = defaultLocale;
  
  /// Box do Hive para persistência
  Box? _localeBox;
  
  /// Indica se o locale foi carregado das preferências
  bool _isInitialized = false;
  
  /// Retorna o locale atual
  Locale get currentLocale => _currentLocale;
  
  /// Retorna se o serviço foi inicializado
  bool get isInitialized => _isInitialized;
  
  /// Inicializa o serviço de locale
  /// 
  /// Este método deve ser chamado no início do aplicativo.
  /// Ele carrega a preferência salva do usuário ou detecta automaticamente
  /// o idioma do sistema.
  Future<void> initialize() async {
    try {
      // Abre o box do Hive
      _localeBox = await Hive.openBox(_localeBoxName);
      
      // Tenta carregar a preferência salva do usuário
      final savedLanguageCode = _localeBox?.get(_languageCodeKey);
      
      if (savedLanguageCode != null) {
        // Se há preferência salva, usa ela
        final savedCountryCode = _localeBox?.get(_countryCodeKey);
        final savedLocale = savedCountryCode != null
            ? Locale(savedLanguageCode, savedCountryCode)
            : Locale(savedLanguageCode);
        
        // Verifica se o locale salvo é suportado
        if (_isLocaleSupported(savedLocale)) {
          _currentLocale = savedLocale;
        } else {
          // Se não for suportado, usa o padrão
          _currentLocale = defaultLocale;
        }
      }
      // Se não há preferência salva, usa o locale do sistema
      // A detecção automática será feita pelo localeResolutionCallback
      // do MaterialApp, então aqui apenas deixamos o locale padrão
      
      _isInitialized = true;
      notifyListeners();
    } catch (e) {
      debugPrint('Erro ao inicializar LocaleService: $e');
      _currentLocale = defaultLocale;
      _isInitialized = true;
      notifyListeners();
    }
  }
  
  /// Altera o locale do aplicativo
  /// 
  /// Esta mudança é persistida e sobrescreve a detecção automática.
  Future<void> setLocale(Locale locale) async {
    if (_currentLocale == locale) return;
    
    if (!_isLocaleSupported(locale)) {
      debugPrint('Locale não suportado: $locale');
      return;
    }
    
    try {
      // Salva a preferência
      await _localeBox?.put(_languageCodeKey, locale.languageCode);
      
      if (locale.countryCode != null) {
        await _localeBox?.put(_countryCodeKey, locale.countryCode);
      } else {
        await _localeBox?.delete(_countryCodeKey);
      }
      
      _currentLocale = locale;
      notifyListeners();
    } catch (e) {
      debugPrint('Erro ao salvar locale: $e');
    }
  }
  
  /// Reseta o locale para a detecção automática do sistema
  /// 
  /// Remove a preferência manual do usuário.
  Future<void> resetToSystemLocale() async {
    try {
      await _localeBox?.delete(_languageCodeKey);
      await _localeBox?.delete(_countryCodeKey);
      
      // O locale será detectado automaticamente na próxima inicialização
      // Por enquanto, usa o padrão
      _currentLocale = defaultLocale;
      notifyListeners();
    } catch (e) {
      debugPrint('Erro ao resetar locale: $e');
    }
  }
  
  /// Verifica se um locale é suportado
  bool _isLocaleSupported(Locale locale) {
    // Tenta correspondência exata primeiro (idioma + país)
    if (supportedLocales.any((supportedLocale) =>
        supportedLocale.languageCode == locale.languageCode &&
        supportedLocale.countryCode == locale.countryCode)) {
      return true;
    }
    
    // Tenta correspondência apenas por idioma (ignora país)
    return supportedLocales.any((supportedLocale) =>
        supportedLocale.languageCode == locale.languageCode);
  }
  
  /// Retorna o locale apropriado baseado no locale do dispositivo
  /// 
  /// Este método implementa a lógica de fallback:
  /// 1. Tenta encontrar correspondência exata (idioma + país)
  /// 2. Tenta encontrar correspondência apenas por idioma
  /// 3. Usa inglês como fallback
  static Locale localeResolutionCallback(
    Locale? deviceLocale,
    Iterable<Locale> supportedLocales,
  ) {
    // Se não há locale do dispositivo, usa o padrão
    if (deviceLocale == null) {
      return defaultLocale;
    }
    
    // Tenta correspondência exata (idioma + país)
    for (final supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == deviceLocale.languageCode &&
          supportedLocale.countryCode == deviceLocale.countryCode) {
        return supportedLocale;
      }
    }
    
    // Tenta correspondência apenas por idioma
    for (final supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == deviceLocale.languageCode) {
        return supportedLocale;
      }
    }
    
    // Fallback para inglês
    return defaultLocale;
  }
  
  /// Retorna o nome do idioma no idioma nativo
  static String getLocaleName(Locale locale) {
    switch (locale.languageCode) {
      case 'pt':
        return locale.countryCode == 'BR' ? '🇧🇷 Português (Brasil)' : '🇵🇹 Português';
      case 'en':
        return '🇺🇸 English';
      case 'fr':
        return '🇫🇷 Français';
      case 'de':
        return '🇩🇪 Deutsch';
      case 'es':
        return '🇪🇸 Español';
      case 'it':
        return '🇮🇹 Italiano';
      case 'ja':
        return '🇯🇵 日本語';
      case 'zh':
        return locale.countryCode == 'CN' ? '🇨🇳 中文 (简体)' : '🇨🇳 中文';
      case 'ko':
        return '🇰🇷 한국어';
      default:
        return locale.languageCode.toUpperCase();
    }
  }
  
  /// Retorna apenas os locales principais (sem fallbacks) para o seletor
  static List<Locale> get selectableLocales => [
    const Locale('pt', 'BR'),
    const Locale('pt'),
    const Locale('en'),
    const Locale('fr'),
    const Locale('de'),
    const Locale('es'),
    const Locale('it'),
    const Locale('ja'),
    const Locale('zh', 'CN'),
    const Locale('ko'),
  ];
  
  @override
  void dispose() {
    _localeBox?.close();
    super.dispose();
  }
}
