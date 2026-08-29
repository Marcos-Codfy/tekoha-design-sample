// lib/pages/sample_chips_screen.dart
//
// Tela de demonstracao de TekohaChip e TekohaPill.
//
// As duas aparecem juntas de proposito: sao visualmente parecidas e servem a
// propositos opostos, e ver uma ao lado da outra e a forma mais rapida de
// entender quando usar cada uma.

import 'package:flutter/material.dart';

import '../components/common/chip.dart';
import '../components/common/texts.dart';
import '../theme/app_colors.dart';
import 'sample_section.dart';

class SampleChipsScreen extends StatefulWidget {
  const SampleChipsScreen({super.key});

  static const String routeName = '/chips';

  @override
  State<SampleChipsScreen> createState() => _SampleChipsScreenState();
}

class _SampleChipsScreenState extends State<SampleChipsScreen> {
  static const _categories = ['Curiosidades', 'História', 'Hábitos'];
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Chips e Pills')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 40),
        children: [
          const SampleIntro(
            'Duas peças parecidas com papéis opostos: o chip é controle, a '
            'pill é rótulo. Quem toca no chip filtra alguma coisa; a pill '
            'apenas informa um estado.',
          ),
          SampleSection(
            title: 'Chip de categoria',
            note: 'Filtro selecionável. O item ativo ganha fundo cheio e um '
                'visto — a seleção nunca depende só da cor.',
            children: [
              SampleSpec(
                code: 'TekohaChip(selected: ..., onTap: ...)',
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (var i = 0; i < _categories.length; i++)
                      TekohaChip(
                        label: _categories[i],
                        selected: i == _selected,
                        onTap: () => setState(() => _selected = i),
                      ),
                  ],
                ),
              ),
              const SampleSpec(
                code: 'onTap: null — inerte',
                child: TekohaChip(label: 'Cosmologia', selected: false),
              ),
              SampleSpec(
                code: 'selectedColor: AppColors.primary',
                child: TekohaChip(
                  label: 'Cumprimentos',
                  selected: true,
                  selectedColor: AppColors.primary,
                  onTap: () {},
                ),
              ),
            ],
          ),
          const SampleSection(
            title: 'Pill de estado',
            note: 'Rótulo compacto, não tocável. O fundo é o próprio tom a 10% '
                'de opacidade, então um tom novo não exige escolher um segundo '
                'hex.',
            children: [
              SampleSpec(
                code: 'tone: primary',
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TekohaPill(label: '+10 XP'),
                ),
              ),
              SampleSpec(
                code: 'tone: neutral · com ícone',
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TekohaPill(
                    label: 'Palavra nova',
                    icon: Icons.auto_awesome,
                    tone: TekohaPillTone.neutral,
                  ),
                ),
              ),
              SampleSpec(
                code: 'tone: success',
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TekohaPill(
                    label: 'Módulo concluído',
                    icon: Icons.check,
                    tone: TekohaPillTone.success,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          const TekohaPurposeText(
            'Cada palavra que você pratica é uma palavra que continua viva.',
          ),
        ],
      ),
    );
  }
}
