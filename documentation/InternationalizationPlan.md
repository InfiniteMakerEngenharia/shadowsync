# 🌍 Plano de Internacionalização - ShadowSync

**Autor:** Eng. Hewerton Trindade Bianchi  
**Versão:** 1.0.0  
**Aplicativo:** ShadowSync  
**Data:** Março 2026

## 1. Visão Geral

Este documento descreve o plano completo para implementar a internacionalização (i18n) no aplicativo **ShadowSync**, permitindo que usuários de diferentes países utilizem o aplicativo em seu idioma nativo.

### 🎯 Objetivo
Tornar o ShadowSync acessível globalmente, oferecendo suporte a 9 idiomas:

| Código | Idioma | Código Locale |
|--------|--------|---------------|
| 🇧🇷 | Português (Brasil) | `pt_BR` |
| 🇺🇸 | Inglês | `en` |
| 🇫🇷 | Francês | `fr` |
| 🇩🇪 | Alemão | `de` |
| 🇪🇸 | Espanhol | `es` |
| 🇮🇹 | Italiano | `it` |
| 🇯🇵 | Japonês | `ja` |
| 🇨🇳 | Chinês Simplificado | `zh_CN` |
| 🇰🇷 | Coreano | `ko` |

### 🎯 Comportamento Automático

**IMPORTANTE:** O aplicativo deve detectar automaticamente o idioma do dispositivo do usuário:

- ✅ **Detecção Automática:** Ao iniciar, o app identifica o idioma/locale configurado no sistema operacional
- ✅ **Fallback Inteligente:** Se o idioma detectado não estiver na lista de suportados, o app usa **Inglês** como padrão
- ✅ **Preferência do Usuário:** O usuário pode alterar manualmente o idioma nas Configurações, sobrescrevendo a detecção automática
- ✅ **Persistência:** A escolha manual do usuário é salva e tem prioridade sobre a detecção automática

**Exemplo de Fluxo:**
1. Usuário brasileiro inicia o app → Detecta `pt_BR` → Exibe em Português
2. Usuário alemão inicia o app → Detecta `de` → Exibe em Alemão
3. Usuário árabe inicia o app → Detecta `ar` (não suportado) → Exibe em Inglês
4. Usuário muda manualmente para Francês → Salva preferência → Sempre exibe em Francês

---

## 2. Pré-requisitos Técnicos

### Dependências Necessárias

Adicionar ao `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
  intl: ^0.19.0

flutter:
  generate: true
```

### Arquivo de Configuração l10n

Criar `l10n.yaml` na raiz do projeto:

```yaml
arb-dir: lib/src/l10n
template-arb-file: app_pt_BR.arb
output-localization-file: app_localizations.dart
output-class: AppLocalizations
output-dir: lib/src/generated/l10n
nullable-getter: false
synthetic-package: false
```

---

## 3. Estrutura de Arquivos

### Organização Proposta

```text
lib/
  src/
    l10n/                          # Arquivos de tradução ARB
      app_pt_BR.arb                # Português (template)
      app_en.arb                   # Inglês
      app_fr.arb                   # Francês
      app_de.arb                   # Alemão
      app_es.arb                   # Espanhol
      app_it.arb                   # Italiano
      app_ja.arb                   # Japonês
      app_zh_CN.arb                # Chinês
      app_ko.arb                   # Coreano
    generated/
      l10n/                        # Gerado automaticamente
        app_localizations.dart
        app_localizations_pt_BR.dart
        app_localizations_en.dart
        ...
```

---

## 4. Implementação Passo a Passo

### ✅ Passo 1: Configurar Dependências

**Ações:**
1. Editar `pubspec.yaml` para adicionar as dependências
2. Criar o arquivo `l10n.yaml` na raiz
3. Executar `flutter pub get`

**Resultado Esperado:**  
Dependências instaladas e Flutter pronto para gerar código de localização.

---

### ✅ Passo 2: Criar Estrutura de Diretórios

**Ações:**
```bash
mkdir -p lib/src/l10n
mkdir -p lib/src/generated/l10n
```

**Resultado Esperado:**  
Pastas criadas para armazenar arquivos de tradução.

---

### ✅ Passo 3: Criar Arquivo Template (Português)

**Arquivo:** `lib/src/l10n/app_pt_BR.arb`

