// lib/screens/sample_trail_screen.dart
//
// Tela de demonstracao do TekohaTrailNode.
//
// Diferente das outras demos, esta nao lista estados soltos: monta a trilha
// inteira. O componente so faz sentido em sequencia — a linha conectora, que e
// a razao dele existir, nao aparece num no isolado.

import 'package:flutter/material.dart';

import '../common/theme/app_colors.dart';
import '../components/chip.dart';
import '../components/texts.dart';
import '../components/trail_node.dart';
import 'sample_section.dart';

class SampleTrailScreen extends StatelessWidget {
  const SampleTrailScreen({super.key});

  static const _stages = [
    ('Eu, você, ele', '12 exercícios', TekohaTrailNodeState.done),
    ('Quem é quem', '12 exercícios', TekohaTrailNodeState.done),
    ('Os pequenos', '8 exercícios', TekohaTrailNodeState.current),
    ('Laços', 'Termine a etapa anterior', TekohaTrailNodeState.locked),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Trail Node')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 40),
        children: [
          const SampleIntro(
            'Nó de uma trilha vertical. É um item de lista com um círculo de '
            'status e a linha que liga um nó ao próximo — a linha é o que '
            'transforma quatro cartões soltos num caminho.',
          ),
          SampleSection(
            title: 'A trilha completa',
            note: 'Os três estados em sequência. A linha já percorrida fica '
                'verde e a que falta, cinza: o próprio conector vira barra de '
                'progresso.',
            children: [
              SampleSpec(
                code: 'isLast: i == stages.length - 1',
                child: Column(
                  children: [
                    for (var i = 0; i < _stages.length; i++)
                      TekohaTrailNode(
                        title: _stages[i].$1,
                        subtitle: _stages[i].$2,
                        number: i + 1,
                        state: _stages[i].$3,
                        isLast: i == _stages.length - 1,
                        onTap: () {},
                      ),
                  ],
                ),
              ),
            ],
          ),
          const SampleSection(
            title: 'Os estados isolados',
            note: 'Concluída traz o visto e a seta de repetir; a atual ganha '
                'borda grossa, sombra e a seta de avançar; a travada mostra o '
                'cadeado e a condição de desbloqueio.',
            children: [
              SampleSpec(
                code: 'state: done',
                child: TekohaTrailNode(
                  title: 'A palavra curinga',
                  subtitle: '12 exercícios',
                  number: 1,
                  state: TekohaTrailNodeState.done,
                  isLast: true,
                ),
              ),
              SampleSpec(
                code: 'state: current',
                child: TekohaTrailNode(
                  title: 'O encontro',
                  subtitle: '12 exercícios',
                  number: 2,
                  state: TekohaTrailNodeState.current,
                  isLast: true,
                ),
              ),
              SampleSpec(
                code: 'state: locked — onTap é ignorado',
                child: TekohaTrailNode(
                  title: 'Gratidão e despedida',
                  subtitle: 'Termine a etapa anterior',
                  number: 3,
                  state: TekohaTrailNodeState.locked,
                  isLast: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Center(
            child: TekohaPill(
              label: 'Trilha completa!',
              icon: Icons.emoji_events,
              tone: TekohaPillTone.success,
            ),
          ),
          const SizedBox(height: 16),
          const TekohaPurposeText(
            'Você deu voz a mais palavras do Nheengatu.',
          ),
        ],
      ),
    );
  }
}
