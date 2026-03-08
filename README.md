# ShadowSync

<p align="center">
  <strong>Gerenciador de Backups</strong>
</p>

<p align="center">
  Aplicativo multiplataforma para agendamento, execução e monitoramento de rotinas de backup com interface moderna e notificações integradas.
</p>

---

## Sobre o Projeto

O **ShadowSync** é um aplicativo desktop e mobile desenvolvido em Flutter que permite criar, agendar e executar rotinas de backup com suporte a compressão (ZIP), criptografia AES-256 e notificações via Email e Telegram. A interface utiliza o estilo glassmorphism e oferece experiência fluida em macOS, Windows, Linux, Android e iOS.

### Principais Funcionalidades

- **Rotinas de backup** — Crie múltiplas rotinas com origens e destinos personalizados
- **Agendamento** — Diário, semanal ou por intervalo de minutos
- **Compressão** — Formato ZIP para reduzir o tamanho dos arquivos
- **Criptografia** — AES-256-CBC para proteger backups sensíveis
- **Notificações** — Alertas por Email (SMTP) e Telegram
- **Verificação de disco** — Diagnóstico de saúde de armazenamento (SMART)
- **Descriptografia** — Ferramenta integrada para desbloquear arquivos criptografados
- **Internacionalização** — Suporte a 12 idiomas (PT-BR, EN, ES, FR, DE, IT, JA, ZH, KO, etc.)
- **Serviço em segundo plano** — Execução de backups agendados no Android

### Plataformas Suportadas

| Plataforma | Status |
|------------|--------|
| macOS      | ✅     |
| Windows    | ✅     |
| Linux      | ✅     |
| Android    | ✅     |
| iOS        | ✅     |
| Web        | ⚠️ Parcial |

---

## Pré-requisitos

- **Flutter SDK** 3.10.4 ou superior (com suporte a desktop habilitado)
- **Dart** 3.10.4+
- Para **macOS**: Xcode e ferramentas de linha de comando
- Para **Windows**: Visual Studio com workload de desenvolvimento em C++
- Para **Linux**: GCC, clang, pkg-config, libgtk-3-dev
- Para **Android**: Android Studio e SDK Android

---

## Instalação

1. **Clone o repositório**

```bash
git clone https://github.com/InfiniteMakerEngenharia/shadowsync.git
cd shadowsync
```

2. **Instale as dependências**

```bash
flutter pub get
```

3. **Gere os arquivos de localização** (se necessário)

```bash
flutter gen-l10n
```

---

## Como Executar

### Desktop

```bash
# macOS
flutter run -d macos

# Windows
flutter run -d windows

# Linux
flutter run -d linux
```

### Mobile

```bash
# Android
flutter run -d android

# iOS
flutter run -d ios
```

### Script auxiliar

O projeto inclui scripts para facilitar o fluxo de desenvolvimento:

```bash
# Instalar dependências, rodar testes e executar
./scripts/CompileAndTest.sh macos
./scripts/CompileAndTest.sh windows
./scripts/CompileAndTest.sh linux
```

---

## Build para Distribuição

### macOS

```bash
flutter build macos --release
```

O app será gerado em `build/macos/Build/Products/Release/`.

### Windows

```bash
flutter build windows --release
```

O executável estará em `build/windows/x64/runner/Release/`.

### Linux

```bash
flutter build linux --release
```

Saída em `build/linux/x64/release/bundle/`.

### Android (APK)

```bash
flutter build apk --release
```

APK em `build/app/outputs/flutter-apk/app-release.apk`.

### Android (AAB para Google Play)

```bash
flutter build appbundle --release
```

AAB em `build/app/outputs/bundle/release/app-release.aab`.

### iOS

```bash
flutter build ipa --release
```

Requer conta Apple Developer e certificados configurados.

---

## Estrutura do Projeto

```
shadowsync/
├── lib/
│   ├── main.dart
│   └── src/
│       ├── app.dart
│       ├── backend/           # Lógica de negócio
│       │   ├── models/
│       │   ├── repositories/
│       │   └── services/
│       ├── frontend/           # Interface do usuário
│       │   ├── controllers/
│       │   ├── pages/
│       │   ├── theme/
│       │   └── widgets/
│       └── generated/          # Código gerado (l10n)
├── assets/
│   ├── images/
│   └── animations/
├── documentation/
├── scripts/
└── test/
```

---

## Testes

```bash
# Todos os testes
flutter test

# Testes golden (snapshots visuais)
flutter test test/golden/dashboard_golden_test.dart

# Atualizar snapshots golden
flutter test --update-goldens test/golden/dashboard_golden_test.dart
```

---

## Ícone do Aplicativo

O ícone padrão está em `assets/images/icon.png`. Para regenerar os ícones em todas as plataformas:

```bash
dart run flutter_launcher_icons
```

Ou use o script:

```bash
./scripts/UpdateIcons.sh
```

---

## Verificação de Disco (macOS)

O app usa uma exceção de sandbox para leitura em `/Volumes/` e `/`, permitindo verificar discos e volumes sem exigir Acesso Total ao Disco. Se ainda assim aparecer "Operation not permitted":

1. **Recompile o app** para aplicar os entitlements:
   ```bash
   flutter clean && flutter run -d macos
   ```
   Ou gere um novo build de release: `flutter build macos --release`.

2. **Alternativa:** Conceda **Acesso Total ao Disco** ao ShadowSync em Ajustes do Sistema → Privacidade e Segurança → Acesso Total ao Disco, e adicione o executável que você está usando (ex.: `build/macos/Build/Products/Debug/shadowsync.app`). Reinicie o app depois.

---

## Configuração de Notificações

### Email (SMTP)

Configure em **Configurações → Email**:

- Provedor (Gmail, Outlook, Yahoo, etc.) ou servidor personalizado
- Credenciais e destinatários
- Eventos a notificar (sucesso, falha, início)

### Telegram

Configure em **Configurações → Telegram**:

- Bot Token e Chat ID
- Eventos a notificar

---

## Documentação Adicional

- [Primeiros Passos](documentation/FirstSteps.md)
- [Plano de Internacionalização](documentation/InternationalizationPlan.md)
- [Notificações por Email](documentation/EmailNotificationPlan.md)
- [Notificações por Telegram](documentation/TelegramNotificationPlan.md)
- [Instruções de Build](documentation/instructions.md)

---

## Tecnologias

- **Flutter** — Framework multiplataforma
- **Hive** — Persistência local
- **Dart Mailer** — Envio de emails via SMTP
- **Encrypt** — Criptografia AES-256
- **Archive** — Compressão ZIP
- **Cron** — Agendamento de tarefas

---

## Licença

Este projeto é de uso privado. Entre em contato com o autor para informações sobre licenciamento.

---

## Autor

**Eng. Hewerton Bianchi**

- Website: [infinitemaker.com.br](https://infinitemaker.com.br)
- Projeto: [ShadowSync](https://shadownsyncwebpage.pages.dev)

---

<p align="center">
  <sub>ShadowSync v1.0.0 — Gerenciador de Backups</sub>
</p>
