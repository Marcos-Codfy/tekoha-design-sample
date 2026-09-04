// lib/components/common/banner.dart
//
// COMPONENTES: as duas caixas de mensagem do design system.
//
//   - [TekohaBanner] comunica o RESULTADO de uma acao do usuario — acertou,
//     errou, falhou ao entrar.
//   - [TekohaNoteCard] traz conteudo COLATERAL — a curiosidade cultural, a
//     nota de pronuncia. Nao e consequencia de nada que o usuario fez.
//
// A distincao importa porque a cor comunica: um card cultural em verde diria
// "voce acertou", que e falso.

import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart';

/// Tom semantico de um [TekohaBanner].
enum TekohaBannerTone { success, error, info }

class TekohaBanner extends StatelessWidget {
  /// A frase principal, em negrito ao lado do icone.
  final String message;

  /// Segunda linha, opcional: a resposta certa, a pronuncia, o detalhe do erro.
  final String? detail;

  /// Conteudo extra abaixo do texto — tipicamente um [TekohaNoteCard] ou um
  /// botao de continuar.
  final Widget? action;

  final TekohaBannerTone tone;

  const TekohaBanner({
    super.key,
    required this.message,
    this.detail,
    this.action,
    this.tone = TekohaBannerTone.info,
  });

  Color get _accent => switch (tone) {
        TekohaBannerTone.success => AppColors.correct,
        TekohaBannerTone.error => AppColors.wrong,
        TekohaBannerTone.info => AppColors.rio,
      };

  IconData get _icon => switch (tone) {
        TekohaBannerTone.success => Icons.check_circle,
        // Coracao, nao "X": o erro no Tekoha nao pune, acolhe. Trocar por um
        // simbolo de falha mudaria a mensagem emocional da tela inteira.
        TekohaBannerTone.error => Icons.favorite,
        TekohaBannerTone.info => Icons.info_outline,
      };

  @override
  Widget build(BuildContext context) {
    final accent = _accent;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppTheme.cardRadius),
        border: Border.all(color: accent.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(_icon, color: accent, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(
                    color: accent,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    height: 1.35,
                  ),
                ),
              ),
            ],
          ),
          if (detail != null && detail!.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              detail!,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
                fontStyle: FontStyle.italic,
                height: 1.4,
              ),
            ),
          ],
          if (action != null) ...[
            const SizedBox(height: 16),
            action!,
          ],
        ],
      ),
    );
  }
}

/// Caixa de conteudo colateral: curiosidade cultural, nota de pronuncia.
///
/// O fundo caulim (branco-osso terroso) separa o saber tradicional do fluxo de
/// exercicio sem competir com o urucum da marca.
class TekohaNoteCard extends StatelessWidget {
  final String text;

  /// Padrao lampada (curiosidade). Troque por `record_voice_over` em notas de
  /// pronuncia.
  final IconData icon;

  /// Deixa o texto em italico — a convencao do aplicativo para pronuncia.
  final bool italic;

  const TekohaNoteCard({
    super.key,
    required this.text,
    this.icon = Icons.lightbulb_outline,
    this.italic = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.caulim,
        borderRadius: BorderRadius.circular(AppTheme.cardRadius),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textPrimary,
                fontStyle: italic ? FontStyle.italic : FontStyle.normal,
                fontWeight: italic ? FontWeight.w600 : FontWeight.normal,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
