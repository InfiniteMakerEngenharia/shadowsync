# ShadowSync

Aplicativo desktop Flutter para gerenciamento de rotinas de backup com UI moderna no estilo glassmorphism.

## Estrutura do projeto

```text
lib/
	main.dart
	src/
		app.dart
		backend/
			models/
			repositories/
			services/
		frontend/
			controllers/
			pages/
			theme/
			widgets/
```

- `frontend`: interface, tema, widgets e controlador de tela.
- `backend`: modelo de domínio, contrato de repositório e serviço de negócio.

## Pré-requisitos

- Flutter SDK 3.24+ (Desktop habilitado)
- macOS, Windows ou Linux com toolchain configurado

## Como executar

1. Instale as dependências:

```bash
flutter pub get
```

2. Rode no desktop desejado:

```bash
flutter run -d macos
```

Ou substitua por `-d windows` / `-d linux` conforme seu ambiente.

## Como testar

Execute os testes de widget:

```bash
flutter test
```

Ou use o script para instalar dependências + testar + executar:

```bash
./CompileAndTest.sh
```

Para escolher o device alvo:

```bash
./CompileAndTest.sh macos
./CompileAndTest.sh windows
./CompileAndTest.sh linux
```

## Ícone do aplicativo

O projeto usa `assets/images/icon.png` como ícone único para Android, iOS, Web, Windows e macOS.

Para regenerar os ícones após alterar a imagem:

```bash
dart run flutter_launcher_icons
```

Ou use o script pronto:

```bash
./UpdateIcons.sh
```

### Teste visual (golden)

Rodar os testes golden:

```bash
flutter test test/golden/dashboard_golden_test.dart
```

Atualizar snapshots golden (após mudanças visuais intencionais):

```bash
flutter test --update-goldens test/golden/dashboard_golden_test.dart
```

## Compilar versão final para distribuição

### macOS

Gera o app bundle (.app) em `build/macos/Build/Products/Release/`:

```bash

```

Para distribuir na Mac App Store, é necessário assinar o app com um certificado Apple Developer e criar um arquivo `.pkg`:

```bash
# Após configurar o signing no Xcode
flutter build macos --release
# Abra o projeto no Xcode para Archive e Upload
open macos/Runner.xcworkspace
```

### Windows

Gera o executável em `build/windows/x64/runner/Release/`:

```bash
flutter build windows --release
```

Para criar um instalador, recomenda-se usar [Inno Setup](https://jrsoftware.org/isinfo.php) ou [MSIX Packaging Tool](https://learn.microsoft.com/en-us/windows/msix/packaging-tool/tool-overview):

```bash
# Usando msix (adicione msix ao pubspec.yaml em dev_dependencies)
dart run msix:create
```

### Linux

Gera o executável em `build/linux/x64/release/bundle/`:

```bash
flutter build linux --release
```

Para distribuir, empacote como `.deb`, `.rpm`, `.AppImage` ou Snap. Exemplo com AppImage:

```bash
# Instale appimagetool e crie a estrutura AppDir
# Consulte: https://appimage.org/
```

### Android (APK para testes)

Gera APK para instalação direta (sideload):

```bash
flutter build apk --release
```

O arquivo será gerado em `build/app/outputs/flutter-apk/app-release.apk`.

### Android (AAB para Google Play Store)

A Google Play Store **não aceita mais APK** para novos apps. É obrigatório usar o formato **Android App Bundle (AAB)**:

```bash
flutter build appbundle --release
```

O arquivo será gerado em `build/app/outputs/bundle/release/app-release.aab`.

#### Pré-requisitos para publicação na Google Play:

1. **Criar uma keystore** para assinar o app (apenas uma vez):

```bash
keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA \
  -keysize 2048 -validity 10000 -alias upload
```

2. **Configurar a assinatura** criando o arquivo `android/key.properties`:

```properties
storePassword=<senha-da-keystore>
keyPassword=<senha-da-chave>
keyAlias=upload
storeFile=<caminho-absoluto-para-upload-keystore.jks>
```

3. **Verificar se `android/app/build.gradle.kts`** está configurado para usar a keystore:

```kotlin
val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

android {
    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties["keyAlias"] as String
            keyPassword = keystoreProperties["keyPassword"] as String
            storeFile = file(keystoreProperties["storeFile"] as String)
            storePassword = keystoreProperties["storePassword"] as String
        }
    }
    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
        }
    }
}
```

4. **Gerar o AAB assinado**:

```bash
flutter build appbundle --release
```

5. **Fazer upload** do arquivo `.aab` no [Google Play Console](https://play.google.com/console).

### iOS (App Store)

Gera o arquivo para App Store em `build/ios/ipa/`:

```bash
flutter build ipa --release
```

Requer conta Apple Developer e certificados configurados. Após o build:

```bash
# Abra o Xcode para Archive e Upload
open ios/Runner.xcworkspace
```

Ou use o Transporter app da Apple para fazer upload do `.ipa`.

### Web

Gera os arquivos estáticos em `build/web/`:

```bash
flutter build web --release
```

Faça deploy em qualquer servidor web, Firebase Hosting, Vercel, Netlify, etc.

## Observações do MVP atual

- Janela desktop sem borda nativa com botões customizados de controle.
- Dashboard “Minhas Rotinas” com sidebar, cards, barra de progresso e rodapé de status.
- Camadas `frontend` e `backend` separadas para facilitar evolução (agendamento, criptografia e persistência real).
