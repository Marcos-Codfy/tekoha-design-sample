// lib/pages/sample_list_items_screen.dart
//
// Tela de demonstracao do componente TekohaListItem.
//
// Os exemplos reproduzem os quatro contextos reais em que a linha de lista
// aparece no aplicativo: navegacao entre conteudos, lista principal de
// modulos, item indisponivel e tabela de estatisticas.

import 'package:flutter/material.dart';

import '../components/common/list_items.dart';
import '../theme/app_colors.dart';
import 'sample_section.dart';

class SampleListItemsScreen extends StatelessWidget {
  const SampleListItemsScreen({super.key});

  static const String routeName = '/list-items';

  void _showFeedback(BuildContext context, String label) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('Você tocou em $label'),
          backgroundColor: AppColors.jenipapo,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('List Items')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 40),
        children: [
          const SampleIntro(
            'Linha de lista do Tekohá. Um widget só cobre os quatro formatos '
            'de linha que o aplicativo usa — o que muda entre eles é a '
            'variante, nunca a estrutura.',
          ),
          SampleSection(
            title: 'Navegação',
            note: 'A variante neutra: cartão branco com borda fina e chevron. '
                'Serve para listas em que todo item leva a algum lugar.',
            children: [
              SampleSpec(
                code: 'variant: outlined (padrão)',
                child: TekohaListItem(
                  title: 'Nheengatu',
                  subtitle: 'Tronco Tupi · Alto Rio Negro',
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _showFeedback(context, 'Nheengatu'),
                ),
              ),
            ],
          ),
          SampleSection(
            title: 'Lista principal',
            note: 'Preenchida em urucum, com o número de ordem no círculo. '
                'Reservada para a lista central da tela — mais de uma por tela '
                'derruba a hierarquia.',
            children: [
              SampleSpec(
                code: 'variant: filled · leading: TekohaListItemBadge.number',
                child: TekohaListItem(
                  leading: const TekohaListItemBadge.number(1),
                  title: 'Cumprimentos e Interações',
                  subtitle:
                      'O que você diz nos primeiros 30 segundos de uma conversa',
                  trailing: const Icon(Icons.chevron_right),
                  variant: TekohaListItemVariant.filled,
                  onTap: () => _showFeedback(context, 'Cumprimentos'),
                ),
              ),
              SampleSpec(
                code: 'leading: TekohaListItemBadge.icon com fundo verde',
                child: TekohaListItem(
                  leading: const TekohaListItemBadge.icon(
                    Icons.check,
                    background: AppColors.correct,
                  ),
                  title: 'A palavra curinga',
                  subtitle: '12 exercícios',
                  trailing: const Icon(Icons.replay),
                  onTap: () => _showFeedback(context, 'A palavra curinga'),
                ),
              ),
            ],
          ),
          const SampleSection(
            title: 'Indisponível',
            note: 'Em caulim, apagada, com a condição de desbloqueio no lugar '
                'da seta. O item continua visível: uma coleção incompleta à '
                'vista motiva mais do que uma lista curta.',
            children: [
              SampleSpec(
                code: 'variant: muted · onTap: null',
                child: TekohaListItem(
                  leading: TekohaListItemBadge.icon(
                    Icons.lock_outline,
                    background: AppColors.border,
                    foreground: AppColors.textSecondary,
                  ),
                  title: 'Natureza e Ambiente',
                  subtitle: 'Termine o módulo anterior',
                  variant: TekohaListItemVariant.muted,
                ),
              ),
            ],
          ),
          const SampleSection(
            title: 'Conteúdo longo',
            note: 'O subtítulo corta em duas linhas por padrão. Passe '
                'subtitleMaxLines: null para deixá-lo correr inteiro — é o '
                'formato dos cards de conteúdo da aba Cultura.',
            children: [
              SampleSpec(
                code: 'subtitleMaxLines: null',
                child: TekohaListItem(
                  title: 'Você Fala Mais Nheengatu Do Que Pensa',
                  subtitle:
                      'Mais de 10 mil palavras do português brasileiro vieram '
                      'do Tupi antigo e suas línguas-filhas, como o Nheengatu. '
                      'Capivara, jacaré, abacaxi, mandioca, pipoca, tatu, '
                      'tucano, jabuti — todas indígenas.',
                  subtitleMaxLines: null,
                ),
              ),
            ],
          ),
          const SampleSection(
            title: 'Tabela de dados',
            note: 'Sem moldura, com o valor à direita. Combine com Divider '
                'entre as linhas — a régua separa sem pesar como uma borda.',
            children: [
              SampleSpec(
                code: 'variant: plain + Divider entre as linhas',
                child: Column(
                  children: [
                    TekohaListItem(
                      leading: Icon(Icons.star),
                      title: 'XP total',
                      trailing: Text('528 XP'),
                      variant: TekohaListItemVariant.plain,
                    ),
                    Divider(height: 1, color: AppColors.border),
                    TekohaListItem(
                      leading: Icon(Icons.local_fire_department),
                      title: 'Sequência',
                      trailing: Text('1 dia'),
                      variant: TekohaListItemVariant.plain,
                    ),
                    Divider(height: 1, color: AppColors.border),
                    TekohaListItem(
                      leading: Icon(Icons.spa),
                      title: 'Palavras aprendidas',
                      trailing: Text('16'),
                      variant: TekohaListItemVariant.plain,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
