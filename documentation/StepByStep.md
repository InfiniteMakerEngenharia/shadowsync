# ShadowSync — Step by Step de Implementação

Este documento descreve um passo a passo prático para implementar as funcionalidades principais do ShadowSync com foco em arquitetura limpa, UX responsiva e compatibilidade multiplataforma.

## Objetivo

Implementar o fluxo completo de backup com:
- criação de rotina (nome, origem, destino, agendamento)
- compactação opcional
- criptografia opcional
- execução em segundo plano
- persistência local
- atualização de status no dashboard

---

## Estado atual do projeto

Já existe:
- separação entre camadas frontend e backend
- dashboard com cards de rotinas
- responsividade base (desktop/mobile)
- scripts auxiliares (`Compile.sh`, `CompileAndTest.sh`, `UpdateIcons.sh`)
- testes widget e golden básicos

---

## Fase 1 — Modelo de domínio e contratos

### 1.1 Expandir modelo de rotina

Arquivo base: `lib/src/backend/models/backup_routine.dart`

Adicionar campos:
- `sourcePaths` (List<String>)
- `destinationPath` (String)
- `scheduleType` (enum: manual, daily, weekly, interval)
- `scheduleValue` (ex.: horário, dia da semana, minutos)
- `compressionEnabled` (bool)
- `compressionFormat` (enum: zip, tar)
- `encryptionEnabled` (bool)
- `encryptionKeyRef` (String?)
- `retentionCount` (int?)
- `lastRunAt` (DateTime?)
- `nextRunAt` (DateTime?)

### 1.2 Criar entidade de configuração de execução

Novo arquivo sugerido:
- `lib/src/backend/models/backup_execution_config.dart`

Finalidade:
- separar metadados de agendamento da configuração de execução para facilitar evolução.

### 1.3 Definir contratos de repositório

Arquivo base: `lib/src/backend/repositories/backup_repository.dart`

Adicionar operações:
- `createRoutine(...)`
- `updateRoutine(...)`
- `deleteRoutine(id)`
- `watchRoutines()` (stream opcional)

Critério de aceite:
- compila sem warnings
- contrato cobre CRUD e leitura reativa

---

## Fase 2 — Persistência local

### 2.1 Escolher engine

Recomendação para MVP:
- Hive (mais simples)

Alternativa:
- Isar (mais robusto para consultas avançadas)

### 2.2 Implementar repositório persistente

Arquivos sugeridos:
- `lib/src/backend/repositories/hive_backup_repository.dart`
- `lib/src/backend/services/local_storage_service.dart`

Passos:
1. criar adapters/models serializáveis
2. mapear entidade de domínio <-> armazenamento
3. substituir `InMemoryBackupRepository` por implementação real no bootstrap do app

Critério de aceite:
- dados persistem após fechar/reabrir app

---

## Fase 3 — Fluxo Novo Backup (UI + Controller)

### 3.1 Criar tela/fluxo adaptativo

Arquivos sugeridos:
- `lib/src/frontend/pages/new_backup_page.dart`
- `lib/src/frontend/widgets/new_backup/new_backup_stepper.dart`
- `lib/src/frontend/widgets/new_backup/steps/*.dart`

Comportamento:
- mobile: tela full-screen
- desktop: dialog largo/painel modal

### 3.2 Etapas do formulário

1. **Dados básicos**
   - nome da rotina
   - origem (arquivos/pastas)
   - destino

2. **Agendamento**
   - frequência
   - data/hora
   - intervalo

3. **Processamento**
   - compactar?
   - criptografar?

4. **Políticas**
   - retenção

5. **Revisão**
   - resumo e salvar

### 3.3 Conectar botão “+ Novo Backup”

Arquivos base:
- `lib/src/frontend/widgets/status_footer.dart`
- `lib/src/frontend/pages/dashboard_page.dart`

Critério de aceite:
- usuário consegue salvar rotina sem crash
- validação obrigatória de campos (nome, origem, destino)

---

## Fase 4 — Serviço de execução de backup

### 4.1 Criar motor de execução

Arquivo sugerido:
- `lib/src/backend/services/backup_engine_service.dart`

Responsabilidades:
- copiar arquivos/pastas
- calcular progresso
- emitir status (running, success, failed)
- registrar logs

### 4.2 Compactação

Arquivo sugerido:
- `lib/src/backend/services/compression_service.dart`

Pacotes possíveis:
- `archive`

### 4.3 Criptografia

Arquivo sugerido:
- `lib/src/backend/services/encryption_service.dart`

Pacotes possíveis:
- `encrypt`

Critério de aceite:
- rotina executa com/sem compactação e com/sem criptografia

---

## Fase 5 — Agendamento e segundo plano

### 5.1 Scheduler

Arquivo sugerido:
- `lib/src/backend/services/scheduler_service.dart`

Pacote inicial:
- `cron`

Responsabilidades:
- agendar próximas execuções
- recalcular `nextRunAt`
- reidratar jobs ao iniciar o app

### 5.2 System Tray (desktop)

Arquivo sugerido:
- `lib/src/backend/services/tray_service.dart`

Pacote:
- `system_tray`

Comportamento:
- fechar janela principal não encerra serviço
- ação no tray: abrir app / sair

Critério de aceite:
- app continua executando tarefas agendadas com janela fechada

---

## Fase 6 — Atualização do dashboard em tempo real

### 6.1 Estado reativo

Opções:
- Riverpod (recomendado)
- BLoC

Arquivos sugeridos:
- `lib/src/frontend/controllers/dashboard_state.dart`
- `lib/src/frontend/controllers/dashboard_notifier.dart`

### 6.2 Atualização dos cards

- mostrar progresso ativo
- mostrar último resultado
- destacar falhas com ação de retry

Critério de aceite:
- progresso e status refletem execução real sem reiniciar tela

---

## Fase 7 — Testes

### 7.1 Unitários (backend)

Pastas:
- `test/backend/services/`
- `test/backend/repositories/`

Cobrir:
- criação/edição de rotina
- agendamento
- compactação
- criptografia

### 7.2 Widget + Golden (frontend)

Pastas:
- `test/frontend/widgets/`
- `test/golden/`

Cobrir:
- fluxo Novo Backup
- validações visuais em portrait/landscape

Comandos:
```bash
./CompileAndTest.sh
flutter test
flutter test --update-goldens test/golden/dashboard_golden_test.dart
```

---

## Fase 8 — Checklist de entrega MVP

- [ ] criar rotina pelo UI
- [ ] editar e excluir rotina
- [ ] persistir localmente
- [ ] executar manualmente uma rotina
- [ ] agendar rotina automática
- [ ] compactação funcionando
- [ ] criptografia funcionando
- [ ] app em tray no desktop
- [ ] dashboard com status em tempo real
- [ ] testes principais passando

---

## Ordem recomendada de execução (resumo)

1. Fase 1 (domínio)
2. Fase 2 (persistência)
3. Fase 3 (Novo Backup UI)
4. Fase 4 (engine)
5. Fase 5 (agendamento + tray)
6. Fase 6 (estado reativo)
7. Fase 7 (testes)
8. Fase 8 (fechamento MVP)

---

## Observações de implementação

- manter front-end e back-end desacoplados por interfaces
- evitar lógica de negócio dentro de widgets
- todas as operações longas devem ser assíncronas com feedback de progresso
- proteger dados sensíveis (senha/chave) e nunca persistir texto puro sem estratégia
