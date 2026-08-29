// lib/pages/sample_tab_bar_screen.dart
//
// Tela de demonstracao do componente TekohaTabBar.
//
// A barra aparece viva no rodape: tocar numa aba troca o conteudo do corpo,
// exatamente como no aplicativo real. Abaixo do conteudo fica um bloco
// estatico com os dois estados de uma aba, lado a lado, para inspecao.
//
// Como a TekohaTabBar e um componente controlado, o indice atual mora aqui, no
// State desta tela — nao dentro da barra.

import 'package:flutter/material.dart';

import '../components/common/tab_bar.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

class SampleTabBarScreen extends StatefulWidget {
  const SampleTabBarScreen({super.key});

  static const String routeName = '/tab-bar';

  @override
  State<SampleTabBarScreen> createState() => _SampleTabBarScreenState();
}

class _SampleTabBarScreenState extends State<SampleTabBarScreen> {
  int _currentIndex = 0;

  /// Uma previa de conteudo por aba, so para dar sentido a troca.
  static const List<_TabPreview> _previews = [
    _TabPreview(
      greeting: 'Puranga pituna!',
      title: 'Bem-vindo de volta, Marcos',
      body: 'Cada palavra que você pratica é uma palavra que continua viva.',
    ),
    _TabPreview(
      greeting: 'Trilha',
      title: 'Cumprimentos e Interações',
      body: 'O que você diz nos primeiros 30 segundos de uma conversa.',
    ),
    _TabPreview(
      greeting: 'Cultura',
      title: 'Nheengatu',
      body: 'Tronco Tupi · Alto Rio Negro. História, hábitos e curiosidades '
          'da língua.',
    ),
    _TabPreview(
      greeting: 'Perfil',
      title: '528 XP · 1 dia de sequência',
      body: '16 palavras aprendidas e 5 das 10 conquistas desbloqueadas.',
    ),
  ];

  void _selectTab(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final preview = _previews[_currentIndex];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Tab Bar')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
        children: [
          const Text(
            'Barra de navegação do Tekohá. Componente controlado: o índice '
            'ativo mora em quem usa, não dentro da barra.',
            style: TextStyle(
              fontSize: 15,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 28),
          _PreviewCard(preview: preview),
          const SizedBox(height: 8),
          Text(
            'currentIndex: $_currentIndex — toque nas abas do rodapé',
            style: const TextStyle(
              fontSize: 12,
              fontFamily: 'monospace',
              color: AppColors.argila,
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            'Estados de uma aba',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'A aba ativa troca o ícone vazado pelo preenchido, pinta de urucum '
            'e engrossa o rótulo. Três sinais somados, não um só — quem não '
            'distingue bem cor ainda percebe a mudança.',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 16),
          const _StatesRow(),
        ],
      ),
      bottomNavigationBar: TekohaTabBar(
        items: TekohaTabBar.defaultItems,
        currentIndex: _currentIndex,
        onTap: _selectTab,
      ),
    );
  }
}

/// Conteudo ficticio de uma aba, so para a troca ter efeito visivel.
class _TabPreview {
  final String greeting;
  final String title;
  final String body;

  const _TabPreview({
    required this.greeting,
    required this.title,
    required this.body,
  });
}

class _PreviewCard extends StatelessWidget {
  final _TabPreview preview;

  const _PreviewCard({required this.preview});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppTheme.cardRadius),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            preview.greeting,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            preview.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            preview.body,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

/// Duas barras estaticas de uma aba so, mostrando ativa e inativa juntas.
class _StatesRow extends StatelessWidget {
  const _StatesRow();

  static const _item = TekohaTabItem(
    label: 'Aprenda',
    icon: Icons.menu_book_outlined,
    activeIcon: Icons.menu_book,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StateSample(
            caption: 'Ativa — currentIndex: 0',
            child: TekohaTabBar(
              items: const [_item],
              currentIndex: 0,
              onTap: (_) {},
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _StateSample(
            caption: 'Inativa — currentIndex: 1',
            child: TekohaTabBar(
              items: const [_item],
              currentIndex: 1,
              onTap: (_) {},
            ),
          ),
        ),
      ],
    );
  }
}

class _StateSample extends StatelessWidget {
  final String caption;
  final Widget child;

  const _StateSample({required this.caption, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppTheme.cardRadius),
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(AppTheme.cardRadius),
            ),
            child: child,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          caption,
          style: const TextStyle(
            fontSize: 11,
            fontFamily: 'monospace',
            color: AppColors.argila,
          ),
        ),
      ],
    );
  }
}
