// test/components/action_button_test.dart
//
// Cobertura minima do ActionButton: renderizacao, toque e os dois estados que
// bloqueiam a acao (desabilitado e carregando).

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tekoha_design_sample/components/action_button.dart';

void main() {
  Widget host(Widget child) => MaterialApp(home: Scaffold(body: child));

  testWidgets('exibe o rotulo e dispara onPressed no toque', (tester) async {
    var taps = 0;

    await tester.pumpWidget(host(
      ActionButton.primary(
        label: 'Praticar Nheengatu',
        onPressed: () => taps++,
      ),
    ));

    expect(find.text('Praticar Nheengatu'), findsOneWidget);

    await tester.tap(find.byType(ActionButton));
    expect(taps, 1);
  });

  testWidgets('nao dispara onPressed enquanto carrega', (tester) async {
    var taps = 0;

    await tester.pumpWidget(host(
      ActionButton.primary(
        label: 'Entrar',
        isLoading: true,
        onPressed: () => taps++,
      ),
    ));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Entrar'), findsNothing);

    await tester.tap(find.byType(ActionButton));
    expect(taps, 0);
  });

  testWidgets('fica desabilitado quando onPressed e nulo', (tester) async {
    await tester.pumpWidget(host(
      const ActionButton.primary(label: 'Proximo modulo'),
    ));

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, isNull);
  });

  testWidgets('variante secundaria renderiza como outline', (tester) async {
    await tester.pumpWidget(host(
      ActionButton.secondary(
        label: 'Explorar a cultura indígena',
        onPressed: () {},
      ),
    ));

    expect(find.byType(OutlinedButton), findsOneWidget);
    expect(find.byType(ElevatedButton), findsNothing);
  });
}
