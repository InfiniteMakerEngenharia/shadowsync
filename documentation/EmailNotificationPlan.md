# Sistema de Notificações via Email

## 1. Visão Geral

Adicionar ao ShadowSync um sistema de notificações via email que permite aos usuários receber alertas sobre o status dos backups em sua caixa de entrada. Este sistema complementará as notificações via Telegram já existentes.

---

## 2. Comparação entre Abordagens

| Característica | SMTP Direto | API de Serviço (SendGrid/Mailgun) |
|----------------|-------------|-----------------------------------|
| Custo | Gratuito (com conta de email) | Gratuito até limite (100/dia) |
| Configuração | Mais complexa | Mais simples |
| Confiabilidade | Depende do provedor | ✅ Alta |
| Flexibilidade | ✅ Qualquer provedor | Limitado ao serviço |
| Sem dependência externa | ✅ Sim | ❌ Não |
| Suporte cross-platform | ⚠️ Verificar | ✅ Sim (HTTP) |

**Decisão:** Implementar via **SMTP direto** usando o pacote `mailer` do Dart, permitindo ao usuário configurar qualquer provedor de email (Gmail, Outlook, Yahoo, servidor próprio, etc.).

---

## 3. Arquitetura

```
┌─────────────────────────────────────────────────────────────┐
│                      ShadowSync App                         │
├─────────────────────────────────────────────────────────────┤
│  BackupEngineService                                        │
│       │                                                     │
│       ▼                                                     │
│  NotificationDispatcher (novo)                              │
│       │                                                     │
│       ├─── TelegramNotificationService                      │
│       │                                                     │
│       └─── EmailNotificationService (novo)                  │
│                 │                                           │
│                 ├─── Verifica se notificação está ativada   │
│                 ├─── Verifica tipo de evento                │
│                 │                                           │
│                 └─── Envia via SMTP                         │
│                           │                                 │
└───────────────────────────┼─────────────────────────────────┘
                            │
                            ▼
                 ┌──────────────────┐
                 │   Servidor SMTP  │
                 │  (Gmail, Outlook,│
                 │   servidor, etc.)│
                 └──────────────────┘
```

---

## 4. Configuração pelo Usuário

### 4.1. Provedores Suportados (Presets)

Para facilitar a configuração, ofereceremos presets para provedores populares:

| Provedor | Servidor SMTP | Porta | SSL/TLS |
|----------|---------------|-------|---------|
| Gmail | smtp.gmail.com | 587 | STARTTLS |
| Outlook/Hotmail | smtp.office365.com | 587 | STARTTLS |
| Yahoo | smtp.mail.yahoo.com | 587 | STARTTLS |
| iCloud | smtp.mail.me.com | 587 | STARTTLS |
| Personalizado | (configurável) | (configurável) | (configurável) |

### 4.2. Configurações Necessárias

1. **Provedor** (dropdown com presets ou "Personalizado")
2. **Servidor SMTP** (preenchido automaticamente se preset)
3. **Porta SMTP** (preenchida automaticamente se preset)
4. **Email de origem** (usuário@provedor.com)
5. **Senha ou App Password**
6. **Email(s) de destino** (pode ser igual ao de origem)
7. **Usar SSL/TLS** (toggle)

### 4.3. Notas sobre App Passwords

#### Gmail
1. Ativar verificação em 2 etapas em conta Google
2. Acessar: https://myaccount.google.com/apppasswords
3. Gerar "App Password" para "Mail" → "Outro (ShadowSync)"
4. Usar a senha de 16 caracteres gerada

#### Outlook/Microsoft
1. Ativar verificação em 2 etapas
2. Acessar: https://account.live.com/proofs/AppPassword
3. Gerar nova senha de app

#### Yahoo
1. Ativar verificação em 2 etapas
2. Acessar: https://login.yahoo.com/account/security/app-passwords
3. Gerar senha de app para "Outras Apps"

### 4.4. Interface no ShadowSync

1. Abrir Configurações → Aba "Email"
2. Habilitar "Notificações via Email"
3. Selecionar provedor ou "Personalizado"
4. Preencher credenciais
5. Inserir email(s) de destino
6. Escolher quais eventos notificar:
   - ✅ Backup concluído com sucesso
   - ✅ Backup falhou
   - ⬜ Backup iniciado
7. Clicar em "Enviar Teste" para verificar
8. Salvar

---

## 5. Estrutura de Arquivos

### 5.1. Arquivos a Criar

