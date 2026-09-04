// lib/components/common/list_items.dart
//
// COMPONENTE: linha de lista do design system do Tekoha.
//
// Um unico widget cobre os quatro formatos de linha que o aplicativo real
// usava em telas diferentes — o cartao de modulo, o cartao de idioma, o item
// bloqueado e a linha de estatistica do perfil. O que muda entre eles e so a
// variante; a estrutura (elemento a esquerda, titulo, subtitulo, elemento a
// direita) e sempre a mesma.
//
// USO:
//   TekohaListItem(
//     leading: TekohaListItemBadge.number(1),
//     title: 'Cumprimentos e Interações',
//     subtitle: 'O que você diz nos primeiros 30 segundos de uma conversa',
//     trailing: const Icon(Icons.chevron_right),
//     variant: TekohaListItemVariant.filled,
//     onTap: () {},
//   )
//
// O [trailing] herda a cor certa da variante automaticamente: quem chama passa
// um Icon ou um Text sem cor, e o componente resolve o contraste.

import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart';

/// Formato visual da linha.
enum TekohaListItemVariant {
  /// Cartao branco com borda fina. O formato neutro, bom para listas de
  /// navegacao.
  outlined,

  /// Cartao preenchido em urucum. Reservado para a lista principal da tela —
  filled,

  /// Cartao cinza, apagado. Sinaliza item indisponivel sem escondê-lo: uma
  /// coleção incompleta e visivel motiva mais do que uma lista curta.
  muted,

  /// Linha sem moldura, para tabelas de dados. Combine com [Divider] entre
  /// as linhas.
  plain,
}

class TekohaListItem extends StatelessWidget {
  /// Elemento a esquerda: um [TekohaListItemBadge], um avatar ou um icone.
  final Widget? leading;

  /// Titulo da linha. Obrigatorio — uma linha sem titulo nao e uma linha.
  final String title;

  /// Texto de apoio, opcional.
  final String? subtitle;

  /// Quantas linhas o subtitulo pode ocupar antes de cortar com reticencias.
  /// `null` remove o limite — e o que os cards de conteudo da aba Cultura
  /// precisam, porque ali o subtitulo e um paragrafo inteiro.
  final int? subtitleMaxLines;

  /// Elemento a direita: chevron, valor numerico, cadeado, etiqueta.
  final Widget? trailing;

  /// Acao do toque. `null` remove o efeito de toque.
  final VoidCallback? onTap;

  final TekohaListItemVariant variant;

  const TekohaListItem({
    super.key,
    required this.title,
    this.leading,
    this.subtitle,
    this.subtitleMaxLines = 2,
    this.trailing,
    this.onTap,
    this.variant = TekohaListItemVariant.outlined,
  });

  _ListItemStyle get _style => switch (variant) {
        TekohaListItemVariant.outlined => const _ListItemStyle(
            background: AppColors.surface,
            border: AppColors.border,
            title: AppColors.textPrimary,
            subtitle: AppColors.textSecondary,
            accent: AppColors.primary,
          ),
        TekohaListItemVariant.filled => const _ListItemStyle(
            background: AppColors.primary,
            border: null,
            title: AppColors.textOnPrimary,
            subtitle: AppColors.textOnPrimary,
            accent: AppColors.textOnPrimary,
          ),
        TekohaListItemVariant.muted => const _ListItemStyle(
            background: AppColors.disabledSurface,
            border: null,
            title: AppColors.textSecondary,
            subtitle: AppColors.textSecondary,
            accent: AppColors.primary,
          ),
        TekohaListItemVariant.plain => const _ListItemStyle(
            background: Colors.transparent,
            border: null,
            title: AppColors.textPrimary,
            subtitle: AppColors.textSecondary,
            accent: AppColors.primary,
          ),
      };

  bool get _isPlain => variant == TekohaListItemVariant.plain;

  @override
  Widget build(BuildContext context) {
    final style = _style;
    final radius = _isPlain
        ? BorderRadius.zero
        : BorderRadius.circular(AppTheme.cardRadius);

    return Material(
      color: style.background,
      borderRadius: radius,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: radius,
            border:
                style.border == null ? null : Border.all(color: style.border!),
          ),
          padding: _isPlain
              ? const EdgeInsets.symmetric(vertical: 14)
              : const EdgeInsets.all(20),
          child: Row(
            children: [
              if (leading != null) ...[
                IconTheme(
                  data: IconThemeData(color: style.accent, size: 22),
                  child: leading!,
                ),
                SizedBox(width: _isPlain ? 12 : 16),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: _isPlain ? 15 : 18,
                        fontWeight:
                            _isPlain ? FontWeight.w500 : FontWeight.w700,
                        color: style.title,
                        height: 1.25,
                      ),
                    ),
                    if (subtitle != null && subtitle!.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        subtitle!,
                        maxLines: subtitleMaxLines,
                        overflow: subtitleMaxLines == null
                            ? TextOverflow.clip
                            : TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.4,
                          color: style.subtitle.withValues(
                            alpha: variant == TekohaListItemVariant.filled
                                ? 0.9
                                : 1,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (trailing != null) ...[
                const SizedBox(width: 12),
                // O trailing herda cor e tamanho da variante: quem chama passa
                // Icon ou Text "cru" e o contraste sai certo em qualquer fundo.
                IconTheme(
                  data: IconThemeData(color: style.accent, size: 24),
                  child: DefaultTextStyle(
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: style.accent,
                    ),
                    child: trailing!,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Circulo do lado esquerdo da linha, com um numero ou um icone dentro.
///
/// Existe porque as duas formas aparecem nas mesmas listas e precisam do mesmo
/// diametro para os titulos alinharem entre si.
class TekohaListItemBadge extends StatelessWidget {
  /// Numero de ordem. Exclusivo com [icon].
  final int? number;

  /// Icone. Exclusivo com [number].
  final IconData? icon;

  final Color background;
  final Color foreground;

  const TekohaListItemBadge._({
    super.key,
    this.number,
    this.icon,
    required this.background,
    required this.foreground,
  });

  /// Circulo branco com o numero em urucum — o padrao das listas preenchidas.
  const TekohaListItemBadge.number(
    int value, {
    Key? key,
    Color background = AppColors.surface,
    Color foreground = AppColors.primary,
  }) : this._(
          key: key,
          number: value,
          background: background,
          foreground: foreground,
        );

  /// Circulo com icone. Use [background] para trocar o estado (verde para
  /// concluido, cinza para bloqueado).
  const TekohaListItemBadge.icon(
    IconData value, {
    Key? key,
    Color background = AppColors.primary,
    Color foreground = AppColors.textOnPrimary,
  }) : this._(
          key: key,
          icon: value,
          background: background,
          foreground: foreground,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      width: 44,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: background, shape: BoxShape.circle),
      child: number != null
          ? Text(
              '$number',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: foreground,
              ),
            )
          : Icon(icon, size: 22, color: foreground),
    );
  }
}

/// Cores resolvidas de uma variante. Existe para o build ler um objeto so, em
/// vez de encadear condicionais por propriedade.
class _ListItemStyle {
  final Color background;
  final Color? border;
  final Color title;
  final Color subtitle;
  final Color accent;

  const _ListItemStyle({
    required this.background,
    required this.border,
    required this.title,
    required this.subtitle,
    required this.accent,
  });
}
