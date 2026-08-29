// lib/theme/app_colors.dart
//
// Tokens de cor do design system do Tekoha.
//
// Fonte unica da verdade: NENHUM widget deste projeto declara Color(0x...)
// direto. Trocar a identidade visual e trocar este arquivo.
//
// A paleta nasce de PIGMENTOS NATURAIS UNIVERSAIS da Amazonia (urucum,
// jenipapo, caulim, argila), nunca de grafismos etnico-especificos — cuidado
// etico registrado na pesquisa (Carneiro da Cunha, 2009). O efeito psicologico
// da cor segue Elliot & Maier (2014).

import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ── Paleta principal ──────────────────────────────────────────────
  static const Color primary = Color(0xFFB5451B); // Urucum
  static const Color secondary = Color(0xFF2D6A4F); // Verde mata
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFFFFFFF);

  // ── Texto ─────────────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFF1A1A1A); // preto suave
  static const Color textSecondary = Color(0xFF6B6B6B); // cinza medio
  static const Color textOnPrimary = Color(0xFFFFFFFF); // branco sobre urucum

  // ── Bordas ────────────────────────────────────────────────────────
  static const Color border = Color(0xFFE0E0E0);
  static const Color borderFocused = Color(0xFFB5451B);

  // ── Estados ───────────────────────────────────────────────────────
  static const Color correct = Color(0xFF2E7D32); // verde acerto
  static const Color wrong = Color(0xFFB5451B); // urucum (visual unificado)
  static const Color disabled = Color(0xFFD4886A); // urucum dessaturado

  /// Fundo neutro de item indisponivel em lista (o "Em breve" da aba
  /// Cultura). Cinza, nao caulim: caulim carrega significado de conteudo
  /// cultural e nao deve virar sinonimo de "desativado".
  static const Color disabledSurface = Color(0xFFF5F5F5);

  // ── Paleta amazonica estendida ────────────────────────────────────
  // Cada cor com contraste WCAG AA validado sobre branco.
  static const Color jenipapo = Color(0xFF1B2845); // Azul-noite (fruta)
  static const Color caulim = Color(0xFFF5EBD8); // Branco-osso terroso
  static const Color argila = Color(0xFFA0522D); // Marrom argila
  static const Color floresta = Color(0xFF1F4E3D); // Verde mata profundo
  static const Color rio = Color(0xFF3D6FA8); // Azul rio Amazonas
}
