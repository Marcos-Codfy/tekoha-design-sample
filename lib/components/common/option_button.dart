// lib/components/common/option_button.dart
//
// COMPONENTE: alternativa de exercicio.
//
// Nao e um [ActionButton]. Um botao de acao executa; uma alternativa e
// ESCOLHIDA e depois avaliada — por isso ela tem os estados `correct` e
// `wrong`, que nenhum botao de acao tem. Reaproveitar o ActionButton aqui
// obrigaria a enfiar semantica de resposta num componente de acao.
//
// A regra do projeto e no maximo quatro alternativas por exercicio: o tempo de
// decisao cresce com o numero de opcoes (Lei de Hick-Hyman), e a lista longa
// vira leitura em vez de escolha.

import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart';

/// Situacao da alternativa no momento do desenho.
enum TekohaOptionState {
  /// Ainda nao respondida.
  idle,

  /// Escolhida e certa.
  correct,

  /// Escolhida e errada. O aplicativo devolve a opcao ao estado `idle`
  /// depois de um instante — errar nao encerra a tentativa.
  wrong,
}

class TekohaOptionButton extends StatelessWidget {
  final String label;
  final TekohaOptionState state;
  final VoidCallback? onTap;

  const TekohaOptionButton({
    super.key,
    required this.label,
    this.state = TekohaOptionState.idle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final (background, foreground, border, icon) = switch (state) {
      TekohaOptionState.idle => (
          AppColors.surface,
          AppColors.textPrimary,
          AppColors.border,
          null,
        ),
      TekohaOptionState.correct => (
          AppColors.correct.withValues(alpha: 0.12),
          AppColors.correct,
          AppColors.correct,
          Icons.check_circle,
        ),
      TekohaOptionState.wrong => (
          AppColors.wrong.withValues(alpha: 0.1),
          AppColors.wrong,
          AppColors.wrong,
          // Seta de repeticao, nao um "X": comunica "tente de novo", nao
          // "voce falhou".
          Icons.refresh,
        ),
    };

    return Material(
      color: background,
      borderRadius: BorderRadius.circular(AppTheme.cardRadius),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppTheme.cardRadius),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppTheme.cardRadius),
            border: Border.all(
              color: border,
              // A borda engrossa no estado respondido: o resultado se percebe
              // pela espessura antes mesmo da cor.
              width: state == TekohaOptionState.idle ? 1.2 : 2,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: foreground,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (icon != null) Icon(icon, color: foreground, size: 22),
            ],
          ),
        ),
      ),
    );
  }
}
