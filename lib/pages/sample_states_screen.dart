// lib/pages/sample_states_screen.dart
//
// Tela de demonstracao dos estados de tela e dos textos com papel.
//
// Estados de ausencia — carregando, vazio, com erro — sao a parte que mais se
// improvisa num aplicativo, porque ninguem os projeta: eles aparecem quando
// algo deu errado. Vê-los catalogados, com a mesma cara em todas as abas, e
// metade do trabalho de padronizá-los.

import 'package:flutter/material.dart';

import '../components/common/feedback_state.dart';
import '../components/common/texts.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'sample_section.dart';

class SampleStatesScreen extends StatelessWidget {
  const SampleStatesScreen({super.key});

  static const String routeName = '/states';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Estados e Textos')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 40),
        children: [
          const SampleIntro(
            'O que a tela mostra quando não há o que mostrar, e os três textos '
            'que carregam intenção em vez de só conteúdo.',
          ),
          const SampleSection(
            title: 'Carregando',
            note: 'Existe para eliminar o spinner na cor errada — o lugar '
                'onde mais se esquece de aplicar a cor da marca.',
            children: [
              SampleSpec(
                code: 'TekohaLoader()',
                child: _Frame(height: 120, child: TekohaLoader()),
              ),
            ],
          ),
          SampleSection(
            title: 'Sem conteúdo',
            note: 'A ação de recuperação é opcional: nem todo vazio tem '
                'conserto pelo usuário.',
            children: [
              SampleSpec(
                code: 'com onRetry',
                child: _Frame(
                  height: 300,
                  child: TekohaEmptyState(
                    message: 'Nenhum módulo disponível ainda.',
                    hint: 'Verifique sua conexão e tente de novo.',
                    icon: Icons.wifi_off_rounded,
                    onRetry: () {},
                  ),
                ),
              ),
              const SampleSpec(
                code: 'sem onRetry — nada a fazer a respeito',
                child: _Frame(
                  height: 240,
                  child: TekohaEmptyState(
                    message: 'Nenhum conteúdo nessa categoria ainda.',
                    icon: Icons.inbox_outlined,
                  ),
                ),
              ),
            ],
          ),
          const SampleSection(
            title: 'Textos com papel',
            note: 'Um Text comum resolveria os três. Eles existem como '
                'componentes para que o papel de cada frase fique visível no '
                'código de quem monta a tela.',
            children: [
              SampleSpec(
                code: 'TekohaSectionLabel',
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TekohaSectionLabel('Seu progresso'),
                ),
              ),
              SampleSpec(
                code: 'TekohaPurposeText — discreta, aparece no fim do bloco',
                child: TekohaPurposeText(
                  'Cada palavra praticada apoia a revitalização do Nheengatu.',
                ),
              ),
              SampleSpec(
                code: 'TekohaEncouragementText — urucum, vista no instante',
                child: TekohaEncouragementText(
                  'Quase! Tenta outra — você consegue.',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Moldura de altura fixa. Estados de tela ocupam a tela inteira no uso real;
/// no catalogo eles precisam de um recorte para caber ao lado dos outros.
class _Frame extends StatelessWidget {
  final double height;
  final Widget child;

  const _Frame({required this.height, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppTheme.cardRadius),
        border: Border.all(color: AppColors.border),
      ),
      child: child,
    );
  }
}
