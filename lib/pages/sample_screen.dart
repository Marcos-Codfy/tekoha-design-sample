// lib/pages/sample_screen.dart
//
// Tela inicial do design system: o indice dos componentes. Cada cartao leva a
// tela de demonstracao do seu componente.
//
// O cartao abaixo e um widget privado de proposito. Na proxima fase ele da
// lugar ao componente ListItems, que e justamente a linha de lista com titulo,
// subtitulo e elemento a direita — a estrutura que estes cartoes ja usam.

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
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
          _ComponentCard(
            index: 1,
            title: 'Action Button',
            description: 'Botão de ação em duas variantes, três tamanhos e '
                'os estados de carregamento e desabilitado',
            onTap: () => Navigator.of(context)
                .pushNamed(SampleActionButtonScreen.routeName),
          ),
          const SizedBox(height: 12),
          _ComponentCard(
            index: 2,
            title: 'Tab Bar',
            description: 'Barra de navegação de quatro abas, com estado ativo '
                'marcado por ícone, cor e peso do rótulo',
            onTap: () =>
                Navigator.of(context).pushNamed(SampleTabBarScreen.routeName),
          ),
          const SizedBox(height: 12),
          const _ComponentCard(
            index: 3,
            title: 'List Items',
            description: 'Linha de lista com título, subtítulo e elemento à '
                'direita',
            hint: 'Próxima etapa',
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

/// Cartao de um componente do catalogo. Sem [onTap] ele fica em estado
/// bloqueado, com a dica no lugar da seta — o mesmo tratamento que o
/// aplicativo real da aos modulos ainda travados: visivel, nunca escondido.
class _ComponentCard extends StatelessWidget {
  final int index;
  final String title;
  final String description;
  final VoidCallback? onTap;
  final String? hint;

  const _ComponentCard({
    required this.index,
    required this.title,
    required this.description,
    this.onTap,
    this.hint,
  });

  bool get _isLocked => onTap == null;

  @override
  Widget build(BuildContext context) {
    final foreground =
        _isLocked ? AppColors.textSecondary : AppColors.textOnPrimary;

    return Material(
      color: _isLocked ? AppColors.caulim : AppColors.primary,
      borderRadius: BorderRadius.circular(AppTheme.cardRadius),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppTheme.cardRadius),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              _IndexBadge(index: index, isLocked: _isLocked),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: foreground,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.4,
                        color: foreground.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              if (_isLocked)
                Text(
                  hint ?? '',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                )
              else
                Icon(Icons.chevron_right, color: foreground),
            ],
          ),
        ),
      ),
    );
  }
}

/// Numero da ordem do componente, dentro de um circulo.
class _IndexBadge extends StatelessWidget {
  final int index;
  final bool isLocked;

  const _IndexBadge({required this.index, required this.isLocked});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      width: 44,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        shape: BoxShape.circle,
      ),
      child: Text(
        '$index',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: isLocked ? AppColors.textSecondary : AppColors.primary,
        ),
      ),
    );
  }
}
