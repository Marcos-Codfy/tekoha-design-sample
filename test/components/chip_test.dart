// test/components/chip_test.dart
//
// Cobertura minima de TekohaChip e TekohaPill: selecao, estado inerte e o
// sinal redundante do visto — que e a parte de acessibilidade e a mais facil
// de alguem remover sem perceber.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tekoha_design_sample/components/common/chip.dart';

void main() {
  Widget host(Widget child) => MaterialApp(home: Scaffold(body: child));

  testWidgets('o chip selecionado mostra o visto alem da cor', (tester) async {
    await tester.pumpWidget(host(
      Column(
        children: [
          TekohaChip(label: 'Curiosidades', selected: true, onTap: () {}),
          TekohaChip(label: 'História', selected: false, onTap: () {}),
        ],
      ),
    ));

    expect(find.byIcon(Icons.check), findsOneWidget);
  });

  testWidgets('o chip dispara onTap', (tester) async {
    var taps = 0;

    await tester.pumpWidget(host(
      TekohaChip(label: 'Hábitos', selected: false, onTap: () => taps++),
    ));

    await tester.tap(find.byType(TekohaChip));
    expect(taps, 1);
  });

  testWidgets('o chip sem onTap fica inerte', (tester) async {
    await tester.pumpWidget(host(
      const TekohaChip(label: 'Cosmologia', selected: false),
    ));

    final inkWell = tester.widget<InkWell>(find.byType(InkWell));
    expect(inkWell.onTap, isNull);
  });

  testWidgets('a pill exibe rotulo e icone', (tester) async {
    await tester.pumpWidget(host(
      const TekohaPill(
        label: 'Palavra nova',
        icon: Icons.auto_awesome,
        tone: TekohaPillTone.neutral,
      ),
    ));

    expect(find.text('Palavra nova'), findsOneWidget);
    expect(find.byIcon(Icons.auto_awesome), findsOneWidget);
  });
}
