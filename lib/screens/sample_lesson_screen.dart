// lib/screens/sample_lesson_screen.dart
//
// Tela de demonstracao dos componentes de exercicio: barra de progresso, botao
// de audio, alternativa e faixa de feedback.
//
// Aqui os componentes aparecem em uso conjunto, e nao apenas em catalogo: a
// segunda metade da tela monta um exercicio funcional. Um exercicio de verdade
// mostra coisas que a lista de estados nao mostra — que o feedback aparece
// depois da resposta, que a alternativa errada volta a ficar disponivel, que a
// barra avanca.

import 'package:flutter/material.dart';

import '../common/theme/app_colors.dart';
import '../components/action_button.dart';
import '../components/banner.dart';
import '../components/chip.dart';
import '../components/option_button.dart';
import '../components/play_button.dart';
import '../components/progress_bar.dart';
import '../components/texts.dart';
import 'sample_section.dart';

class SampleLessonScreen extends StatefulWidget {
  const SampleLessonScreen({super.key});

  @override
  State<SampleLessonScreen> createState() => _SampleLessonScreenState();
}

class _SampleLessonScreenState extends State<SampleLessonScreen> {
  static const _options = ['Família / Parente', 'Mulher', 'Menino', 'Ele / Ela'];
  static const _correctIndex = 2;
  static const _totalExercises = 8;

  int? _chosen;
  bool _isPlaying = false;
  int _current = 1;

  bool get _answered => _chosen == _correctIndex;

  void _choose(int index) {
    setState(() => _chosen = index);
    if (index == _correctIndex) return;
    // A alternativa errada volta ao normal sozinha: errar libera nova
    // tentativa em vez de encerrar o exercicio.
    Future.delayed(const Duration(milliseconds: 900), () {
      if (mounted && _chosen == index) setState(() => _chosen = null);
    });
  }

  void _advance() {
    setState(() {
      _chosen = null;
      _current = _current >= _totalExercises ? 1 : _current + 1;
    });
  }

  TekohaOptionState _stateOf(int index) {
    if (_chosen != index) return TekohaOptionState.idle;
    return index == _correctIndex
        ? TekohaOptionState.correct
        : TekohaOptionState.wrong;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Exercício'),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Center(child: TekohaPill(label: '+10 XP')),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 40),
        children: [
          const SampleIntro(
            'Os componentes da tela de exercício. Abaixo do catálogo eles '
            'aparecem montados num exercício que funciona de verdade.',
          ),
          SampleSection(
            title: 'Barra de progresso',
            note: 'Nunca começa vazia: mesmo no primeiro passo mostra 5% '
                'preenchidos. Perto do fim, o rótulo passa a contar o que '
                'falta em vez do que já passou.',
            children: [
              const SampleSpec(
                code: 'Note que a barra não está vazia',
                child: TekohaProgressBar(
                  value: 0,
                  label: 'Exercício 1 de 8',
                ),
              ),
              SampleSpec(
                code: 'TekohaProgressBar.stepLabel(current: 6, total: 8)',
                child: TekohaProgressBar(
                  value: 6 / 8,
                  label: TekohaProgressBar.stepLabel(current: 6, total: 8),
                ),
              ),
              SampleSpec(
                code: 'TekohaProgressBar.stepLabel(current: 8, total: 8)',
                child: TekohaProgressBar(
                  value: 1,
                  label: TekohaProgressBar.stepLabel(current: 8, total: 8),
                ),
              ),
            ],
          ),
          SampleSection(
            title: 'Botão de áudio',
            note: 'O único elemento grande que não é urucum. O azul rio marca '
                'som como família própria, e o pulso confirma que o áudio '
                'está saindo.',
            children: [
              SampleSpec(
                code: 'isPlaying: $_isPlaying — toque para alternar',
                child: Center(
                  child: TekohaPlayButton(
                    isPlaying: _isPlaying,
                    onTap: () => setState(() => _isPlaying = !_isPlaying),
                  ),
                ),
              ),
              const SampleSpec(
                code: 'size: 64 — versão compacta',
                child: Center(child: TekohaPlayButton(size: 64)),
              ),
            ],
          ),
          const SampleSection(
            title: 'Alternativas',
            note: 'No máximo quatro por exercício: o tempo de decisão cresce '
                'com o número de opções. A borda engrossa no estado. '
                '',
            children: [
              SampleSpec(
                code: 'state: idle',
                child: TekohaOptionButton(label: 'Família / Parente'),
              ),
              SampleSpec(
                code: 'state: correct',
                child: TekohaOptionButton(
                  label: 'Menino',
                  state: TekohaOptionState.correct,
                ),
              ),
              SampleSpec(
                code: 'state: wrong',
                child: TekohaOptionButton(
                  label: 'Mulher',
                  state: TekohaOptionState.wrong,
                ),
              ),
            ],
          ),
          const SampleSection(
            title: 'Faixa de feedback',
            note: 'O erro usa coração, não um X. O aplicativo não pune quem '
                'erra, e o ícone precisa dizer isso antes do texto.',
            children: [
              SampleSpec(
                code: 'tone: success',
                child: TekohaBanner(
                  message: 'Boa! +10 XP',
                  detail: 'Pronúncia: Ku-ru-mi',
                  tone: TekohaBannerTone.success,
                ),
              ),
              SampleSpec(
                code: 'tone: error · com nota cultural embutida',
                child: TekohaBanner(
                  message: 'Quase lá! A resposta certa é: Menino',
                  tone: TekohaBannerTone.error,
                  action: TekohaNoteCard(
                    text: 'Palavra que o português brasileiro adotou: '
                        '"curumim". Exemplo direto de como o Nheengatu moldou '
                        'o nosso vocabulário.',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          const TekohaSectionLabel('Tudo junto'),
          const SizedBox(height: 12),
          _LiveExercise(
            current: _current,
            total: _totalExercises,
            options: _options,
            stateOf: _stateOf,
            onChoose: _choose,
            answered: _answered,
            onAdvance: _advance,
          ),
        ],
      ),
    );
  }
}

/// Um exercicio montado com os componentes acima, funcionando de verdade.
class _LiveExercise extends StatelessWidget {
  final int current;
  final int total;
  final List<String> options;
  final TekohaOptionState Function(int) stateOf;
  final ValueChanged<int> onChoose;
  final bool answered;
  final VoidCallback onAdvance;

  const _LiveExercise({
    required this.current,
    required this.total,
    required this.options,
    required this.stateOf,
    required this.onChoose,
    required this.answered,
    required this.onAdvance,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TekohaProgressBar(
            value: current / total,
            label: TekohaProgressBar.stepLabel(current: current, total: total),
          ),
          const SizedBox(height: 20),
          const Text(
            'Ouça e escolha a tradução',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          const Center(child: TekohaPlayButton(size: 64)),
          const SizedBox(height: 20),
          for (var i = 0; i < options.length; i++) ...[
            TekohaOptionButton(
              label: options[i],
              state: stateOf(i),
              onTap: answered ? null : () => onChoose(i),
            ),
            const SizedBox(height: 10),
          ],
          if (answered) ...[
            const SizedBox(height: 6),
            TekohaBanner(
              message: 'Boa! +10 XP',
              detail: 'Pronúncia: Ku-ru-mi',
              tone: TekohaBannerTone.success,
              action: ActionButton.primary(
                label: 'Continuar',
                size: ActionButtonSize.medium,
                onPressed: onAdvance,
              ),
            ),
          ] else
            const TekohaEncouragementText('Toque no áudio e escolha.'),
        ],
      ),
    );
  }
}
