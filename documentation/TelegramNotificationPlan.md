# Sistema de Notificações via Telegram

## 1. Visão Geral

O ShadowSync possui um sistema de notificações via Telegram Bot API que permite aos usuários receber alertas em tempo real sobre o status dos backups.

---

## 2. Por que Telegram?

| Característica | Telegram Bot | WhatsApp (CallMeBot) |
|----------------|--------------|----------------------|
| API oficial | ✅ Sim | ❌ Não |
| Custo | Gratuito | Gratuito |
| Confiabilidade | ✅ Alta | ⚠️ Média |
| Limite de mensagens | Sem limite* | Desconhecido |
| Requer servidor próprio | ❌ Não | ❌ Não |
| Setup | Simples | Simples |
| Aceitando novos usuários | ✅ Sim | ❌ Não (bloqueado) |

*Telegram tem rate limits, mas são muito generosos para uso normal.

---

## 3. Arquitetura

```
┌─────────────────────────────────────────────────────────────┐
│                      ShadowSync App                         │
├─────────────────────────────────────────────────────────────┤
│  BackupEngineService                                        │
│       │                                                     │
│       ▼                                                     │
│  TelegramNotificationService                                │
│       │                                                     │
│       ├─── Verifica se notificação está ativada            │
│       ├─── Verifica tipo de evento (início/sucesso/falha)  │
│       │                                                     │
│       └─── Envia POST para Telegram Bot API                │
│                    │                                        │
└────────────────────┼────────────────────────────────────────┘
                     │
                     ▼
          ┌──────────────────┐
          │  Telegram Servers│
          │  api.telegram.org│
          └──────────────────┘
```

---

## 4. Configuração pelo Usuário

### 4.1. Criando um Bot no Telegram

1. Abrir o Telegram e buscar por `@BotFather`
2. Enviar o comando `/newbot`
3. Escolher um nome para o bot (ex: "ShadowSync Notificações")
4. Escolher um username para o bot (ex: "shadowsync_notify_bot")
5. Copiar o **Bot Token** fornecido

### 4.2. Obtendo o Chat ID

1. Iniciar uma conversa com o bot criado (enviar `/start`)
2. Buscar por `@userinfobot` ou `@getidsbot` no Telegram
3. O bot mostrará seu Chat ID

Ou acessar: `https://api.telegram.org/bot<TOKEN>/getUpdates` após enviar mensagem ao bot.

### 4.3. Configurando no ShadowSync

1. Abrir Configurações → Aba "Telegram"
2. Habilitar "Notificações via Telegram"
3. Inserir o **Bot Token** do BotFather
4. Inserir o **Chat ID** obtido
5. Escolher quais eventos notificar:
   - ✅ Backup concluído com sucesso
   - ✅ Backup falhou
   - ⬜ Backup iniciado
6. Clicar em "Enviar Teste" para verificar
7. Salvar

---

## 5. Estrutura de Arquivos

```
lib/src/backend/
├── models/
│   ├── telegram_notification_config.dart      # Modelo de configuração
│   └── telegram_notification_config.g.dart    # Hive adapter
└── services/
    └── telegram_notification_service.dart     # Serviço de envio
```

---

## 6. API do Telegram

### 6.1. Endpoint

```
POST https://api.telegram.org/bot<TOKEN>/sendMessage
```

### 6.2. Parâmetros

```json
{
  "chat_id": "123456789",
  "text": "✅ *ShadowSync - Backup Concluído*\n\n📁 Rotina: Documentos\n📅 Conclusão: 20/02/2026 às 14:30",
  "parse_mode": "MarkdownV2",
  "disable_web_page_preview": true
}
```

### 6.3. Resposta de Sucesso

```json
{
  "ok": true,
  "result": {
    "message_id": 123,
    "from": {...},
    "chat": {...},
    "date": 1708444200,
    "text": "..."
  }
}
```

---

## 7. Formato das Mensagens

### 7.1. Backup Iniciado
```
🔄 *ShadowSync - Backup Iniciado*

📁 Rotina: Documentos
📅 Início: 20/02/2026 às 14:30
```

### 7.2. Backup Concluído
```
✅ *ShadowSync - Backup Concluído*

📁 Rotina: Documentos
📅 Conclusão: 20/02/2026 às 14:35
📊 Detalhes: Backup concluído em 5 minutos
```

### 7.3. Backup Falhou
```
❌ *ShadowSync - Backup Falhou*

📁 Rotina: Documentos
📅 Horário: 20/02/2026 às 14:32
⚠️ Erro: Disco de destino não acessível
```

---

## 8. Tratamento de Erros

| Código | Significado | Ação |
|--------|-------------|------|
| 200 | Sucesso | Mensagem enviada |
| 400 | Bad Request | Verificar parâmetros |
| 401 | Unauthorized | Token inválido |
| 403 | Forbidden | Bot bloqueado pelo usuário |
| 404 | Not Found | Chat ID inválido |
| 429 | Too Many Requests | Rate limit - aguardar |

---

## 9. Segurança

- O Bot Token é armazenado localmente via Hive (criptografado)
- A comunicação usa HTTPS
- Nenhum dado sensível é enviado nas mensagens
- O token é ocultado na UI (campo de senha)

---

## 10. Limitações

- Requer conexão com internet
- Depende da disponibilidade do Telegram
- Rate limit: ~30 mensagens por segundo (muito generoso)
- Sem suporte a grupos (apenas chat direto com o bot)

---

## 11. Configuração Padrão

```dart
TelegramNotificationConfig(
  isEnabled: false,
  botToken: null,
  chatId: null,
  notifyOnSuccess: true,  // Habilitado por padrão
  notifyOnFailure: true,  // Habilitado por padrão
  notifyOnStart: false,   // Desabilitado por padrão
)
```

---

## 12. Implementação Concluída

- [x] Modelo `TelegramNotificationConfig`
- [x] Hive Adapter para persistência
- [x] `TelegramNotificationService` com envio via HTTP
- [x] Integração na página de Configurações (aba Telegram)
- [x] Integração no `BackupEngineService`
- [x] Botão de teste de configuração
- [x] Ocultação do token na UI
- [x] Escape de caracteres especiais para MarkdownV2
