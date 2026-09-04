// test/components/trail_node_test.dart
//
// Cobertura minima do TekohaTrailNode: os tres estados se distinguem, e o no
// travado nao navega mesmo recebendo onTap — a trava e do componente, nao de
// quem o usa.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tekoha_design_sample/components/trail_node.dart';

void main() {
  Widget host(Widget child) => MaterialApp(home: Scaffold(body: child));

  Widget node(TekohaTrailNodeState state, {VoidCallback? onTap}) {
    return TekohaTrailNode(
      title: 'Os pequenos',
      subtitle: '8 exercícios',
      number: 3,
      state: state,
      isLast: true,
      onTap: onTap,
    );
  }

  testWidgets('a etapa concluida traz visto e seta de repetir', (tester) async {
    await tester.pumpWidget(host(node(TekohaTrailNodeState.done)));

    expect(find.byIcon(Icons.check), findsOneWidget);
    expect(find.byIcon(Icons.replay_rounded), findsOneWidget);
  });

  testWidgets('a etapa atual traz o numero e a seta de avancar',
      (tester) async {
    await tester.pumpWidget(host(node(TekohaTrailNodeState.current)));

    expect(find.text('3'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_forward_rounded), findsOneWidget);
  });

  testWidgets('a etapa travada mostra cadeado e ignora o toque',
      (tester) async {
    var taps = 0;

    await tester.pumpWidget(host(
      node(TekohaTrailNodeState.locked, onTap: () => taps++),
    ));

    expect(find.byIcon(Icons.lock_outline), findsOneWidget);

    await tester.tap(find.text('Os pequenos'));
    expect(taps, 0);
  });
}
