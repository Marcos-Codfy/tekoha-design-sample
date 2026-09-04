// lib/components/common/chip.dart
//
// Elas parecem iguais e fazem coisas opostas, entao sao classes separadas de
// proposito:
//   - [TekohaChip] e CONTROLE — o usuario toca para filtrar. Tem estado
//     selecionado.
//   - [TekohaPill] e ROTULO — comunica um estado do sistema. Nao se toca.
//
// Fundir as duas numa so obrigaria a passar `selectable: false` toda vez que a
// intencao fosse apenas rotular, e um dia alguem passaria `onTap` num rotulo.

import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Filtro selecionavel. Usado nas categorias da aba Cultura
/// (Curiosidades · História · Hábitos).
class TekohaChip extends StatelessWidget {
  final String label;
  final bool selected;

  /// `null` deixa o chip inerte e apagado.
  final VoidCallback? onTap;

  /// Cor de fundo quando selecionado. O verde floresta e o padrao porque a
  /// aba Cultura usa verde para nao competir com o urucum da trilha.
  final Color selectedColor;

  const TekohaChip({
    super.key,
    required this.label,
    required this.selected,
    this.onTap,
    this.selectedColor = AppColors.floresta,
  });

  bool get _isEnabled => onTap != null;

  @override
  Widget build(BuildContext context) {
    final Color background;
    final Color foreground;
    final Color border;

    if (!_isEnabled) {
      background = AppColors.disabledSurface;
      foreground = AppColors.textSecondary;
      border = AppColors.border;
    } else if (selected) {
      background = selectedColor;
      foreground = AppColors.textOnPrimary;
      border = selectedColor;
    } else {
      background = AppColors.surface;
      foreground = AppColors.textPrimary;
      border = AppColors.border;
    }

    return Material(
      color: background,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: border),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // O check duplica o sinal da cor: selecao nao pode depender so
              // de cor para ser percebida.
              if (selected) ...[
                Icon(Icons.check, size: 16, color: foreground),
                const SizedBox(width: 6),
              ],
              Text(
                label,
                style: TextStyle(
                  color: foreground,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Tom semantico de uma [TekohaPill].
enum TekohaPillTone {
  ///  XP ganho, modo de demonstracao.
  primary,

  /// Cinza. Informacao de contexto que nao e conquista nem alerta —
  /// o selo "Palavra nova", por exemplo.
  neutral,

  /// Verde. Confirmacao compacta.
  success,
}

/// Rotulo compacto de estado. Nao e tocavel: se o usuario precisa agir,
/// o componente certo e [TekohaChip] ou um botao.
class TekohaPill extends StatelessWidget {
  final String label;
  final IconData? icon;
  final TekohaPillTone tone;

  const TekohaPill({
    super.key,
    required this.label,
    this.icon,
    this.tone = TekohaPillTone.primary,
  });

  Color get _accent => switch (tone) {
        TekohaPillTone.primary => AppColors.primary,
        TekohaPillTone.neutral => AppColors.textSecondary,
        TekohaPillTone.success => AppColors.correct,
      };

  @override
  Widget build(BuildContext context) {
    final accent = _accent;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        // O fundo e o proprio acento a 10% de opacidade: um tom so gera a
        // pilula inteira, e um tom novo nao exige escolher um segundo hex.
        color: accent.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: accent.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 16, color: accent),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: TextStyle(
              color: accent,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
