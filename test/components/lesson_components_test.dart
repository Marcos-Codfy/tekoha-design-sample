// test/components/lesson_components_test.dart
//
// Cobertura minima dos componentes de exercicio.
//
// O foco esta nas duas regras de produto que vivem dentro deles e que um
// refactor descuidado apagaria sem quebrar nada visivelmente: a partida doada
// da barra de progresso e o recuo da meta no rotulo.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tekoha_design_sample/components/common/banner.dart';
import 'package:tekoha_design_sample/components/common/option_button.dart';
import 'package:tekoha_design_sample/components/common/progress_bar.dart';

void main() {
  Widget host(Widget child) => MaterialApp(home: Scaffold(body: child));

  group('TekohaProgressBar', () {
    testWidgets('nunca comeca vazia', (tester) async {
      await tester.pumpWidget(host(const TekohaProgressBar(value: 0)));

      final bar = tester.widget<LinearProgressIndicator>(
        find.byType(LinearProgressIndicator),
      );
      expect(bar.value, greaterThan(0));
    });

    test('o rotulo conta o que falta perto da meta', () {
      expect(
        TekohaProgressBar.stepLabel(current: 2, total: 8),
        'Exercício 2 de 8',
      );
      expect(
        TekohaProgressBar.stepLabel(current: 6, total: 8),
        'Faltam 2 — você está quase lá!',
      );
      expect(
        TekohaProgressBar.stepLabel(current: 8, total: 8),
        'Último exercício!',
      );
    });
  });

  testWidgets('a alternativa certa e a errada usam icones distintos',
      (tester) async {
    await tester.pumpWidget(host(
      const Column(
        children: [
          TekohaOptionButton(
            label: 'Menino',
            state: TekohaOptionState.correct,
          ),
          TekohaOptionButton(
            label: 'Mulher',
            state: TekohaOptionState.wrong,
          ),
          TekohaOptionButton(label: 'Ele / Ela'),
        ],
      ),
    ));

    expect(find.byIcon(Icons.check_circle), findsOneWidget);
    // Seta de repeticao, nao um X: o erro convida a tentar de novo.
    expect(find.byIcon(Icons.refresh), findsOneWidget);
    expect(find.text('Ele / Ela'), findsOneWidget);
  });

  testWidgets('o banner de erro usa coracao, nao simbolo de falha',
      (tester) async {
    await tester.pumpWidget(host(
      const TekohaBanner(
        message: 'Quase lá! A resposta certa é: Menino',
        tone: TekohaBannerTone.error,
      ),
    ));

    expect(find.byIcon(Icons.favorite), findsOneWidget);
    expect(find.byIcon(Icons.close), findsNothing);
  });

  testWidgets('o banner mostra detalhe e acao quando informados',
      (tester) async {
    await tester.pumpWidget(host(
      const TekohaBanner(
        message: 'Boa! +10 XP',
        detail: 'Pronúncia: Ku-ru-mi',
        tone: TekohaBannerTone.success,
        action: TekohaNoteCard(text: 'Curiosidade cultural.'),
      ),
    ));

    expect(find.text('Boa! +10 XP'), findsOneWidget);
    expect(find.text('Pronúncia: Ku-ru-mi'), findsOneWidget);
    expect(find.byType(TekohaNoteCard), findsOneWidget);
  });
}
