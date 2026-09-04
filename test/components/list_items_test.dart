// test/components/list_items_test.dart
//
// Cobertura minima do TekohaListItem: renderizacao do conteudo, toque, e a
// heranca de cor do trailing — o comportamento que distingue este componente
// de um ListTile qualquer.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tekoha_design_sample/common/theme/app_colors.dart';
import 'package:tekoha_design_sample/components/list_items.dart';

void main() {
  Widget host(Widget child) => MaterialApp(home: Scaffold(body: child));

  testWidgets('exibe titulo, subtitulo e dispara onTap', (tester) async {
    var taps = 0;

    await tester.pumpWidget(host(
      TekohaListItem(
        leading: const TekohaListItemBadge.number(1),
        title: 'Cumprimentos e Interações',
        subtitle: 'O que você diz nos primeiros 30 segundos',
        trailing: const Icon(Icons.chevron_right),
        onTap: () => taps++,
      ),
    ));

    expect(find.text('Cumprimentos e Interações'), findsOneWidget);
    expect(find.text('O que você diz nos primeiros 30 segundos'),
        findsOneWidget);
    expect(find.text('1'), findsOneWidget);

    await tester.tap(find.byType(TekohaListItem));
    expect(taps, 1);
  });

  testWidgets('omite o subtitulo quando ele nao e informado', (tester) async {
    await tester.pumpWidget(host(
      const TekohaListItem(title: 'XP total', trailing: Text('528 XP')),
    ));

    expect(find.text('XP total'), findsOneWidget);
    expect(find.byType(Text), findsNWidgets(2));
  });

  testWidgets('o trailing herda a cor da variante', (tester) async {
    await tester.pumpWidget(host(
      const Column(
        children: [
          TekohaListItem(
            title: 'Natureza e Ambiente',
            trailing: Icon(Icons.lock_outline),
            variant: TekohaListItemVariant.filled,
          ),
          TekohaListItem(
            title: 'Nheengatu',
            trailing: Icon(Icons.chevron_right),
          ),
        ],
      ),
    ));

    final onFilled = tester.widget<Icon>(find.byIcon(Icons.lock_outline));
    final onOutlined = tester.widget<Icon>(find.byIcon(Icons.chevron_right));

    // Sem cor propria, o icone assume a cor legivel sobre o fundo da variante.
    expect(IconTheme.of(tester.element(find.byWidget(onFilled))).color,
        AppColors.textOnPrimary);
    expect(IconTheme.of(tester.element(find.byWidget(onOutlined))).color,
        AppColors.primary);
  });
}
