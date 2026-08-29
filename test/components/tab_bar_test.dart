// test/components/tab_bar_test.dart
//
// Cobertura minima da TekohaTabBar: as abas aparecem, o toque devolve o indice
// certo e a aba ativa se distingue visualmente das demais.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tekoha_design_sample/components/common/tab_bar.dart';
import 'package:tekoha_design_sample/theme/app_colors.dart';

void main() {
  Widget host({required int currentIndex, required ValueChanged<int> onTap}) {
    return MaterialApp(
      home: Scaffold(
        bottomNavigationBar: TekohaTabBar(
          items: TekohaTabBar.defaultItems,
          currentIndex: currentIndex,
          onTap: onTap,
        ),
      ),
    );
  }

  testWidgets('renderiza as quatro abas do aplicativo', (tester) async {
    await tester.pumpWidget(host(currentIndex: 0, onTap: (_) {}));

    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Aprenda'), findsOneWidget);
    expect(find.text('Cultura'), findsOneWidget);
    expect(find.text('Perfil'), findsOneWidget);
  });

  testWidgets('o toque devolve o indice da aba tocada', (tester) async {
    int? tapped;

    await tester.pumpWidget(host(currentIndex: 0, onTap: (i) => tapped = i));
    await tester.tap(find.text('Cultura'));

    expect(tapped, 2);
  });

  testWidgets('a aba ativa usa urucum e o icone preenchido', (tester) async {
    await tester.pumpWidget(host(currentIndex: 1, onTap: (_) {}));

    final active = tester.widget<Text>(find.text('Aprenda'));
    expect(active.style?.color, AppColors.primary);

    final inactive = tester.widget<Text>(find.text('Home'));
    expect(inactive.style?.color, AppColors.textSecondary);

    expect(find.byIcon(Icons.menu_book), findsOneWidget);
    expect(find.byIcon(Icons.home_outlined), findsOneWidget);
  });
}