```
lib/src/backend/
├── models/
│   ├── email_notification_config.dart      # Modelo de configuração
│   └── email_notification_config.g.dart    # Hive adapter (gerado)
│   └── email_smtp_preset.dart              # Presets de provedores
└── services/
    └── email_notification_service.dart     # Serviço de envio
```

### 5.2. Arquivos a Modificar

```
lib/src/frontend/
└── pages/
    └── settings_page.dart                  # Adicionar aba "Email"

lib/src/backend/
└── services/
    └── backup_engine_service.dart          # Integrar envio de email

pubspec.yaml                                # Adicionar dependência mailer
```

---

## 6. Modelo de Dados

### 6.1. EmailNotificationConfig

```dart
@HiveType(typeId: 5)
class EmailNotificationConfig extends HiveObject {
  @HiveField(0)
  bool isEnabled;

  @HiveField(1)
  String? smtpServer;

  @HiveField(2)
  int smtpPort;

  @HiveField(3)
  String? senderEmail;

  @HiveField(4)
  String? senderPassword;  // Armazenado criptografado

  @HiveField(5)
  List<String> recipientEmails;

  @HiveField(6)
  bool useSSL;

  @HiveField(7)
  bool useTLS;

  @HiveField(8)
  bool notifyOnSuccess;

  @HiveField(9)
  bool notifyOnFailure;

  @HiveField(10)
  bool notifyOnStart;

  @HiveField(11)
  String? presetName;  // "gmail", "outlook", "yahoo", "icloud", "custom"
}
```

### 6.2. EmailSmtpPreset

```dart
class EmailSmtpPreset {
  final String name;
  final String displayName;
  final String smtpServer;
  final int port;
  final bool useSSL;
  final bool useTLS;

  static const List<EmailSmtpPreset> presets = [
    EmailSmtpPreset(
      name: 'gmail',
      displayName: 'Gmail',
      smtpServer: 'smtp.gmail.com',
      port: 587,
      useSSL: false,
      useTLS: true,
    ),
    EmailSmtpPreset(
      name: 'outlook',
      displayName: 'Outlook / Hotmail',
      smtpServer: 'smtp.office365.com',
      port: 587,
      useSSL: false,
      useTLS: true,
    ),
    // ... outros presets
  ];
}
```

---

## 7. Serviço de Email

### 7.1. Dependência

```yaml
# pubspec.yaml
dependencies:
  mailer: ^6.1.2
```

### 7.2. Implementação Principal

```dart
class EmailNotificationService {
  // Singleton pattern (igual ao Telegram)
  
  Future<NotificationResult> sendNotification({
    required NotificationEventType eventType,
    required String routineName,
    String? details,
    String? errorMessage,
    String? deviceName,
  }) async {
    // 1. Verificar se está habilitado
    // 2. Verificar tipo de evento
    // 3. Montar email HTML
    // 4. Enviar via SMTP
    // 5. Retornar resultado
  }

  Future<NotificationResult> sendTestEmail() async {
    // Envia email de teste para validar configuração
  }
}
```

### 7.3. Template do Email

```html
<!DOCTYPE html>
<html>
<head>
  <style>
    .container { font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; }
    .header { background: #1a1a2e; color: white; padding: 20px; text-align: center; }
    .content { padding: 20px; background: #f5f5f5; }
    .success { border-left: 4px solid #4CAF50; }
    .failure { border-left: 4px solid #f44336; }
    .started { border-left: 4px solid #2196F3; }
    .footer { padding: 10px; text-align: center; font-size: 12px; color: #666; }
  </style>
</head>
<body>
  <div class="container">
    <div class="header">
      <h1>🔄 ShadowSync</h1>
    </div>
    <div class="content success">
      <h2>✅ Backup Concluído</h2>
      <p><strong>Rotina:</strong> {{routineName}}</p>
      <p><strong>Dispositivo:</strong> {{deviceName}}</p>
      <p><strong>Horário:</strong> {{timestamp}}</p>
      <p><strong>Detalhes:</strong> {{details}}</p>
    </div>
    <div class="footer">
      <p>Esta é uma notificação automática do ShadowSync.</p>
    </div>
  </div>
</body>
</html>
```

---

## 8. Tratamento de Erros

| Erro | Causa Provável | Ação na UI |
|------|----------------|------------|
| SocketException | Sem internet / servidor inacessível | "Não foi possível conectar ao servidor SMTP" |
| AuthenticationFailed | Credenciais inválidas | "Email ou senha incorretos. Use App Password se tiver 2FA" |
| InvalidRecipient | Email de destino inválido | "Endereço de email de destino inválido" |
| Timeout | Servidor lento | "Tempo limite excedido. Tente novamente" |
| SSL/TLS Error | Configuração incorreta | "Erro de conexão segura. Verifique as configurações SSL/TLS" |

