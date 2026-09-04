// lib/main.dart
//
// Ponto de entrada do design sample system do Tekohá.
//
// O aplicativo nao tem regra de negocio: ele existe para exibir os componentes
// reutilizaveis, um por tela. O tema vem inteiro de [AppTheme], que por sua
// vez le os tokens de [AppColors] — nenhuma cor e declarada fora de la.

import 'package:flutter/material.dart';

import 'common/routes/app_routes.dart';
import 'common/theme/app_theme.dart';
import 'screens/sample_action_button_screen.dart';
import 'screens/sample_chips_screen.dart';
import 'screens/sample_lesson_screen.dart';
import 'screens/sample_list_items_screen.dart';
import 'screens/sample_screen.dart';
import 'screens/sample_states_screen.dart';
import 'screens/sample_tab_bar_screen.dart';
import 'screens/sample_trail_screen.dart';

void main() {
  runApp(const TekohaDesignSampleApp());
}

class TekohaDesignSampleApp extends StatelessWidget {
  const TekohaDesignSampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tekohá Design System',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.sample,
      // As rotas nomeadas vivem em [AppRoutes] — fonte unica da verdade. O
      // compilador acusa qualquer uso de constante que nao exista la, e nada
      // depende de digitar '/tab-bar' a mao.
      routes: {
        AppRoutes.sample: (_) => const SampleScreen(),
        AppRoutes.actionButton: (_) => const SampleActionButtonScreen(),
        AppRoutes.tabBar: (_) => const SampleTabBarScreen(),
        AppRoutes.listItems: (_) => const SampleListItemsScreen(),
        AppRoutes.chips: (_) => const SampleChipsScreen(),
        AppRoutes.lesson: (_) => const SampleLessonScreen(),
        AppRoutes.trail: (_) => const SampleTrailScreen(),
        AppRoutes.states: (_) => const SampleStatesScreen(),
      },
    );
  }
}
