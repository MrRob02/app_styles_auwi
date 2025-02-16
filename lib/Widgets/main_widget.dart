import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Herramientas/platform_helper.dart';
import 'custom_icon.dart';
import 'custom_text.dart';
import 'to_up_button.dart';

class MainWidget extends StatefulWidget {
  final String? nombre;
  final ScrollController? controller;
  final Future<void> Function()? refreshFunction;
  final FloatingActionButton? floatingActionButton;
  final bool scrollingEnabled;
  final List<Widget>? _slivers;
  final Widget? child;
  final bool whiteBackground;
  final bool toUpButton;
  final double? contentPadding;
  final bool isLoading;
  final Widget? loadingShimmer;
  final bool _isSliver;
  final bool showAppBar;
  final bool showBackButton;
  final double? maxWidth;
  final Alignment? alignment;
  final bool useSafeArea;
  const MainWidget(
      {super.key,
      required this.child,
      this.showBackButton = true,
      this.nombre,
      this.controller,
      this.floatingActionButton,
      this.toUpButton = false,
      this.whiteBackground = false,
      this.scrollingEnabled = true,
      this.showAppBar = true,
      this.contentPadding,
      this.maxWidth,
      this.alignment,
      this.useSafeArea = false,
      this.isLoading = false})
      : _isSliver = false,
        _slivers = null,
        refreshFunction = null,
        loadingShimmer = null;
  const MainWidget.slivers(
      {super.key,
      this.nombre,
      required List<Widget>? slivers,
      this.controller,
      this.refreshFunction,
      this.floatingActionButton,
      this.isLoading = false,
      this.loadingShimmer,
      this.toUpButton = false,
      this.whiteBackground = false,
      this.scrollingEnabled = true,
      this.showAppBar = true,
      this.showBackButton = true,
      this.maxWidth,
      this.alignment,
      this.useSafeArea = false})
      : _slivers = slivers,
        _isSliver = true,
        child = null,
        contentPadding = null;

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  final showUpButton = ValueNotifier(false);
  @override
  void initState() {
    widget.controller?.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    showUpButton.value = widget.controller!.position.pixels > 0;
  }

  bool get useSafeArea => widget.useSafeArea;

  @override
  Widget build(BuildContext context) {
    final padding = widget.contentPadding;
    final background = widget.whiteBackground ? Colors.white : null;
    final nombre = widget.nombre;
    final refreshFunction = widget.refreshFunction;
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        top: useSafeArea,
        bottom: useSafeArea,
        left: useSafeArea,
        right: useSafeArea,
        child: Scaffold(
          backgroundColor: background,
          floatingActionButton: ValueListenableBuilder(
            builder: (context, value, child) => topButton(),
            valueListenable: showUpButton,
          ),
          appBar: widget._isSliver || !widget.showAppBar
              ? null
              : CupertinoNavigationBar(
                  transitionBetweenRoutes: false,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  leading: backButton(),
                  middle: CustomText.title(widget.nombre ?? ''),
                ),
          body: Align(
            alignment: widget.alignment ?? Alignment.center,
            child: SizedBox(
              width: widget.maxWidth,
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: padding ?? 0,
                    left: padding ?? 0,
                    right: padding ?? 0),
                child: refreshFunction == null || widget._isSliver
                    ? allWidget(background, nombre)
                    : RefreshIndicator(
                        onRefresh: refreshFunction,
                        child: allWidget(background, nombre)),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget allWidget(Color? background, String? nombre) {
    final title = nombre ?? '';
    final ignoring = widget.isLoading && widget.loadingShimmer == null;
    return IgnorePointer(
      ignoring: ignoring,
      child: Stack(
        children: [
          AnimatedOpacity(
            opacity: ignoring ? 0.5 : 1,
            duration: const Duration(milliseconds: 300),
            child: () {
              if (widget._isSliver) {
                return RefreshIndicator(
                  onRefresh: widget.refreshFunction ?? () async {},
                  child: CustomScrollView(
                      controller: widget.controller,
                      physics: widget.scrollingEnabled
                          ? const AlwaysScrollableScrollPhysics()
                          : const NeverScrollableScrollPhysics(),
                      slivers: [
                        if (widget.showAppBar && nombre != null)
                          CupertinoSliverNavigationBar(
                            transitionBetweenRoutes: false,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            enableBackgroundFilterBlur: false,
                            leading: backButton(),
                            largeTitle: CustomText.huge(
                              title,
                              maxLines: 1,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                            middle: CustomText.subtitle(
                              title,
                              maxLines: 1,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                            alwaysShowMiddle: false,
                          ),
                        if (widget.isLoading && widget.loadingShimmer != null)
                          SliverToBoxAdapter(
                            child: widget.loadingShimmer,
                          )
                        else
                          ...widget._slivers!
                      ]),
                );
              } else {
                return widget.child ?? const SizedBox.shrink();
              }
            }(),
          ),
          AnimatedOpacity(
            opacity: widget.isLoading ? 0.5 : 1,
            duration: const Duration(milliseconds: 300),
            child: widget.child ?? const SizedBox.shrink(),
          ),
          if (widget.isLoading && widget.loadingShimmer == null)
            const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
        ],
      ),
    );
  }

  Widget? backButton() {
    return widget.showBackButton
        ? CustomIcon.button(PlatformHelper.backIcon,
            onPressed: Navigator.of(context).pop)
        : const SizedBox.shrink();
  }

  Widget topButton() {
    if (!showUpButton.value) {
      final floatingActionButton = widget.floatingActionButton;
      if (floatingActionButton != null) {
        return floatingActionButton;
      }
      return const SizedBox.shrink();
    }
    if (!widget.toUpButton) return const SizedBox.shrink();
    final controller = widget.controller;
    if (controller == null) return const SizedBox.shrink();
    return ToUpButton(controller: controller);
  }
}
