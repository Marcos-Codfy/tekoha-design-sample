// lib/pages/sample_section.dart
//
// Andaimes de apresentacao das telas de demonstracao: paragrafo de abertura,
// bloco tematico e legenda de codigo.
//
// Nao sao componentes do design system — sao a moldura do catalogo. Ficam em
// `pages/` de proposito: `components/common/` guarda so o que uma tela de
// produto real usaria.

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Paragrafo de abertura, logo abaixo da AppBar. Diz em uma frase o que o
/// componente e e que problema ele resolve.
class SampleIntro extends StatelessWidget {
  final String text;

  const SampleIntro(this.text, {super.key});

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

/// Bloco tematico: titulo, a regra de uso em uma ou duas linhas, e os
/// exemplos. A regra vem antes dos exemplos porque e ela que explica por que
/// existem variantes.
class SampleSection extends StatelessWidget {
  final String title;
  final String note;
  final List<Widget> children;

  const SampleSection({
    super.key,
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

/// Um exemplo do catalogo: o widget renderizado em cima, a chamada que o
/// produz logo abaixo. Ver os dois juntos e o que torna o catalogo utilizavel
/// como documentacao.
class SampleSpec extends StatelessWidget {
  final String code;
  final Widget child;

  const SampleSpec({super.key, required this.code, required this.child});

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