---

## 9. Segurança

- **Senha armazenada**: Usar Hive com criptografia ou `flutter_secure_storage`
- **Ocultação na UI**: Campo de senha ocultado (obscureText: true)
- **Validação**: Validar formato de email antes de salvar
- **Conexão**: Sempre usar SSL/TLS quando disponível
- **Sem logs**: Não logar senha em debugPrint

---

## 10. Limitações Conhecidas

- Alguns provedores bloqueiam SMTP em apps (requer App Password)
- Conexões SMTP podem ser lentas (1-5 segundos)
- Alguns antivírus/firewalls podem bloquear porta 587
- Taxa de envio limitada pelo provedor (Gmail: ~500/dia)

---

## 11. Plano de Implementação

### Fase 1: Modelo e Persistência
- [x] Criar `EmailNotificationConfig` com campos necessários
- [x] Criar adapter Hive (typeId: 5)
- [x] Criar `EmailSmtpPreset` com presets de provedores
- [x] Registrar adapter no main.dart e background_service.dart

### Fase 2: Serviço de Email
- [x] Adicionar dependência `mailer` ao pubspec.yaml
- [x] Criar `EmailNotificationService` seguindo padrão do Telegram
- [x] Implementar método `sendNotification()`
- [x] Implementar método `sendTestEmail()`
- [x] Criar templates HTML para cada tipo de evento

### Fase 3: Interface do Usuário
- [x] Adicionar aba "Email" na página de Configurações
- [x] Criar dropdown de presets de provedores
- [x] Criar campos de configuração (servidor, porta, email, senha)
- [x] Adicionar campo para múltiplos destinatários
- [x] Implementar toggles de eventos (success, failure, start)
- [x] Adicionar botão "Enviar Teste"
- [ ] Adicionar indicador de configuração válida

### Fase 4: Integração
- [x] Modificar `BackupEngineService` para chamar `EmailNotificationService`
- [ ] (Opcional) Criar `NotificationDispatcher` para centralizar Telegram + Email
- [ ] Testar envio em backups reais

### Fase 5: Testes e Documentação
- [ ] Testar com Gmail, Outlook, Yahoo
- [ ] Testar cenários de erro (credenciais inválidas, sem internet)
- [x] Atualizar este documento com status "Concluído"

---

## 12. Estimativa de Tempo

| Fase | Tempo Estimado |
|------|----------------|
| Fase 1: Modelo | 30 min |
| Fase 2: Serviço | 1h |
| Fase 3: UI | 1h30 |
| Fase 4: Integração | 30 min |
| Fase 5: Testes | 30 min |
| **Total** | **~4 horas** |

---

## 13. Configuração Padrão

```dart
EmailNotificationConfig(
  isEnabled: false,
  smtpServer: null,
  smtpPort: 587,
  senderEmail: null,
  senderPassword: null,
  recipientEmails: [],
  useSSL: false,
  useTLS: true,
  notifyOnSuccess: true,   // Habilitado por padrão
  notifyOnFailure: true,   // Habilitado por padrão
  notifyOnStart: false,    // Desabilitado por padrão
  presetName: null,
)
```

---

## 14. Checklist Final

- [x] Modelo `EmailNotificationConfig` criado
- [x] Hive Adapter registrado (typeId: 5)
- [x] `EmailNotificationService` implementado
- [x] Presets de provedores funcionando
- [x] Aba "Email" adicionada às Configurações
- [x] Validação de campos implementada
- [x] Botão de teste funcionando
- [x] Integração com `BackupEngineService`
- [x] Senha armazenada de forma segura
- [x] Tratamento de erros implementado
- [x] Documentação atualizada

---

## 15. Como alterar o ícone do cabeçalho do email

O ícone exibido no cabeçalho das mensagens de email é definido no serviço de notificação. Para alterar a URL da imagem:

1. **Localização:** `lib/src/backend/services/email_notification_service.dart`
2. **Método:** `_getIconImgTag()` (linha ~37)
3. **Alteração:** Edite a constante `iconUrl` com a nova URL da imagem:

```dart
String _getIconImgTag() {
  const iconUrl = 'https://shadownsyncwebpage.pages.dev/images/Email_Icon.png';
  return '<img src="$iconUrl" alt="ShadowSync" width="64" height="64" style="display: block; border: 0;" />';
}
```

4. **Requisitos da imagem:** Use uma URL pública e estável (HTTPS). Dimensões recomendadas: 64x64 pixels para boa exibição em clientes de email.
