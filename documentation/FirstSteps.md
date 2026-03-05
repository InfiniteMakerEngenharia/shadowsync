# 🛡️ QuickBackup Flutter

**Autor:** Eng. Hewerton Trindade Bianchi  
**Versão:** 1.0.0  
**Tecnologia:** Flutter (Desktop Multiplataforma)

## 1. Visão Geral
O **QuickBackup** é um utilitário de produtividade projetado para automatizar a cópia de segurança de arquivos e pastas locais. O foco é a simplicidade de uso aliada a recursos robustos como criptografia e execução silenciosa em segundo plano.

---

## 2. Funcionalidades Principais (Core Features)

### 📂 Gerenciamento de Arquivos
* **Seleção Flexível:** O usuário pode escolher arquivos individuais ou diretórios completos.
* **Destino Customizável:** Definição de múltiplos locais de destino para o backup.

### ⏰ Automação e Agendamento
* **Backup Agendado:** Definir horários fixos (ex: todos os dias às 20h).
* **Backup Recorrente:** Definir intervalos de tempo (ex: a cada 30 minutos).

### 🔐 Segurança e Otimização
* **Compactação:** Suporte a formatos de compressão (ZIP/TAR/RAR) para economia de espaço.
* **Criptografia:** Opção de criptografar arquivos sensíveis utilizando chave AES antes da movimentação.

### 🖥️ Experiência do Usuário (UX)
* **Interface Moderna:** Design intuitivo com temas Dark/Light e feedback visual de progresso.
* **Segundo Plano (Systray):** O aplicativo deve continuar executando as rotinas agendadas mesmo após o fechamento da janela principal.

## 3. Arquitetura Técnica Sugerida



### Frontend (UI)
- **Framework:** Flutter.
- **Gerenciamento de Estado:** Bloc ou Riverpod (para lidar com múltiplos processos de backup).

### Backend (Logic & Persistence)
- **Database:** Isar ou Hive (armazenar configurações de tarefas).
- **Service:** `system_tray` para minimizar o app e `cron` para disparar os eventos de cópia.
- **Crypto:** Pacote `encrypt` (AES-256).

---

## 4. Requisitos de Sistema
* **SO:** Windows 10/11, macOS, Linux.
* **Permissões:** Acesso de leitura e escrita nos diretórios selecionados.

---

## 5. Cronograma de Desenvolvimento (MVP)
1. [ ] Configuração do ambiente Desktop e Window Customization.
2. [ ] Implementação da UI (Dashboard e Configurações).
3. [ ] Lógica de Cópia e Compactação de arquivos.
4. [ ] Implementação do módulo de Criptografia.
5. [ ] Sistema de agendamento e Background Service.
6. [ ] Implementação do Ícone na bandeja do sistema (System Tray).

---

## 6. Construção visual
Especificação de Design: ShadowSync UI
1. Estrutura da Janela (Window Frame)
Estilo: Janela sem bordas padrão do SO (frameless window).

Barra de Título Customizada: No canto superior direito, botões discretos de Minimizar, Maximizar e Fechar (estilo Windows 11/macOS).

Fundo: Gradiente radial muito sutil saindo do centro, utilizando tons de Deep Navy (#0F172A) e Slate Black (#020617).

Efeito: Glassmorphism (vidro jateado) com desfoque de fundo (backdrop filter: blur) nos cards e na sidebar.

2. Barra Lateral de Navegação (Sidebar)
Largura: Estreita (aprox. 80px a 100px).

Fundo: Mais escuro que o painel principal para criar contraste.

Itens:

Ícone de Escudo (Backups): Destaque com um brilho neon azul suave ao redor quando selecionado.

Ícone de Engrenagem (Settings): Localizado abaixo ou no rodapé da sidebar.

Identidade: O logo do app (um "S" dentro de um escudo) aparece no topo.

3. Painel Central: "Minhas Rotinas"
Título: "Minhas Rotinas" em fonte Sans-Serif (ex: Inter ou Roboto), peso Bold, cor branca.

Grid de Tarefas: Organização em cartões (Cards) dispostos em duas colunas.

Detalhes dos Cards de Backup:
Cada card representa uma tarefa ativa e contém:

Ícone de Status: * Cadeado Verde: Indica que a criptografia está ativa.

Pasta Azul: Indica backup simples (sem criptografia).

Informações de Texto:

Título da Tarefa: Nome dado pelo usuário (ex: "Documentos de Engenharia").

Subtítulo: Status atual (ex: "Agendado: Diariamente às 20h" ou "Último backup: 15/03/2026").

Barra de Progresso (Ativa): Uma linha fina azul neon que mostra o progresso do upload/cópia em tempo real, com a porcentagem ao lado.

Indicador de Conclusão: Um ícone de "Check" (visto) verde no canto superior direito para tarefas finalizadas com sucesso.

4. Barra de Status Inferior (Rodapé)
Indicador de Atividade: Um pequeno "LED" verde pulsante no canto esquerdo.

Texto de Status: "Serviço em segundo plano: Ativo. Próximo: 19:59".

Botão de Ação: Botão "+ Novo Backup" no canto direito, com bordas arredondadas e estilo Outlined (contorno branco sutil).

5. Elementos de Sistema (Tray Icon)
No canto inferior da tela (representação da Barra de Tarefas), deve haver um ícone de bandeja do ShadowSync.

Ao fechar a janela principal, um "Toast" ou notificação simples deve informar: "ShadowSync continua protegendo seus arquivos em segundo plano".

🎨 Paleta de Cores para o Código:
Primary (Background): #0F172A

Secondary (Sidebar/Cards): #1E293B

Accent (Action/Progress): #38BDF8 (Sky Blue)

Success (Criptografia/Concluído): #4ADE80 (Mint Green)

Text: #F8FAFC (Off-White)
© 2026 - Eng. Hewerton Trindade Bianchi