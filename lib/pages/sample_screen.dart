// lib/pages/sample_screen.dart
//
// Tela inicial do design system: o indice dos componentes. Cada linha leva a
// tela de demonstracao do seu componente.
//
// As linhas do indice sao o proprio TekohaListItem. O catalogo consome o que
// documenta — se o componente quebrar, a primeira tela do aplicativo quebra
// junto, e ninguem descobre tarde.

import 'package:flutter/material.dart';

import '../components/common/list_items.dart';
import '../theme/app_colors.dart';
import 'sample_action_button_screen.dart';
import 'sample_tab_bar_screen.dart';

class SampleScreen extends StatelessWidget {
  const SampleScreen({super.key});

  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
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
          const SizedBox(height: 32),
          const _SectionLabel('Componentes'),
          const SizedBox(height: 12),
          TekohaListItem(
            leading: const TekohaListItemBadge.number(1),
            title: 'Action Button',
            subtitle: 'Duas variantes, três tamanhos e os estados de '
                'carregamento e desabilitado',
            trailing: const Icon(Icons.chevron_right),
            variant: TekohaListItemVariant.filled,
            onTap: () => Navigator.of(context)
                .pushNamed(SampleActionButtonScreen.routeName),
          ),
          const SizedBox(height: 12),
          TekohaListItem(
            leading: const TekohaListItemBadge.number(2),
            title: 'Tab Bar',
            subtitle: 'Navegação de quatro abas, com o estado ativo marcado '
                'por ícone, cor e peso do rótulo',
            trailing: const Icon(Icons.chevron_right),
            variant: TekohaListItemVariant.filled,
            onTap: () =>
                Navigator.of(context).pushNamed(SampleTabBarScreen.routeName),
          ),
          const SizedBox(height: 12),
          const TekohaListItem(
            leading: TekohaListItemBadge.number(
              3,
              foreground: AppColors.textSecondary,
            ),
            title: 'List Items',
            subtitle: 'Linha de lista com título, subtítulo e elemento à '
                'direita',
            trailing: Text('Próxima etapa'),
            variant: TekohaListItemVariant.muted,
          ),
        ],
      ),
    );
  }
}

/// Rotulo de bloco: menor, peso medio, cor secundaria. Sinaliza o grupo sem
/// competir com o conteudo.
class _SectionLabel extends StatelessWidget {
  final String text;

  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textSecondary,
      ),
    );
  }
}
