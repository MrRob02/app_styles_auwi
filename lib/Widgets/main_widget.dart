import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:auwi_styles/Herramientas/constantes.dart';
import '../Herramientas/colores.dart';

class MainWidget extends StatelessWidget {
  final String nombre;
  final ScrollController? controller;
  final Future Function()? refreshFunction;
  final Widget? floatingActionButton;
  final IconData? icono;
  final bool scrollingEnabled;
  final List<Widget> slivers;
  final Widget? bottomChild;
  final bool whiteBackground;
  const MainWidget(
      {super.key,
      required this.nombre,
      required this.slivers,
      this.bottomChild,
      this.icono,
      this.controller,
      this.refreshFunction,
      this.floatingActionButton,
      this.whiteBackground = false,
      this.scrollingEnabled = true});

  @override
  Widget build(BuildContext context) {
    final background = whiteBackground ? Colors.white : Colores.colorBackground;
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          refreshFunction?.call();
        },
        child: Scaffold(
          backgroundColor: background,
          floatingActionButton: floatingActionButton,
          body: Column(
            children: [
              Expanded(
                child: CustomScrollView(
                    controller: controller,
                    physics: scrollingEnabled
                        ? const AlwaysScrollableScrollPhysics(
                            parent: BouncingScrollPhysics())
                        : const NeverScrollableScrollPhysics(),
                    slivers: [
                      SliverAppBar(
                        backgroundColor: background,
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (icono != null) ...[
                              Icon(icono,
                                  size: 50, color: Colores.grisPrimario),
                              const Gap(10)
                            ],
                            Center(
                              child: Text(
                                nombre,
                                style: Styles.titulos,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const Gap(20),
                          ],
                        ),
                      ),
                      ...slivers
                    ]),
              ),
              bottomChild ?? const SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}
