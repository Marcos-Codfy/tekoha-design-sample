// lib/components/common/progress_bar.dart
//
// COMPONENTE: barra de progresso de uma sequencia de passos.
//
// Duas decisoes de produto estao embutidas aqui, e e por isso que o componente
// existe em vez de um LinearProgressIndicator cru em cada tela:
//
//   1. PARTIDA DOADA — a barra nunca comeca vazia. Mesmo no primeiro passo ela
//      mostra ~5% preenchidos. Progresso artificial no inicio aumenta a taxa
//      de conclusao; uma barra em zero parece um caminho que ainda nem
//      comecou. So a REPRESENTACAO muda: [value] continua sendo o progresso
//      real e nenhuma contagem e afetada.
//
//   2. RECUO DA META — o rotulo troca de "Exercício 6 de 8" para "Faltam 2 —
//      você está quase lá!" perto do fim. O esforco acelera quando a meta fica
//      visivel, e contar o que falta torna a meta mais visivel do que contar o
//      que ja passou.

import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class TekohaProgressBar extends StatelessWidget {
  /// Progresso real, de 0 a 1.
  final double value;

  /// Texto acima da barra. Use [TekohaProgressBar.stepLabel] para obter o
  /// rotulo com recuo da meta ja pronto.
  final String? label;

  /// Fracao doada no inicio. Zero desliga o efeito.
  final double endowedStart;

  const TekohaProgressBar({
    super.key,
    required this.value,
    this.label,
    this.endowedStart = 0.05,
  });

  /// Monta o rotulo de progresso a partir da posicao na sequencia.
  ///
  /// `current` e 1-indexado. Devolve "Último exercício!" no fim, "Faltam N"
  /// quando restam duas ou menos, e a contagem normal no resto do caminho.
  static String stepLabel({
    required int current,
    required int total,
    String noun = 'Exercício',
  }) {
    final remaining = total - current;
    if (remaining <= 0) return 'Último ${noun.toLowerCase()}!';
    if (remaining <= 2) return 'Faltam $remaining — você está quase lá!';
    return '$noun $current de $total';
  }

  @override
  Widget build(BuildContext context) {
    final displayed = endowedStart + (value.clamp(0, 1) * (1 - endowedStart));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LinearProgressIndicator(
          value: displayed,
          minHeight: 6,
          backgroundColor: AppColors.border,
          valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
        ),
        if (label != null && label!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(
              label!,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }
}