**Conteúdo Inicial:**
```json
{
  "@@locale": "pt_BR",
  
  "appTitle": "ShadowSync",
  "@appTitle": {
    "description": "Título do aplicativo"
  },
  
  "dashboard": "Painel",
  "@dashboard": {
    "description": "Nome da página dashboard"
  },
  
  "myRoutines": "Minhas Rotinas",
  "@myRoutines": {
    "description": "Título da seção de rotinas"
  },
  
  "newRoutine": "Nova Rotina",
  "@newRoutine": {
    "description": "Botão para criar nova rotina"
  },
  
  "editRoutine": "Editar Rotina",
  "@editRoutine": {
    "description": "Botão para editar rotina"
  },
  
  "deleteRoutine": "Excluir Rotina",
  "@deleteRoutine": {
    "description": "Botão para excluir rotina"
  },
  
  "routineName": "Nome da Rotina",
  "@routineName": {
    "description": "Campo nome da rotina"
  },
  
  "source": "Origem",
  "@source": {
    "description": "Campo origem do backup"
  },
  
  "destination": "Destino",
  "@destination": {
    "description": "Campo destino do backup"
  },
  
  "schedule": "Agendamento",
  "@schedule": {
    "description": "Campo de agendamento"
  },
  
  "status": "Status",
  "@status": {
    "description": "Status da rotina"
  },
  
  "active": "Ativa",
  "@active": {
    "description": "Status ativa"
  },
  
  "inactive": "Inativa",
  "@inactive": {
    "description": "Status inativa"
  },
  
  "running": "Em Execução",
  "@running": {
    "description": "Status em execução"
  },
  
  "completed": "Concluída",
  "@completed": {
    "description": "Status concluída"
  },
  
  "failed": "Falhou",
  "@failed": {
    "description": "Status falhou"
  },
  
  "lastBackup": "Último Backup",
  "@lastBackup": {
    "description": "Data do último backup"
  },
  
  "nextBackup": "Próximo Backup",
  "@nextBackup": {
    "description": "Data do próximo backup"
  },
  
  "selectFolder": "Selecionar Pasta",
  "@selectFolder": {
    "description": "Botão para selecionar pasta"
  },
  
  "selectFile": "Selecionar Arquivo",
  "@selectFile": {
    "description": "Botão para selecionar arquivo"
  },
  
  "save": "Salvar",
  "@save": {
    "description": "Botão salvar"
  },
  
  "cancel": "Cancelar",
  "@cancel": {
    "description": "Botão cancelar"
  },
  
  "delete": "Excluir",
  "@delete": {
    "description": "Botão excluir"
  },
  
  "confirm": "Confirmar",
  "@confirm": {
    "description": "Botão confirmar"
  },
  
  "settings": "Configurações",
  "@settings": {
    "description": "Página de configurações"
  },
  
  "language": "Idioma",
  "@language": {
    "description": "Seleção de idioma"
  },
  
  "theme": "Tema",
  "@theme": {
    "description": "Seleção de tema"
  },
  
  "darkMode": "Modo Escuro",
  "@darkMode": {
    "description": "Tema escuro"
  },
  
  "lightMode": "Modo Claro",
  "@lightMode": {
    "description": "Tema claro"
  },
  
  "notifications": "Notificações",
  "@notifications": {
    "description": "Configurações de notificações"
  },
  
  "encryption": "Criptografia",
  "@encryption": {
    "description": "Configurações de criptografia"
  },
  
  "compression": "Compressão",
  "@compression": {
    "description": "Configurações de compressão"
  },
  
  "backupInProgress": "Backup em andamento...",
  "@backupInProgress": {
    "description": "Mensagem de backup em progresso"
  },
  
  "backupCompleted": "Backup concluído com sucesso!",
  "@backupCompleted": {
    "description": "Mensagem de backup concluído"
  },
  
  "backupFailed": "Falha no backup: {error}",
  "@backupFailed": {
    "description": "Mensagem de falha no backup",
    "placeholders": {
      "error": {
        "type": "String",
        "example": "Sem permissão"
      }
    }
  },
  
  "routineCount": "{count, plural, =0{Nenhuma rotina} =1{1 rotina} other{{count} rotinas}}",
  "@routineCount": {
    "description": "Contador de rotinas",
    "placeholders": {
      "count": {
        "type": "int",
        "format": "compact"
      }
    }
  },
  
  "filesBackedUp": "{count} {count, plural, =1{arquivo} other{arquivos}} copiado(s)",
  "@filesBackedUp": {
    "description": "Contador de arquivos copiados",
    "placeholders": {
      "count": {
        "type": "int"
      }
    }
  },
  
  "about": "Sobre",
  "@about": {
    "description": "Página sobre"
  },
  
  "version": "Versão",
  "@version": {
    "description": "Versão do aplicativo"
  },
  
  "help": "Ajuda",
  "@help": {
    "description": "Página de ajuda"
  },
  
  "exit": "Sair",
  "@exit": {
    "description": "Sair do aplicativo"
  }
}
```

