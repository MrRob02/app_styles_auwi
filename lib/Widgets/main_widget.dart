import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:auwi_styles/Herramientas/constantes.dart';
import '../Herramientas/colores.dart';

class MainWidget extends StatefulWidget {
  final String nombre;
  final ScrollController? controller;
  final Future Function()? refreshFunction;
  final FloatingActionButton? floatingActionButton;
  final IconData? icono;
  final bool scrollingEnabled;
  final Widget? trailing;
  final List<Widget> slivers;
  final Widget? bottomChild;
  final bool whiteBackground;
  final bool toUpButton;
  const MainWidget(
      {super.key,
      required this.nombre,
      required this.slivers,
      this.trailing,
      this.bottomChild,
      this.icono,
      this.controller,
      this.refreshFunction,
      this.floatingActionButton,
      this.toUpButton = false,
      this.whiteBackground = false,
      this.scrollingEnabled = true});

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  @override
  void initState() {
    widget.controller?.addListener(() {
      if (widget.controller!.position.pixels > 0) {
        setState(() {
          showUpButton = true;
        });
      } else {
        setState(() {
          showUpButton = false;
        });
      }
    });
    super.initState();
  }

  bool showUpButton = false;
  @override
  Widget build(BuildContext context) {
    final background =
        widget.whiteBackground ? Colors.white : Colores.colorBackground;
    return RefreshIndicator(
      onRefresh: () async {
        widget.refreshFunction?.call();
      },
      child: Scaffold(
        backgroundColor: background,
        floatingActionButton: topButton(),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: CustomScrollView(
                    controller: widget.controller,
                    physics: widget.scrollingEnabled
                        ? const AlwaysScrollableScrollPhysics(
                            parent: BouncingScrollPhysics())
                        : const NeverScrollableScrollPhysics(),
                    slivers: [
                      SliverAppBar(
                        backgroundColor: background,
                        actions:
                            widget.trailing != null ? [widget.trailing!] : null,
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (widget.icono != null) ...[
                              Icon(widget.icono,
                                  size: 50, color: Colores.grisPrimario),
                              const Gap(10)
                            ],
                            Center(
                              child: Text(
                                widget.nombre,
                                style: Styles.titulos,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const Gap(20),
                          ],
                        ),
                      ),
                      ...widget.slivers
                    ]),
              ),
              widget.bottomChild ?? const SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }

  FloatingActionButton? topButton() {
    if (widget.controller == null) return null;
    if (!showUpButton) {
      if (widget.floatingActionButton != null) {
        return widget.floatingActionButton;
      }
      return null;
    }
    return FloatingActionButton(
      onPressed: () {
        widget.controller?.animateTo(0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut);
      },
      child: const Icon(Icons.arrow_upward),
    );
  }
}
