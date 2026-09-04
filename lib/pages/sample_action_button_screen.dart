// lib/pages/sample_action_button_screen.dart
//
// Tela de demonstracao do componente ActionButton.
//

import 'package:flutter/material.dart';

import '../components/common/action_button.dart';
import '../theme/app_colors.dart';
import 'sample_section.dart';

class SampleActionButtonScreen extends StatelessWidget {
  const SampleActionButtonScreen({super.key});

  static const String routeName = '/action-button';

  void _showFeedback(BuildContext context, String label) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('Você tocou em $label'),
          backgroundColor: AppColors.jenipapo,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Action Button')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 40),
        children: [
          const SampleIntro(
            'Botão de ação do Tekohá com suas Variantes.',
          ),
          SampleSection(
            title: 'Variantes',
            note: 'O peso visual define a hierarquia. Primário é a ação mais '
                'importante do contexto; secundário são as alternativas.',
            children: [
              SampleSpec(
                code: 'ActionButton.primary(...)',
                child: ActionButton.primary(
                  label: 'Praticar Nheengatu',
                  icon: Icons.play_arrow,
                  onPressed: () => _showFeedback(context, 'Praticar Nheengatu'),
                ),
              ),
              SampleSpec(
                code: 'ActionButton.secondary(...)',
                child: ActionButton.secondary(
                  label: 'Explorar a cultura indígena',
                  icon: Icons.diversity_3_outlined,
                  onPressed: () =>
                      _showFeedback(context, 'Explorar a cultura indígena'),
                ),
              ),
            ],
          ),
          SampleSection(
            title: 'Tamanhos',
            note: 'large em CTA de tela cheia, medium em blocos internos, '
                'small dentro de cards e barras compactas.',
            children: [
              SampleSpec(
                code: 'size: ActionButtonSize.large — 54 px',
                child: ActionButton.primary(
                  label: 'Próximo módulo',
                  onPressed: () => _showFeedback(context, 'Próximo módulo'),
                ),
              ),
              SampleSpec(
                code: 'size: ActionButtonSize.medium — 48 px',
                child: ActionButton.primary(
                  label: 'Próximo módulo',
                  size: ActionButtonSize.medium,
                  onPressed: () => _showFeedback(context, 'Próximo módulo'),
                ),
              ),
              SampleSpec(
                code: 'size: ActionButtonSize.small — 40 px',
                child: ActionButton.primary(
                  label: 'Próximo módulo',
                  size: ActionButtonSize.small,
                  onPressed: () => _showFeedback(context, 'Próximo módulo'),
                ),
              ),
            ],
          ),
          const SampleSection(
            title: 'Estados',
            note: 'Sem onPressed o botão desabilita sozinho. Com isLoading o '
                'rótulo dá lugar ao spinner e o toque é bloqueado.',
            children: [
              SampleSpec(
                code: 'onPressed: null — desabilitado',
                child: ActionButton.primary(label: 'Termine o módulo anterior'),
              ),
              SampleSpec(
                code: 'isLoading: true — primário',
                child: ActionButton.primary(label: 'Entrar', isLoading: true),
              ),
              SampleSpec(
                code: 'isLoading: true — secundário',
                child: ActionButton.secondary(
                  label: 'Sair da conta',
                  isLoading: true,
                ),
              ),
            ],
          ),
          SampleSection(
            title: 'Largura',
            note: 'O padrão ocupa toda a linha. Use fullWidth: false quando o '
                'botão dividir espaço com outro elemento.',
            children: [
              SampleSpec(
                code: 'fullWidth: false',
                child: Row(
                  children: [
                    ActionButton.secondary(
                      label: 'Cancelar',
                      size: ActionButtonSize.medium,
                      fullWidth: false,
                      onPressed: () => _showFeedback(context, 'Cancelar'),
                    ),
                    const SizedBox(width: 12),
                    ActionButton.primary(
                      label: 'Kuekatu!',
                      size: ActionButtonSize.medium,
                      fullWidth: false,
                      onPressed: () => _showFeedback(context, 'Kuekatu!'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