---

### ✅ Passo 4: Criar Arquivos de Tradução

Para cada idioma, criar um arquivo ARB correspondente.

#### Exemplo: `lib/src/l10n/app_en.arb` (Inglês)

```json
{
  "@@locale": "en",
  
  "appTitle": "ShadowSync",
  "dashboard": "Dashboard",
  "myRoutines": "My Routines",
  "newRoutine": "New Routine",
  "editRoutine": "Edit Routine",
  "deleteRoutine": "Delete Routine",
  "routineName": "Routine Name",
  "source": "Source",
  "destination": "Destination",
  "schedule": "Schedule",
  "status": "Status",
  "active": "Active",
  "inactive": "Inactive",
  "running": "Running",
  "completed": "Completed",
  "failed": "Failed",
  "lastBackup": "Last Backup",
  "nextBackup": "Next Backup",
  "selectFolder": "Select Folder",
  "selectFile": "Select File",
  "save": "Save",
  "cancel": "Cancel",
  "delete": "Delete",
  "confirm": "Confirm",
  "settings": "Settings",
  "language": "Language",
  "theme": "Theme",
  "darkMode": "Dark Mode",
  "lightMode": "Light Mode",
  "notifications": "Notifications",
  "encryption": "Encryption",
  "compression": "Compression",
  "backupInProgress": "Backup in progress...",
  "backupCompleted": "Backup completed successfully!",
  "backupFailed": "Backup failed: {error}",
  "routineCount": "{count, plural, =0{No routines} =1{1 routine} other{{count} routines}}",
  "filesBackedUp": "{count} {count, plural, =1{file} other{files}} backed up",
  "about": "About",
  "version": "Version",
  "help": "Help",
  "exit": "Exit"
}
```

**Repetir o processo para os demais idiomas:**
- `app_fr.arb` (Francês)
- `app_de.arb` (Alemão)
- `app_es.arb` (Espanhol)
- `app_it.arb` (Italiano)
- `app_ja.arb` (Japonês)
- `app_zh_CN.arb` (Chinês)
- `app_ko.arb` (Coreano)

---

### ✅ Passo 5: Gerar Código de Localização

**Comando:**
```bash
flutter gen-l10n
```

**Resultado:**  
O Flutter irá gerar automaticamente as classes de localização em `lib/src/generated/l10n/`.

---

### ✅ Passo 6: Configurar MaterialApp

**Arquivo:** `lib/src/app.dart`

