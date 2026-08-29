// lib/components/common/tab_bar.dart
//
// COMPONENTE: barra de navegacao por abas do design system do Tekoha.
//
// Reproduz a casca de navegacao do aplicativo real: quatro abas fixas, icone
// vazado quando inativa e preenchido quando ativa, urucum no item selecionado
// e cinza nos demais.
//
// E um componente CONTROLADO: ele nao guarda o indice atual. Quem usa passa
// [currentIndex] e recebe [onTap]. Isso mantem o estado numa fonte unica e
// deixa a barra testavel e reaproveitavel fora de um Scaffold.
//
// USO:
//   TekohaTabBar(
//     items: TekohaTabBar.defaultItems,
//     currentIndex: _index,
//     onTap: (i) => setState(() => _index = i),
//   )

import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Uma aba da [TekohaTabBar].
class TekohaTabItem {
  /// Rotulo curto, em PT-BR. Uma palavra sempre que possivel.
  final String label;

  /// Icone exibido quando a aba esta inativa (versao vazada).
  final IconData icon;

  /// Icone exibido quando a aba esta ativa (versao preenchida).
  final IconData activeIcon;

  const TekohaTabItem({
    required this.label,
    required this.icon,
    required this.activeIcon,
  });
}

class TekohaTabBar extends StatelessWidget {
  /// As abas, na ordem de exibicao. De 2 a 5 itens — acima disso o alvo de
  /// toque fica pequeno demais.
  final List<TekohaTabItem> items;

  /// Indice da aba ativa.
  final int currentIndex;

  /// Chamado com o indice tocado.
  final ValueChanged<int> onTap;

  const TekohaTabBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
  });

  /// As quatro abas do aplicativo Tekoha, prontas para uso.
  static const List<TekohaTabItem> defaultItems = [
    TekohaTabItem(
      label: 'Home',
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
    ),
    TekohaTabItem(
      label: 'Aprenda',
      icon: Icons.menu_book_outlined,
      activeIcon: Icons.menu_book,
    ),
    TekohaTabItem(
      // diversity_3 simboliza povo e comunidade — mais semantico para
      // "Cultura" do que o icone de livro.
      label: 'Cultura',
      icon: Icons.diversity_3_outlined,
      activeIcon: Icons.diversity_3,
    ),
    TekohaTabItem(
      label: 'Perfil',
      icon: Icons.person_outline,
      activeIcon: Icons.person,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 62,
          child: Row(
            children: [
              for (var i = 0; i < items.length; i++)
                Expanded(
                  child: _TabSlot(
                    item: items[i],
                    isActive: i == currentIndex,
                    onTap: () => onTap(i),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TabSlot extends StatelessWidget {
  final TekohaTabItem item;
  final bool isActive;
  final VoidCallback onTap;

  const _TabSlot({
    required this.item,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppColors.primary : AppColors.textSecondary;

    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isActive ? item.activeIcon : item.icon,
            color: color,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            item.label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
