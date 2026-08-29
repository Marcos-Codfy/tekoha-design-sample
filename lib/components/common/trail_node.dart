// lib/components/common/trail_node.dart
//
// COMPONENTE: no de uma trilha vertical de etapas.
//
// E um [TekohaListItem] com duas coisas a mais: um circulo de status a
// esquerda e a LINHA que liga esse circulo ao proximo no. A linha e o motivo do
// componente existir — ela transforma quatro cartoes soltos num caminho, e
// caminho comunica ordem e destino de um jeito que uma lista nao comunica.
//
// Por isso tambem nao foi feito como variante do TekohaListItem: nenhum outro
// item de lista precisa saber quem vem depois dele.
//
// USO: percorra as etapas passando `isLast: i == etapas.length - 1`.

import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart';

/// Situacao de uma etapa na trilha.
enum TekohaTrailNodeState {
  /// Ja concluida. Circulo verde com o visto.
  done,

  /// A etapa em que o usuario esta. Circulo urucum com o numero, cartao
  /// destacado com borda mais grossa e sombra.
  current,

  /// Ainda travada. Cinza, com o cadeado e a condicao de desbloqueio.
  locked,
}

class TekohaTrailNode extends StatelessWidget {
  final String title;

  /// Linha de apoio: a contagem de exercicios, ou a condicao de desbloqueio.
  final String subtitle;

  /// Numero exibido no circulo do estado `current`. 1-indexado.
  final int number;

  final TekohaTrailNodeState state;

  /// O ultimo no nao desenha a linha conectora abaixo dele.
  final bool isLast;

  final VoidCallback? onTap;

  const TekohaTrailNode({
    super.key,
    required this.title,
    required this.subtitle,
    required this.number,
    required this.state,
    required this.isLast,
    this.onTap,
  });

  bool get _isLocked => state == TekohaTrailNodeState.locked;
  bool get _isCurrent => state == TekohaTrailNodeState.current;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      // IntrinsicHeight mede a altura do cartao para que a linha conectora
      // possa se esticar exatamente ate ele. Sem isso, a coluna da esquerda
      // nao sabe qual altura preencher.
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              _StatusCircle(state: state, number: number),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 3,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      // O trecho ja percorrido fica verde; o que falta, cinza.
                      // A propria linha vira barra de progresso.
                      color: state == TekohaTrailNodeState.done
                          ? AppColors.correct.withValues(alpha: 0.45)
                          : AppColors.border,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 22),
              child: _StageCard(
                title: title,
                subtitle: subtitle,
                isLocked: _isLocked,
                isCurrent: _isCurrent,
                isDone: state == TekohaTrailNodeState.done,
                onTap: _isLocked ? null : onTap,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusCircle extends StatelessWidget {
  final TekohaTrailNodeState state;
  final int number;

  const _StatusCircle({required this.state, required this.number});

  @override
  Widget build(BuildContext context) {
    final (background, foreground, icon) = switch (state) {
      TekohaTrailNodeState.done => (
          AppColors.correct,
          AppColors.textOnPrimary,
          Icons.check,
        ),
      TekohaTrailNodeState.current => (
          AppColors.primary,
          AppColors.textOnPrimary,
          null,
        ),
      TekohaTrailNodeState.locked => (
          AppColors.disabledSurface,
          AppColors.textSecondary,
          Icons.lock_outline,
        ),
    };

    return Container(
      height: 44,
      width: 44,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: background, shape: BoxShape.circle),
      child: icon != null
          ? Icon(icon, size: 22, color: foreground)
          : Text(
              '$number',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: foreground,
              ),
            ),
    );
  }
}

class _StageCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isLocked;
  final bool isCurrent;
  final bool isDone;
  final VoidCallback? onTap;

  const _StageCard({
    required this.title,
    required this.subtitle,
    required this.isLocked,
    required this.isCurrent,
    required this.isDone,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppTheme.radius);

    return Material(
      color: isLocked ? AppColors.disabledSurface : AppColors.surface,
      borderRadius: radius,
      // A sombra so no no atual: ela levanta a etapa do plano da tela e diz
      // "e aqui que voce esta", sem precisar de texto.
      elevation: isCurrent ? 3 : 0,
      shadowColor: const Color(0x22000000),
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: radius,
            border: Border.all(
              color: isCurrent ? AppColors.primary : AppColors.border,
              width: isCurrent ? 2 : 1.2,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: isLocked
                            ? AppColors.textSecondary
                            : AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              if (isCurrent)
                const Icon(Icons.arrow_forward_rounded,
                    color: AppColors.primary)
              else if (isDone)
                const Icon(Icons.replay_rounded,
                    color: AppColors.textSecondary, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
