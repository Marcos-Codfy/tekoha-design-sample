// lib/components/common/feedback_state.dart
//
// COMPONENTES: as telas que aparecem quando nao ha conteudo para mostrar —
// carregando, vazio ou com erro.
//
// Estados de tela sao a parte que mais se improvisa e menos se padroniza num
// aplicativo. Centralizar aqui garante que "sem conexao" tenha a mesma cara em
// todas as abas, e que nenhum spinner apareca na cor errada.

import 'package:flutter/material.dart';

import 'action_button.dart';
import '../../theme/app_colors.dart';

/// Indicador de carregamento na cor da marca.
///
/// Existe para eliminar o `CircularProgressIndicator(color: AppColors.primary)`
/// repetido em toda tela com estado de espera
class TekohaLoader extends StatelessWidget {
  /// Ja vem centralizado. Passe `false` para
  /// posicionar por conta propria.
  final bool centered;

  const TekohaLoader({super.key, this.centered = true});

  @override
  Widget build(BuildContext context) {
    const loader = CircularProgressIndicator(color: AppColors.primary);
    return centered ? const Center(child: loader) : loader;
  }
}

/// Tela de conteudo ausente: erro de rede, lista vazia, recurso indisponivel.
///
/// A acao de recuperacao e opcional porque nem todo vazio tem conserto pelo
/// usuario — "nenhum conteúdo nessa categoria ainda" nao pede botao nenhum.
class TekohaEmptyState extends StatelessWidget {
  final String message;

  /// Segunda linha, opcional: o que fazer a respeito.
  final String? hint;

  final IconData icon;

  /// Sem [onRetry] o botao nao aparece.
  final VoidCallback? onRetry;

  final String retryLabel;

  const TekohaEmptyState({
    super.key,
    required this.message,
    this.hint,
    this.icon = Icons.error_outline,
    this.onRetry,
    this.retryLabel = 'Tentar novamente',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 56, color: AppColors.primary),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.textPrimary,
                height: 1.4,
              ),
            ),
            if (hint != null && hint!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                hint!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
              ),
            ],
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              ActionButton.primary(
                label: retryLabel,
                icon: Icons.refresh,
                size: ActionButtonSize.medium,
                fullWidth: false,
                onPressed: onRetry,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
