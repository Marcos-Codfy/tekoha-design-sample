// COMPONENTE: botao de acao do design system do Tekoha.
//
// Unifica num unico widget os tres botoes que o aplicativo real mantinha
// separados (primario, secundario e o spinner de carregamento).
// evita a duplicacao de `ElevatedButton.icon(...)` espalhada
// pelas telas.
//
// USO:
//   ActionButton.primary(label: 'Praticar Nheengatu', icon: Icons.play_arrow,
//                        onPressed: () {})
//   ActionButton.secondary(label: 'Explorar a cultura', onPressed: () {})
//
// REGRA DE DESIGN: uma tela deve ter no maximo UM botao primario (Lei de
// Hick). Os demais entram como secundarios, em outline, para nao competir por
// atencao.

import 'package:flutter/material.dart';

import '../common/theme/app_colors.dart';
import '../common/theme/app_theme.dart';

/// Peso visual do botao na tela.
enum ActionButtonVariant {
  primary,

  /// Outline urucum, fundo transparente. Acoes alternativas.
  secondary,
}

/// Altura do botao. Use [large] em CTA de tela cheia e [small] em barras
/// compactas ou dentro de cards.
enum ActionButtonSize { small, medium, large }

class ActionButton extends StatelessWidget {
  /// Texto exibido. Escreva em PT-BR, acentuado, no imperativo.
  final String label;

  /// Icone opcional a esquerda do rotulo.
  final IconData? icon;

  /// Acao do toque. `null` deixa o botao desabilitado.
  final VoidCallback? onPressed;

  final ActionButtonVariant variant;
  final ActionButtonSize size;

  /// Troca o conteudo por um spinner e bloqueia o toque. Use durante
  /// operacoes assincronas.
  final bool isLoading;

  /// Se `true` (padrao), ocupa toda a largura disponivel.
  final bool fullWidth;

  const ActionButton({
    super.key,
    required this.label,
    this.icon,
    this.onPressed,
    this.variant = ActionButtonVariant.primary,
    this.size = ActionButtonSize.large,
    this.isLoading = false,
    this.fullWidth = true,
  });

  const ActionButton.primary({
    super.key,
    required this.label,
    this.icon,
    this.onPressed,
    this.size = ActionButtonSize.large,
    this.isLoading = false,
    this.fullWidth = true,
  }) : variant = ActionButtonVariant.primary;

  const ActionButton.secondary({
    super.key,
    required this.label,
    this.icon,
    this.onPressed,
    this.size = ActionButtonSize.large,
    this.isLoading = false,
    this.fullWidth = true,
  }) : variant = ActionButtonVariant.secondary;

  double get _height => switch (size) {
        ActionButtonSize.small => 40,
        ActionButtonSize.medium => 48,
        ActionButtonSize.large => 54,
      };

  double get _fontSize => switch (size) {
        ActionButtonSize.small => 14,
        ActionButtonSize.medium => 15,
        ActionButtonSize.large => 16,
      };

  double get _iconSize => switch (size) {
        ActionButtonSize.small => 18,
        ActionButtonSize.medium => 20,
        ActionButtonSize.large => 22,
      };

  bool get _isEnabled => onPressed != null && !isLoading;

  @override
  Widget build(BuildContext context) {
    final Widget content = isLoading
        ? _Spinner(
            size: _iconSize,
            color: variant == ActionButtonVariant.primary
                ? AppColors.textOnPrimary
                : AppColors.primary,
          )
        : Text(label);

    final Widget button = switch (variant) {
      ActionButtonVariant.primary => _buildPrimary(content),
      ActionButtonVariant.secondary => _buildSecondary(content),
    };

    return fullWidth
        ? SizedBox(width: double.infinity, child: button)
        : button;
  }

  Widget _buildPrimary(Widget content) {
    final style = ElevatedButton.styleFrom(
      minimumSize: Size(0, _height),
      padding: EdgeInsets.symmetric(horizontal: _height / 2.4),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radius),
      ),
      textStyle: TextStyle(
        fontSize: _fontSize,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.3,
      ),
    );

    if (icon != null && !isLoading) {
      return ElevatedButton.icon(
        onPressed: _isEnabled ? onPressed : null,
        style: style,
        icon: Icon(icon, size: _iconSize),
        label: content,
      );
    }
    return ElevatedButton(
      onPressed: _isEnabled ? onPressed : null,
      style: style,
      child: content,
    );
  }

  Widget _buildSecondary(Widget content) {
    final style = OutlinedButton.styleFrom(
      minimumSize: Size(0, _height),
      padding: EdgeInsets.symmetric(horizontal: _height / 2.4),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radius),
      ),
      textStyle: TextStyle(
        fontSize: _fontSize,
        fontWeight: FontWeight.w600,
      ),
    );

    if (icon != null && !isLoading) {
      return OutlinedButton.icon(
        onPressed: _isEnabled ? onPressed : null,
        style: style,
        icon: Icon(icon, size: _iconSize),
        label: content,
      );
    }
    return OutlinedButton(
      onPressed: _isEnabled ? onPressed : null,
      style: style,
      child: content,
    );
  }
}

/// Spinner compacto exibido no lugar do rotulo durante o carregamento.
class _Spinner extends StatelessWidget {
  final double size;
  final Color color;

  const _Spinner({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator(color: color, strokeWidth: 2.5),
    );
  }
}