**Modificações:**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n/app_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShadowSync',
      
      // Configuração de localização
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      
      // Idiomas suportados
      supportedLocales: const [
        Locale('pt', 'BR'), // Português (Brasil)
        Locale('en'),       // Inglês
        Locale('fr'),       // Francês
        Locale('de'),       // Alemão
        Locale('es'),       // Espanhol
        Locale('it'),       // Italiano
        Locale('ja'),       // Japonês
        Locale('zh', 'CN'), // Chinês
        Locale('ko'),       // Coreano
      ],
      
      // Detecção automática do idioma do dispositivo
      // Se não houver suporte, fallback para Inglês
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        // Verifica se o idioma do dispositivo é suportado
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == deviceLocale?.languageCode &&
              supportedLocale.countryCode == deviceLocale?.countryCode) {
            return supportedLocale;
          }
        }
        // Se não encontrar correspondência exata, tenta apenas o código do idioma
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == deviceLocale?.languageCode) {
            return supportedLocale;
          }
        }
        // Fallback para Inglês se o idioma não for suportado
        return const Locale('en');
      },
      
      // Resto da configuração...
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const DashboardPage(),
    );
  }
}
```

---

### ✅ Passo 7: Usar Traduções no Código

**Exemplo de Uso:**

```dart
import 'package:flutter/material.dart';
import '../generated/l10n/app_localizations.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Obter instância de localização
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.dashboard), // Traduzido automaticamente
      ),
      body: Column(
        children: [
          Text(l10n.myRoutines),
          ElevatedButton(
            onPressed: () {},;
    final countryCode = prefs.getString('countryCode');
    
    // Se não houver preferência salva, usa o locale do sistema
    if (languageCode == null) {
      // O MaterialApp já fará a detecção automática via localeResolutionCallback
      // Retorna sem definir, permitindo que o sistema decida
      return;
    }
          ),
          // Exemplo com parâmetros
          Text(l10n.backupFailed('Sem permissão')),
          // Exemplo com plurais
          Text(l10n.routineCount(5)), // "5 rotinas"
        ],
      ),
    );
  }
}
```

---

### ✅ Passo 8: Implementar Seletor de Idioma

**Criar Provider/Controller para Gerenciar Locale:**

```dart
// lib/src/backend/services/locale_service.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleService extends ChangeNotifier {
  Locale _locale = const Locale('pt', 'BR');
  
  Locale get locale => _locale;
  
  Future<void> loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString('languageCode') ?? 'pt';
    final countryCode = prefs.getString('countryCode');
    
    _locale = Locale(languageCode, countryCode);
    notifyListeners();
  }
  
  Future<void> setLocale(Locale locale) async {
    if (_locale == locale) return;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', locale.languageCode);
    if (locale.countryCode != null) {
      await prefs.setString('countryCode', locale.countryCode!);
    }
    
    _locale = locale;
    notifyListeners();
  }
}
```

**Integrar no MaterialApp:**

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'backend/services/locale_service.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleService>(
      builder: (context, localeService, child) {
        return MaterialApp(
          locale: localeService.locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          // ...
        );
      },
    );
  }
}
```

**Tela de Configurações:**

```dart
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final localeService = Provider.of<LocaleService>(context);
    
    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: ListView(
        children: [
          ListTile(
            title: Text(l10n.language),
            trailing: DropdownButton<Locale>(
              value: localeService.locale,
              items: const [
                DropdownMenuItem(
                  value: Locale('pt', 'BR'),
                  child: Text('🇧🇷 Português'),
                ),
                DropdownMenuItem(
                  value: Locale('en'),
                  child: Text('🇺🇸 English'),
                ),
                DropdownMenuItem(
                  value: Locale('fr'),
                  child: Text('🇫🇷 Français'),
                ),
                DropdownMenuItem(
                  value: Locale('de'),
                  child: Text('🇩🇪 Deutsch'),
                ),
                DropdownMenuItem(
                  value: Locale('es'),
                  child: Text('🇪🇸 Español'),
                ),
                DropdownMenuItem(
                  value: Locale('it'),
                  child: Text('🇮🇹 Italiano'),
                ),
                DropdownMenuItem(
                  value: Locale('ja'),
                  child: Text('🇯🇵 日本語'),
                ),
                DropdownMenuItem(
                  value: Locale('zh', 'CN'),
                  child: Text('🇨🇳 中文'),
                ),
                DropdownMenuItem(
                  value: Locale('ko'),
                  child: Text('🇰🇷 한국어'),
                ),
              ],
              onChanged: (locale) {
                if (locale != null) {
                  localeService.setLocale(locale);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
```

---

## 5. Boas Práticas

### 📝 Organização das Chaves

- Use nomes descritivos e consistentes
- Agrupe chaves por contexto (ex: `button_`, `error_`, `message_`)
- Mantenha a ordem alfabética ou por funcionalidade

### 🔤 Formatação de Textos

- **Datas:** Use `intl` para formatar datas automaticamente
```dart
import 'package:intl/intl.dart';

final formattedDate = DateFormat.yMMMd(l10n.localeName).format(DateTime.now());
```

- **Números:** Use formatação de números sensível ao locale
```dart
final formattedNumber = NumberFormat.decimalPattern(l10n.localeName).format(1234.56);
```

- **Moeda:** Use formatação de moeda apropriada
```dart
final formattedCurrency = NumberFormat.currency(
  locale: l10n.localeName,
  symbol: r'$',
).format(99.99);
```

### 🌐 Considerações Culturais

- **Japonês/Chinês/Coreano:** Evite textos muito longos em botões (caracteres ocupam mais espaço visual)
- **Alemão:** Palavras tendem a ser mais longas, ajuste layouts para acomodar
- **RTL (Right-to-Left):** Se adicionar árabe ou hebraico no futuro, use `Directionality` widget
- **Cores e Símbolos:** Algumas cores têm significados diferentes em culturas distintas

