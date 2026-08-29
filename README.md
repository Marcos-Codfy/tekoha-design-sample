<div align="center">

# Tekohá — Design Sample System

**Catálogo vivo dos componentes reutilizáveis do aplicativo Tekohá.**

[![Flutter](https://img.shields.io/badge/Flutter-3.41-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.11-0175C2?logo=dart&logoColor=white)](https://dart.dev)
![Componentes](https://img.shields.io/badge/componentes-3-B5451B)
![Testes](https://img.shields.io/badge/testes-10%20passando-2E7D32)
![Análise estática](https://img.shields.io/badge/flutter%20analyze-sem%20issues-2E7D32)
![Dependências](https://img.shields.io/badge/dependências%20externas-0-6B6B6B)

</div>

---

## O que é

Este projeto não é um aplicativo de produto: é a **vitrine do design system** do
[Tekohá](#relação-com-o-aplicativo-tekohá). Uma tela-índice lista os componentes, e
cada uma leva a uma tela de demonstração onde o componente aparece em todas as suas
variantes, tamanhos e estados — cada exemplo acompanhado da chamada de código que o
produz.

Um catálogo assim resolve três problemas de uma vez:

- **Consistência** — quem for construir uma tela nova vê o que já existe antes de
  reinventar um botão (heurística de Nielsen nº 4, consistência e padrões).
- **Revisão de design** — dá para inspecionar todos os estados de um componente
  lado a lado, o que não acontece quando eles estão espalhados por dez telas.
- **Documentação que não envelhece** — o catálogo é código que roda. Se o componente
  mudar, a demonstração muda junto.

## As telas

| Tela | O que mostra |
|---|---|
| **Sample** (índice) | As linhas dos componentes, construídas com o próprio `TekohaListItem` — o catálogo consome o que documenta |
| **Action Button** | Variantes, tamanhos, estados e largura, cada bloco com a chamada que o gera |
| **Tab Bar** | A barra viva no rodapé trocando o conteúdo do corpo, mais os dois estados de uma aba lado a lado |
| **List Items** | Os quatro formatos de linha nos contextos reais: navegação, lista principal, item indisponível, conteúdo longo e tabela de dados |

## Estrutura

```
lib/
├── main.dart                              # MaterialApp, tema e rotas nomeadas
├── theme/
│   ├── app_colors.dart                    # tokens de cor — fonte única da verdade
│   └── app_theme.dart                     # ThemeData montado a partir dos tokens
├── components/
│   └── common/
│       ├── action_button.dart             # ActionButton
│       ├── tab_bar.dart                   # TekohaTabBar
│       └── list_items.dart                # TekohaListItem
└── pages/
    ├── sample_screen.dart                 # índice
    ├── sample_section.dart                # moldura das telas de demonstração
    ├── sample_action_button_screen.dart
    ├── sample_tab_bar_screen.dart
    └── sample_list_items_screen.dart

test/
└── components/                            # um arquivo por componente
```

**Convenção de idioma:** código e mensagens de commit em inglês; comentários, interface
e documentação em português. Cada componente abre com um cabeçalho dizendo o que é,
como usar e qual regra de design ele carrega.

## Componentes

### `ActionButton`

Unifica numa API só os três botões que o aplicativo mantinha separados — primário,
secundário e o spinner de carregamento.

```dart
ActionButton.primary(
  label: 'Praticar Nheengatu',
  icon: Icons.play_arrow,
  onPressed: () {},
)

ActionButton.secondary(
  label: 'Explorar a cultura indígena',
  size: ActionButtonSize.medium,
  fullWidth: false,
  onPressed: () {},
)
```

| Parâmetro | Tipo | Padrão | Papel |
|---|---|---|---|
| `label` | `String` | — | Texto do botão, em PT-BR |
| `icon` | `IconData?` | `null` | Ícone opcional à esquerda |
| `onPressed` | `VoidCallback?` | `null` | `null` desabilita o botão |
| `variant` | `ActionButtonVariant` | `primary` | `primary` preenchido · `secondary` outline |
| `size` | `ActionButtonSize` | `large` | `small` 40 · `medium` 48 · `large` 54 px |
| `isLoading` | `bool` | `false` | Troca o rótulo por um spinner e bloqueia o toque |
| `fullWidth` | `bool` | `true` | Ocupa toda a largura disponível |

> **Regra de uso:** no máximo **um botão primário por tela** (Lei de Hick). Os demais
> entram como secundários, para não competir por atenção. A tela de demonstração é a
> exceção declarada — ela existe justamente para exibir o catálogo inteiro.

### `TekohaTabBar`

Barra de navegação por abas. É um componente **controlado**: não guarda o índice atual,
recebe `currentIndex` e devolve `onTap`. O estado mora em quem usa, o que mantém uma
fonte única da verdade e torna a barra reaproveitável fora de um `Scaffold`.

```dart
TekohaTabBar(
  items: TekohaTabBar.defaultItems,   // Home · Aprenda · Cultura · Perfil
  currentIndex: _index,
  onTap: (i) => setState(() => _index = i),
)
```

A aba ativa se distingue por **três sinais somados** — ícone preenchido no lugar do
vazado, cor urucum e rótulo mais pesado. Quem não distingue bem cor ainda percebe a
mudança.

Para um conjunto próprio de abas, monte a lista com `TekohaTabItem`:

```dart
const TekohaTabItem(
  label: 'Cultura',
  icon: Icons.diversity_3_outlined,
  activeIcon: Icons.diversity_3,
)
```

### `TekohaListItem`

Um widget só cobre os quatro formatos de linha que o aplicativo usa em telas
diferentes — cartão de módulo, cartão de idioma, item bloqueado e linha de
estatística. O que muda entre eles é a variante; a estrutura é sempre a mesma.

```dart
TekohaListItem(
  leading: const TekohaListItemBadge.number(1),
  title: 'Cumprimentos e Interações',
  subtitle: 'O que você diz nos primeiros 30 segundos de uma conversa',
  trailing: const Icon(Icons.chevron_right),
  variant: TekohaListItemVariant.filled,
  onTap: () {},
)
```

| Parâmetro | Tipo | Padrão | Papel |
|---|---|---|---|
| `title` | `String` | — | Título da linha |
| `leading` | `Widget?` | `null` | Elemento à esquerda: badge, avatar ou ícone |
| `subtitle` | `String?` | `null` | Texto de apoio |
| `subtitleMaxLines` | `int?` | `2` | `null` deixa o subtítulo correr inteiro |
| `trailing` | `Widget?` | `null` | Elemento à direita: chevron, valor, cadeado |
| `onTap` | `VoidCallback?` | `null` | `null` remove o efeito de toque |
| `variant` | `TekohaListItemVariant` | `outlined` | `outlined` · `filled` · `muted` · `plain` |

O `trailing` **herda a cor da variante**: quem chama passa um `Icon` ou `Text` sem
cor e o contraste sai correto sobre qualquer fundo. É o detalhe que separa este
componente de um `ListTile` genérico.

Para o círculo à esquerda, `TekohaListItemBadge` oferece as duas formas que aparecem
nas mesmas listas, com o mesmo diâmetro para os títulos alinharem entre si:

```dart
const TekohaListItemBadge.number(1)
const TekohaListItemBadge.icon(Icons.check, background: AppColors.correct)
```

## Tokens de cor

Nenhum widget deste projeto declara `Color(0x...)` direto. Trocar a identidade visual
é trocar `lib/theme/app_colors.dart`.

| Token | Hex | Papel |
|---|---|---|
| `primary` | `#B5451B` | Urucum — marca, ações, aba ativa |
| `secondary` | `#2D6A4F` | Verde mata |
| `background` · `surface` | `#FFFFFF` | Respiro e legibilidade |
| `textPrimary` | `#1A1A1A` | Preto suave |
| `textSecondary` | `#6B6B6B` | Cinza médio, estados inativos |
| `border` | `#E0E0E0` | Molduras |
| `correct` | `#2E7D32` | Acerto |
| `disabled` | `#D4886A` | Urucum dessaturado |
| `disabledSurface` | `#F5F5F5` | Fundo de item indisponível em lista |
| `jenipapo` | `#1B2845` | Azul-noite |
| `caulim` | `#F5EBD8` | Branco-osso terroso |
| `argila` | `#A0522D` | Marrom argila |
| `floresta` | `#1F4E3D` | Verde mata profundo |
| `rio` | `#3D6FA8` | Azul rio |

A distribuição segue a proporção **60-30-10**: cerca de 60% de branco, 30% de urucum e
10% de cores de acento com uso semântico pontual. A paleta deriva de **pigmentos
naturais da Amazônia** — urucum, jenipapo, caulim, argila — e nunca de grafismos
étnico-específicos, cuidado ético registrado na pesquisa que originou o aplicativo.

## Como rodar

Pré-requisito: Flutter SDK 3.41 ou superior.

```bash
flutter pub get
```

```bash
flutter run
```

O projeto **não tem nenhuma dependência além do que o `flutter create` já traz**
(`cupertino_icons` e `flutter_lints`). Sem chaves, sem `.env`, sem serviço externo:
clonou, rodou.

## Qualidade

```bash
flutter analyze
```

```bash
flutter test
```

Análise estática sem issues e dez testes de widget passando — um arquivo por
componente, cobrindo o comportamento essencial: renderiza, o callback dispara, os
estados que bloqueiam a ação bloqueiam mesmo, e o estado ativo se distingue do
inativo. A suíte é deliberadamente enxuta: o artefato aqui é a vitrine visual, não a
cobertura.

## Como adicionar um componente novo

1. Crie o arquivo em `lib/components/common/`, com nome em `snake_case`.
2. Abra com um cabeçalho: o que é, como usar, qual regra de design ele carrega.
3. Leia as cores de `AppColors` e as medidas de `AppTheme` — nunca valores soltos.
4. Crie a tela `lib/pages/sample_<componente>_screen.dart`, com uma `routeName`
   estática, e registre a rota em `main.dart`.
5. Adicione o cartão no índice, em `sample_screen.dart`.
6. Escreva o arquivo de teste correspondente em `test/components/`.

## Relação com o aplicativo Tekohá

O **Tekohá** é um aplicativo de ensino gamificado de **Nheengatu**, a língua geral
amazônica, desenvolvido como pesquisa de Iniciação Científica em Engenharia de
Software, na linha de Direitos Humanos. Este design sample system extrai a linguagem
visual daquele aplicativo — paleta, medidas, regras de hierarquia — e a apresenta
isolada, componente a componente.

As decisões de design não são arbitrárias: cada uma é rastreável à literatura revisada
no registro científico da pesquisa. A regra de um botão primário por tela vem da Lei de
Hick; a paleta de pigmentos naturais, de Elliot & Maier (2014) somada ao cuidado ético
de Carneiro da Cunha (2009); a distinção da aba ativa por três sinais somados, de
acessibilidade básica de cor.

## Direitos autorais e uso

© 2026 Marcos Vinicius Muniz Arruda. Todos os direitos reservados.

Publicado para fins de avaliação acadêmica e portfólio. Não é concedida licença de
reprodução ou uso comercial sem autorização expressa do autor.

## Autor

**Marcos Vinicius Muniz Arruda** — desenvolvimento e design.

Estudante de Engenharia de Software · Centro Universitário Católica do Tocantins.

[github.com/Marcos-Codfy](https://github.com/Marcos-Codfy)

---

<div align="center">

*Tekohá — o lugar onde se vive a cultura.*

</div>
