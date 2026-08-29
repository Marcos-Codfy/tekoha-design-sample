// lib/components/common/play_button.dart
//
// COMPONENTE: botao circular de audio.
//
// E o unico elemento grande do aplicativo que NAO e urucum. A cor rio (azul
// Amazonas) marca "som" como uma familia propria — o urucum e acao da marca, o
// rio e fluxo sonoro. Num aplicativo cuja pedagogia parte do ouvido, o botao de
// ouvir precisa ter identidade propria.
//
// Enquanto [isPlaying] e verdadeiro o circulo pulsa. O pulso e feedback de
// processo em andamento: sem ele, um audio curto tocando em silencio parece um
// toque que nao registrou.

import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class TekohaPlayButton extends StatelessWidget {
  final VoidCallback? onTap;

  /// Liga o pulso. Deve refletir o estado REAL do reprodutor, nao o toque —
  /// senao a animacao mente sobre o que esta acontecendo.
  final bool isPlaying;

  /// Diametro do circulo. 88 na ficha da palavra, 64 dentro de exercicios.
  final double size;

  const TekohaPlayButton({
    super.key,
    this.onTap,
    this.isPlaying = false,
    this.size = 88,
  });

  @override
  Widget build(BuildContext context) {
    return _Pulse(
      active: isPlaying,
      child: Material(
        color: AppColors.rio,
        shape: const CircleBorder(),
        elevation: 4,
        shadowColor: const Color(0x33000000),
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          child: SizedBox(
            height: size,
            width: size,
            child: Icon(
              Icons.volume_up_rounded,
              color: AppColors.textOnPrimary,
              size: size * 0.45,
            ),
          ),
        ),
      ),
    );
  }
}

/// Pulso continuo entre 1.0 e 1.08 enquanto [active].
///
/// Fica privado porque so faz sentido acoplado a um elemento que representa
/// processo em andamento. Exposto, viraria decoracao.
class _Pulse extends StatefulWidget {
  final bool active;
  final Widget child;

  const _Pulse({required this.active, required this.child});

  @override
  State<_Pulse> createState() => _PulseState();
}

class _PulseState extends State<_Pulse> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 700),
    lowerBound: 1,
    upperBound: 1.08,
  );

  @override
  void initState() {
    super.initState();
    if (widget.active) _controller.repeat(reverse: true);
  }

  @override
  void didUpdateWidget(_Pulse oldWidget) {
    super.didUpdateWidget(oldWidget);
    // O widget e reconstruido a cada mudanca de estado do pai; o controlador
    // precisa acompanhar sem reiniciar quando nada relevante mudou.
    if (widget.active == oldWidget.active) return;
    if (widget.active) {
      _controller.repeat(reverse: true);
    } else {
      _controller
        ..stop()
        ..value = 1;
    }
  }

  @override
  void dispose() {
    // Sem isto o controlador continua rodando depois da tela sair, e o
    // aplicativo vaza um ticker por visita.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(scale: _controller, child: widget.child);
  }
}
