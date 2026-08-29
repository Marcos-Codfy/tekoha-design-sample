// lib/components/common/texts.dart
//
// COMPONENTES: os tres textos que carregam intencao, e nao apenas conteudo.
//
// Um `Text` comum resolveria qualquer um deles. Eles existem como componentes
// porque cada um tem um PAPEL fixo na interface, e o papel precisa ficar
// visivel no codigo: quem le `TekohaPurposeText(...)` sabe que aquela frase
// existe para dar sentido a acao, e nao vai trocá-la por uma dica de uso.
//
// O ganho pratico: mudar o estilo de todos os rotulos de secao do aplicativo e
// editar um arquivo, e nao cacar `fontSize: 14, fontWeight: w600` em oito
// telas.

import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Cabecalho de um grupo de informacao ("Seu progresso", "Componentes").
///
/// Menor, cinza e em peso medio: sinaliza o grupo sem competir com o conteudo
/// que vem abaixo.
class TekohaSectionLabel extends StatelessWidget {
  final String text;

  const TekohaSectionLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textSecondary,
      ),
    );
  }
}

/// Frase de proposito: liga a acao do usuario a razao de ser do aplicativo
/// ("Cada palavra que você pratica é uma palavra que continua viva").
///
/// Discreta de proposito — cinza e em italico. Ela nao disputa com o conteudo;
/// aparece no fim de um bloco, quando o usuario ja fez o que tinha que fazer.
class TekohaPurposeText extends StatelessWidget {
  final String text;
  final TextAlign align;

  /// Desligue o italico quando o texto ja estiver dentro de um bloco em
  /// italico, para nao criar enfase dupla.
  final bool italic;

  const TekohaPurposeText(
    this.text, {
    super.key,
    this.align = TextAlign.center,
    this.italic = true,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
        fontSize: 13,
        color: AppColors.textSecondary,
        fontStyle: italic ? FontStyle.italic : FontStyle.normal,
        height: 1.5,
      ),
    );
  }
}

/// Frase de encorajamento apos um erro ("Quase! Tenta outra — você consegue").
///
/// Urucum e em peso medio, o oposto da frase de proposito: esta precisa ser
/// vista no instante em que aparece, porque o momento seguinte a um erro e o
/// mais sensivel da sessao.
class TekohaEncouragementText extends StatelessWidget {
  final String text;

  const TekohaEncouragementText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: AppColors.primary,
        fontWeight: FontWeight.w600,
        fontSize: 14,
      ),
    );
  }
}
