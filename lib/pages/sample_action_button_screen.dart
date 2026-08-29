// lib/pages/sample_action_button_screen.dart
//
// Tela de demonstracao do componente ActionButton.
//
// NOTA DE DESIGN: o proprio design system prega "um botao primario por tela"
// (Lei de Hick). Esta tela quebra a regra de proposito — ela existe para
// exibir o catalogo completo de variantes lado a lado. Telas de produto devem
// seguir a regra.

import 'package:flutter/material.dart';

import '../components/common/action_button.dart';
import '../theme/app_colors.dart';

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
          const _Intro(
            'Botão de ação do Tekohá. Uma API única com variantes, no lugar '
            'de repetir ElevatedButton em cada tela.',
          ),
          _Section(
            title: 'Variantes',
            note: 'O peso visual define a hierarquia. Primário é a ação mais '
                'importante do contexto; secundário são as alternativas.',
            children: [
              _Spec(
                code: 'ActionButton.primary(...)',
                child: ActionButton.primary(
                  label: 'Praticar Nheengatu',
                  icon: Icons.play_arrow,
                  onPressed: () => _showFeedback(context, 'Praticar Nheengatu'),
                ),
              ),
              _Spec(
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
          _Section(
            title: 'Tamanhos',
            note: 'large em CTA de tela cheia, medium em blocos internos, '
                'small dentro de cards e barras compactas.',
            children: [
              _Spec(
                code: 'size: ActionButtonSize.large — 54 px',
                child: ActionButton.primary(
                  label: 'Próximo módulo',
                  onPressed: () => _showFeedback(context, 'Próximo módulo'),
                ),
              ),
              _Spec(
                code: 'size: ActionButtonSize.medium — 48 px',
                child: ActionButton.primary(
                  label: 'Próximo módulo',
                  size: ActionButtonSize.medium,
                  onPressed: () => _showFeedback(context, 'Próximo módulo'),
                ),
              ),
              _Spec(
                code: 'size: ActionButtonSize.small — 40 px',
                child: ActionButton.primary(
                  label: 'Próximo módulo',
                  size: ActionButtonSize.small,
                  onPressed: () => _showFeedback(context, 'Próximo módulo'),
                ),
              ),
            ],
          ),
          const _Section(
            title: 'Estados',
            note: 'Sem onPressed o botão desabilita sozinho. Com isLoading o '
                'rótulo dá lugar ao spinner e o toque é bloqueado.',
            children: [
              _Spec(
                code: 'onPressed: null — desabilitado',
                child: ActionButton.primary(label: 'Termine o módulo anterior'),
              ),
              _Spec(
                code: 'isLoading: true — primário',
                child: ActionButton.primary(label: 'Entrar', isLoading: true),
              ),
              _Spec(
                code: 'isLoading: true — secundário',
                child: ActionButton.secondary(
                  label: 'Sair da conta',
                  isLoading: true,
                ),
              ),
            ],
          ),
          _Section(
            title: 'Largura',
            note: 'O padrão ocupa toda a linha. Use fullWidth: false quando o '
                'botão dividir espaço com outro elemento.',
            children: [
              _Spec(
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

/// Paragrafo de abertura da tela de demonstracao.
class _Intro extends StatelessWidget {
  final String text;

  const _Intro(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 15,
          color: AppColors.textSecondary,
          height: 1.5,
        ),
      ),
    );
  }
}

/// Bloco tematico com titulo, explicacao e uma lista de exemplos.
class _Section extends StatelessWidget {
  final String title;
  final String note;
  final List<Widget> children;

  const _Section({
    required this.title,
    required this.note,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          note,
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.textSecondary,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 16),
        ...children,
      ],
    );
  }
}

/// Um exemplo do catalogo: o widget em cima, a chamada que o produz embaixo.
class _Spec extends StatelessWidget {
  final String code;
  final Widget child;

  const _Spec({required this.code, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          child,
          const SizedBox(height: 6),
          Text(
            code,
            style: const TextStyle(
              fontSize: 12,
              fontFamily: 'monospace',
              color: AppColors.argila,
            ),
          ),
        ],
      ),
    );
  }
}
