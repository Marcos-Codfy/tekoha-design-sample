// lib/main.dart
//
// Ponto de entrada do design sample system do Tekohá.
//
// O aplicativo nao tem regra de negocio: ele existe para exibir os componentes
// reutilizaveis, um por tela. O tema vem inteiro de [AppTheme], que por sua
// vez le os tokens de [AppColors] — nenhuma cor e declarada fora de la.

import 'package:flutter/material.dart';

import 'pages/sample_action_button_screen.dart';
import 'pages/sample_screen.dart';
import 'pages/sample_tab_bar_screen.dart';
import 'theme/app_theme.dart';

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
      initialRoute: SampleScreen.routeName,
      routes: {
        SampleScreen.routeName: (_) => const SampleScreen(),
        SampleActionButtonScreen.routeName: (_) =>
            const SampleActionButtonScreen(),
        SampleTabBarScreen.routeName: (_) => const SampleTabBarScreen(),
      },
    );
  }
}
