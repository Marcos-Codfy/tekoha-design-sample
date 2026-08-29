// lib/pages/sample_screen.dart
//
// Tela inicial do design system: o indice dos componentes.
//
// As linhas do indice sao o proprio TekohaListItem, e os rotulos de grupo sao
// o proprio TekohaSectionLabel. O catalogo consome o que documenta — se um
// componente quebrar, a primeira tela do aplicativo quebra junto, e ninguem
// descobre tarde.
//
// O agrupamento por familia (acoes, navegacao, conteudo, exercicio, estados)
// nao veio do rascunho original, que previa uma tela por componente. Com onze
// componentes, uma lista corrida obrigaria a rolar procurando pelo nome; o
// agrupamento deixa achar pelo PAPEL, que e como se procura um componente na
// pratica.

import 'package:flutter/material.dart';

import '../components/common/list_items.dart';
import '../components/common/texts.dart';
import '../theme/app_colors.dart';
import 'sample_action_button_screen.dart';
import 'sample_chips_screen.dart';
import 'sample_lesson_screen.dart';
import 'sample_list_items_screen.dart';
import 'sample_states_screen.dart';
import 'sample_tab_bar_screen.dart';
import 'sample_trail_screen.dart';

class SampleScreen extends StatelessWidget {
  const SampleScreen({super.key});

  static const String routeName = '/';

  /// O catalogo, em ordem de leitura. Adicionar componente e acrescentar uma
  /// entrada aqui — a tela nao muda.
  static const List<_CatalogGroup> _catalog = [
    _CatalogGroup('Ações', [
      _CatalogEntry(
        'Action Button',
        'Duas variantes, três tamanhos e os estados de carregamento e '
            'desabilitado',
        SampleActionButtonScreen.routeName,
      ),
    ]),
    _CatalogGroup('Navegação', [
      _CatalogEntry(
        'Tab Bar',
        'Navegação de quatro abas, com o estado ativo marcado por ícone, cor '
            'e peso do rótulo',
        SampleTabBarScreen.routeName,
      ),
      _CatalogEntry(
        'Trail Node',
        'Nó de trilha vertical com círculo de status e linha conectora',
        SampleTrailScreen.routeName,
      ),
    ]),
    _CatalogGroup('Conteúdo', [
      _CatalogEntry(
        'List Items',
        'Quatro formatos de linha, com elemento à esquerda, título, subtítulo '
            'e elemento à direita',
        SampleListItemsScreen.routeName,
      ),
      _CatalogEntry(
        'Chips e Pills',
        'Filtro selecionável e rótulo de estado — parecidos por fora, opostos '
            'por dentro',
        SampleChipsScreen.routeName,
      ),
    ]),
    _CatalogGroup('Lição', [
      _CatalogEntry(
        'Exercício',
        'Barra de progresso, botão de áudio, alternativas e faixa de '
            'feedback, montados num exercício que funciona',
        SampleLessonScreen.routeName,
      ),
    ]),
    _CatalogGroup('Estados', [
      _CatalogEntry(
        'Estados e Textos',
        'Carregando, sem conteúdo, e os três textos que carregam intenção',
        SampleStatesScreen.routeName,
      ),
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    var index = 0;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Tekohá'),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 40),
        children: [
          const Text(
            'Design System',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Catálogo de componentes',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Os componentes reutilizáveis do aplicativo Tekohá, cada um com '
            'sua tela de demonstração. Um lugar só para ver, comparar e '
            'decidir qual usar.',
            style: TextStyle(
              fontSize: 15,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
          for (final group in _catalog) ...[
            const SizedBox(height: 32),
            TekohaSectionLabel(group.title),
            const SizedBox(height: 12),
            for (final entry in group.entries) ...[
              TekohaListItem(
                leading: TekohaListItemBadge.number(++index),
                title: entry.title,
                subtitle: entry.description,
                trailing: const Icon(Icons.chevron_right),
                variant: TekohaListItemVariant.filled,
                onTap: () => Navigator.of(context).pushNamed(entry.route),
              ),
              const SizedBox(height: 12),
            ],
          ],
          const SizedBox(height: 24),
          const TekohaPurposeText(
            'Cada palavra que você pratica é uma palavra que continua viva.',
          ),
        ],
      ),
    );
  }
}

/// Um grupo do catalogo — os componentes que compartilham um papel.
class _CatalogGroup {
  final String title;
  final List<_CatalogEntry> entries;

  const _CatalogGroup(this.title, this.entries);
}

/// Uma linha do catalogo.
class _CatalogEntry {
  final String title;
  final String description;
  final String route;

  const _CatalogEntry(this.title, this.description, this.route);
}
