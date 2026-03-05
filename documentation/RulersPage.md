# Regras de Padronização de Páginas e Widgets - ShadowSync

Este documento define as regras obrigatórias para criação e manutenção de arquivos de páginas e widgets Flutter no projeto ShadowSync.

---

## 1. Estrutura Obrigatória do Arquivo

Todo arquivo de widget/página deve seguir esta estrutura:

```dart
import 'dart:ui';

import 'package:flutter/material.dart';

// Imports locais...

// ============================================================================
// CONFIGURAÇÃO DE TIPOGRAFIA
// ============================================================================

// Constantes de tipografia aqui...

// ============================================================================
// CONFIGURAÇÃO DE DIMENSÕES
// ============================================================================

// Constantes de dimensões aqui...

// ============================================================================
// WIDGET [NOME DO WIDGET]
// ============================================================================

class NomeDoWidget extends StatelessWidget {
  // Implementação...
}
```

---

## 2. Convenções de Nomenclatura das Constantes

### 2.1 Prefixo

Todas as constantes devem começar com `k` seguido do nome do componente:

| Componente | Prefixo |
|------------|---------|
| RoutineCard | `kCard` |
| Sidebar | `kSidebar` |
| StatusFooter | `kFooter` |
| DashboardPage | `kDashboard` |
| NewBackupPage | `kNewBackup` |

### 2.2 Sufixos para Modos Responsivos

Quando houver diferentes valores para diferentes modos de tela:

| Modo | Sufixo |
|------|--------|
| Mobile/Compacto | `Dense` |
| Desktop/Normal | `Normal` |
| Portrait | `Portrait` |
| Landscape | `Landscape` |

### 2.3 Exemplos de Nomes

```dart
// Tipografia
const String kCardFontFamily = 'Roboto';
const FontWeight kCardTitleFontWeight = FontWeight.w600;

// Tamanhos de fonte por modo
const double kCardTitleFontSizeDense = 16.0;
const double kCardTitleFontSizeNormal = 15.0;

// Ícones
const double kCardMainIconSizeDense = 18.0;
const double kCardInfoIconSizeNormal = 14.0;

// Espaçamentos
const double kCardPaddingDense = 14.0;
const double kSidebarLogoToShieldSpacing = 28.0;

// Dimensões
const double kSidebarWidth = 120.0;
const double kFooterIndicatorSize = 10.0;
```

---

## 3. Categorias de Constantes Obrigatórias

### 3.1 Tipografia

```dart
// ============================================================================
// CONFIGURAÇÃO DE TIPOGRAFIA
// ============================================================================

/// Fonte padrão usada em todos os textos do [componente]
const String k[Componente]FontFamily = 'Roboto';

/// Peso da fonte para títulos
const FontWeight k[Componente]TitleFontWeight = FontWeight.w600;

/// Peso da fonte para textos normais
const FontWeight k[Componente]NormalFontWeight = FontWeight.normal;

/// Peso da fonte para textos com destaque médio
const FontWeight k[Componente]MediumFontWeight = FontWeight.w500;
```

### 3.2 Tamanhos de Fonte

```dart
// ============================================================================
// CONFIGURAÇÃO DE TAMANHOS - MODO DENSO (Mobile/Android)
// ============================================================================

/// Tamanho da fonte do título (modo denso)
const double k[Componente]TitleFontSizeDense = 16.0;

/// Tamanho da fonte do subtítulo (modo denso)
const double k[Componente]SubtitleFontSizeDense = 13.0;

// ============================================================================
// CONFIGURAÇÃO DE TAMANHOS - MODO NORMAL (Desktop)
// ============================================================================

/// Tamanho da fonte do título (modo normal)
const double k[Componente]TitleFontSizeNormal = 15.0;

/// Tamanho da fonte do subtítulo (modo normal)
const double k[Componente]SubtitleFontSizeNormal = 12.0;
```

### 3.3 Ícones

```dart
// ============================================================================
// CONFIGURAÇÃO DE ÍCONES
// ============================================================================

/// Tamanho dos ícones principais (modo denso)
const double k[Componente]MainIconSizeDense = 18.0;

/// Tamanho dos ícones principais (modo normal)
const double k[Componente]MainIconSizeNormal = 20.0;

/// Tamanho dos ícones de informação
const double k[Componente]InfoIconSize = 14.0;
```

### 3.4 Dimensões e Espaçamentos

```dart
// ============================================================================
// CONFIGURAÇÃO DE DIMENSÕES
// ============================================================================

/// Padding interno (modo denso)
const double k[Componente]PaddingDense = 14.0;

/// Padding interno (modo normal)
const double k[Componente]PaddingNormal = 14.0;

/// Raio de borda
const double k[Componente]BorderRadius = 16.0;

// ============================================================================
// ESPAÇAMENTOS
// ============================================================================

/// Espaço entre elementos
const double k[Componente]ElementSpacing = 10.0;
```