### ⚠️ Textos Dinâmicos

Sempre use placeholders para textos dinâmicos:

```json
{**Usar Inglês como fallback universal** (padrão quando idioma não é suportado)
   - Implementar detecção automática do idioma do dispositivo
  "welcomeUser": "Bem-vindo, {userName}!",
  "@welcomeUser": {
    "description": "Mensagem de boas-vindas",
    "placeholders": {
      "userName": {
        "type": "String",
        "example": "João"
      }
    }
  }
}
```

---

## 6. Processo de Tradução

### Estratégia Recomendada

1. **Fase 1 - Desenvolvimento:**
   - Desenvolver em Português (BR) e Inglês simultaneamente
   - Usar Inglês como fallback universal

2. **Fase 2 - Tradução Profissional:**
   - Contratar tradutores nativos para cada idioma
   - **Serviços Recomendados:**
     - [Crowdin](https://crowdin.com/) - Plataforma colaborativa
     - [Lokalise](https://lokalise.com/) - Gestão de traduções
     - [POEditor](https://poeditor.com/) - Editor de traduções
     - Tradutores freelancers especializados

3. **Fase 3 - Revisão:**
   - Revisão por falantes nativos
   - Testes de usabilidade em cada idioma

### 🤖 Tradução Automática (Não Recomendado para Produção)

Para prototipagem inicial, pode-se usar:
- Google Translate API
- DeepL API
- **PORÉM:** Sempre revisar com humanos nativos!

---

## 7. Testes de Internacionalização

### Testes Manuais

Criar checklist para cada idioma:

```markdown
- [ ] Todos os textos são exibidos corretamente
- [ ] Não há textos cortados ou sobrepostos
- [ ] Datas e números estão formatados corretamente
- [ ] Botões e menus são acessíveis
- [ ] Não há caracteres corrompidos (encoding)
- [ ] Pluralização funciona corretamente
```

### Testes Automatizados

```dart
// test/i18n_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:shadowsync/src/generated/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

void main() {
  group('Internacionalização', () {
    test('Todos os locales suportados têm traduções', () async {
      final locales = [
        Locale('pt', 'BR'),
        Locale('en'),
        Locale('fr'),
        Locale('de'),
        Locale('es'),
        Locale('it'),
        Locale('ja'),
        Locale('zh', 'CN'),
        Locale('ko'),
      ];
      
      for (final locale in locales) {
        final localizations = await AppLocalizations.delegate.load(locale);
        expect(localizations.appTitle, isNotEmpty);
        expect(localizations.dashboard, isNotEmpty);
        expect(localizations.myRoutines, isNotEmpty);
      }
    });
    
    test('Pluralização funciona corretamente', () async {
      final ptBR = await AppLocalizations.delegate.load(Locale('pt', 'BR'));
      expect(ptBR.routineCount(0), contains('Nenhuma'));
      expect(ptBR.routineCount(1), contains('1 rotina'));
      expect(ptBR.routineCount(5), contains('5 rotinas'));
    });
  });
}
```

---

## 8. Manutenção e Atualização

### Workflow de Atualização

1. **Adicionar Nova String:**
   - Adicionar primeiro no arquivo template (`app_pt_BR.arb`)
   - Rodar `flutter gen-l10n`
   - Adicionar nos demais arquivos de idioma
   - Commitar todas as alterações juntas

2. **Modificar String Existente:**
   - Atualizar no template
   - Atualizar em todos os idiomas
   - Testar em cada idioma

3. **Remover String:**
   - Remover do código
   - Remover de todos os arquivos ARB
   - Regenerar código

### 🔄 CI/CD Integration

Adicionar verificação no GitHub Actions:

```yaml
# .github/workflows/i18n_check.yml
name: I18n Check

on: [push, pull_request]

jobs:
  check-translations:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
      - run: flutter pub get
      - run: flutter gen-l10n
      - name: Check for missing translations
        run: |
          # Script para verificar se todos os idiomas têm as mesmas chaves
          python scripts/check_translations.py
```

---

## 9. Cronograma de Implementação

### Sprint 1 - Configuração Inicial (1 semana)
- [x] Adicionar dependências
- [x] Criar estrutura de pastas
- [x] Configurar `l10n.yaml`
- [x] Criar arquivo template PT-BR
- [x] Configurar MaterialApp

### Sprint 2 - Tradução Core (2 semanas)
- [ ] Traduzir para Inglês (EN)
- [ ] Traduzir para Espanhol (ES)
- [ ] Traduzir para Francês (FR)
- [ ] Traduzir para Alemão (DE)
- [ ] Traduzir para Italiano (IT)

### Sprint 3 - Tradução Asiática (2 semanas)
- [ ] Traduzir para Japonês (JA)
- [ ] Traduzir para Chinês Simplificado (ZH_CN)
- [ ] Traduzir para Coreano (KO)
- [ ] Ajustar layouts para caracteres CJK

### Sprint 4 - Implementação UI (1 semana)
- [ ] Criar seletor de idioma
- [ ] Implementar LocaleService com detecção automática
- [ ] Configurar fallback para Inglês
- [ ] Integrar com SharedPreferences
- [ ] Adicionar animações de troca de idioma

### Sprint 5 - Testes e Refinamento (1 semana)
- [ ] Testes manuais em todos os idiomas
- [ ] Testes automatizados
- [ ] Ajustes de layout
- [ ] Correções de tradução

### Sprint 6 - Documentação e Lançamento (3 dias)
- [ ] Documentar processo de tradução
- [ ] Criar guia para contribuidores
- [ ] Atualizar README com badges de idiomas
- [ ] Lançar versão multilíngue

---

## 10. Recursos e Ferramentas

### Ferramentas de Tradução
- **Crowdin:** https://crowdin.com/
- **Lokalise:** https://lokalise.com/
- **POEditor:** https://poeditor.com/

### Diretrizes de Estilo
- **Google Material Design I18n:** https://m3.material.io/
- **Apple Human Interface Guidelines:** https://developer.apple.com/design/

### Referências Flutter
- **Flutter Internationalization:** https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization
- **Intl Package:** https://pub.dev/packages/intl

### Validadores
- **ARB Validator:** Verificar sintaxe JSON dos arquivos ARB
- **Translation Coverage:** Scripts para verificar completude das traduções

---

## 11. Checklist Final

Antes de considerar a internacionalização completa:

- [ ] Todos os 9 idiomas implementados
- [ ] Detecção automática do idioma do dispositivo funcionando
- [ ] Fallback para Inglês quando idioma não é suportado
- [ ] Seletor de idioma funcional
- [ ] Preferência de idioma persistida
- [ ] Todos os textos hardcoded removidos do código
- [ ] Datas, números e moedas formatados corretamente
- [ ] Pluralização testada em todos os idiomas
- [ ] Layouts responsivos para textos longos (alemão)
- [ ] Layouts otimizados para CJK (japonês, chinês, coreano)
- [ ] Testes automatizados implementados
- [ ] Documentação atualizada
- [ ] README com badges de idiomas suportados
- [ ] Contribuidores nativos revisaram traduções
- [ ] CI/CD validando traduções

---

## 12. Contatos para Revisão

### Revisores Nativos Recomendados

| Idioma | Região | Perfil Ideal |
|--------|--------|--------------|
| Português | Brasil | Desenvolvedor BR |
| Inglês | EUA/UK | Desenvolvedor nativo |
| Francês | França | Tradutor técnico |
| Alemão | Alemanha | Tradutor técnico |
| Espanhol | Espanha/América Latina | Tradutor técnico |
| Italiano | Itália | Tradutor técnico |
| Japonês | Japão | Tradutor especializado em software |
| Chinês | China | Tradutor especializado em software |
| Coreano | Coreia do Sul | Tradutor especializado em software |

---

## 📚 Apêndice: Exemplo Completo de ARB

Ver arquivo detalhado no Passo 3 deste documento.

---

## 🎯 Conclusão

A internacionalização do **ShadowSync** permitirá alcançar uma audiência global de milhões de usuários. Com planejamento cuidadoso, ferramentas adequadas e tradutores qualificados, o aplicativo estará pronto para competir no mercado internacional de ferramentas de backup.

**Próximos Passos:**
1. Revisar este plano com a equipe
2. Iniciar Sprint 1 de configuração
3. Contratar tradutores profissionais
4. Implementar de forma incremental e testada

---

**Documento vivo - Última atualização:** Março 2026  
**Responsável:** Eng. Hewerton Trindade Bianchi