---

## 4. Documentação das Constantes

Toda constante DEVE ter um comentário de documentação (`///`) explicando:
- O que a constante controla
- Em qual modo ela se aplica (se houver diferentes modos)

```dart
/// Tamanho da fonte do título/nome da rotina (modo denso)
const double kCardTitleFontSizeDense = 16.0;

/// Largura total da sidebar
const double kSidebarWidth = 120.0;

/// Espaço entre o indicador de status e o texto
const double kFooterIndicatorSpacing = 10.0;
```

---

## 5. Separadores de Seção

Use separadores visuais para organizar as constantes:

```dart
// ============================================================================
// NOME DA SEÇÃO EM MAIÚSCULAS
// ============================================================================
```

Seções recomendadas:
1. CONFIGURAÇÃO DE TIPOGRAFIA
2. CONFIGURAÇÃO DE TAMANHOS - MODO DENSO (Mobile/Android)
3. CONFIGURAÇÃO DE TAMANHOS - MODO NORMAL (Desktop)
4. CONFIGURAÇÃO DE DIMENSÕES
5. CONFIGURAÇÃO DE ÍCONES
6. ESPAÇAMENTOS
7. WIDGET [NOME]

---

## 6. Uso das Constantes no Widget

No método `build()`, crie variáveis locais que selecionam a constante apropriada:

```dart
@override
Widget build(BuildContext context) {
  // Seleciona tamanhos baseado no modo
  final padding = isDense ? kCardPaddingDense : kCardPaddingNormal;
  final titleSize = isDense ? kCardTitleFontSizeDense : kCardTitleFontSizeNormal;
  final mainIconSize = isDense ? kCardMainIconSizeDense : kCardMainIconSizeNormal;

  return Container(
    padding: EdgeInsets.all(padding),
    child: Text(
      'Título',
      style: TextStyle(
        fontFamily: kCardFontFamily,
        fontSize: titleSize,
        fontWeight: kCardTitleFontWeight,
      ),
    ),
  );
}
```

---

## 7. Exemplo Completo

```dart
import 'package:flutter/material.dart';

import '../theme/shadowsync_theme.dart';

// ============================================================================
// CONFIGURAÇÃO DE TIPOGRAFIA DO EXEMPLO
// ============================================================================

/// Fonte padrão usada em todos os textos
const String kExampleFontFamily = 'Roboto';

/// Peso da fonte para títulos
const FontWeight kExampleTitleFontWeight = FontWeight.w600;

// ============================================================================
// CONFIGURAÇÃO DE TAMANHOS - MODO DENSO (Mobile)
// ============================================================================

/// Tamanho da fonte do título (modo denso)
const double kExampleTitleFontSizeDense = 16.0;

/// Padding interno (modo denso)
const double kExamplePaddingDense = 14.0;

// ============================================================================
// CONFIGURAÇÃO DE TAMANHOS - MODO NORMAL (Desktop)
// ============================================================================

/// Tamanho da fonte do título (modo normal)
const double kExampleTitleFontSizeNormal = 15.0;

/// Padding interno (modo normal)
const double kExamplePaddingNormal = 14.0;

// ============================================================================
// WIDGET EXAMPLE CARD
// ============================================================================

class ExampleCard extends StatelessWidget {
  const ExampleCard({
    super.key,
    required this.isDense,
  });

  final bool isDense;

  @override
  Widget build(BuildContext context) {
    final padding = isDense ? kExamplePaddingDense : kExamplePaddingNormal;
    final titleSize = isDense ? kExampleTitleFontSizeDense : kExampleTitleFontSizeNormal;

    return Container(
      padding: EdgeInsets.all(padding),
      child: Text(
        'Exemplo',
        style: TextStyle(
          fontFamily: kExampleFontFamily,
          fontSize: titleSize,
          fontWeight: kExampleTitleFontWeight,
          color: ShadowSyncColors.text,
        ),
      ),
    );
  }
}
```

---

## 8. Checklist para Novos Arquivos

Antes de finalizar um novo arquivo de página/widget, verifique:

- [ ] Todas as constantes estão no início do arquivo
- [ ] Todas as constantes têm o prefixo `k` + nome do componente
- [ ] Todas as constantes têm documentação `///`
- [ ] As seções estão separadas por comentários visuais
- [ ] Valores hardcoded foram substituídos por constantes
- [ ] A fonte `kFontFamily` está sendo usada em todos os TextStyle
- [ ] Constantes para modos diferentes (Dense/Normal) estão separadas

---

## 9. Arquivos de Referência

Consulte estes arquivos como exemplos de implementação correta:

- `lib/src/frontend/widgets/routine_card.dart`
- `lib/src/frontend/widgets/sidebar.dart`
- `lib/src/frontend/widgets/status_footer.dart`
