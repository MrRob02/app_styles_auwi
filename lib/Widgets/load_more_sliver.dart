import 'dart:math';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class LoadMoreSliver<T> extends StatefulWidget {
  final int totalElements;
  final List<T> items;
  final SliverGridDelegate? gridDelegate;
  final ScrollController controller;
  final Future Function(int page) fetchPage;
  final Widget? Function(BuildContext context, int index) itemBuilder;
  final Widget Function(BuildContext context, int index)? separatorBuilder;
  const LoadMoreSliver.list(
      {super.key,
      required this.totalElements,
      required this.fetchPage,
      required this.itemBuilder,
      this.separatorBuilder,
      required this.items,
      required this.controller})
      : gridDelegate = null;

  const LoadMoreSliver.grid(
      {super.key,
      required this.totalElements,
      required this.fetchPage,
      required this.itemBuilder,
      required this.items,
      required this.controller,
      this.separatorBuilder,
      required SliverGridDelegate this.gridDelegate});

  @override
  State<LoadMoreSliver> createState() => _LoadMoreSliverState();
}

class _LoadMoreSliverState extends State<LoadMoreSliver> {
  bool isLoading = false;
  int get totalActual => widget.items.length;
  final _searchSubject = PublishSubject<int>();
  int actualPage = 1;

  ScrollController get controller => widget.controller;
  @override
  void initState() {
    _searchSubject.distinct().listen(fetchNewPage);
    widget.controller.addListener(_onScroll);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final gridDelegate = widget.gridDelegate;
    if (gridDelegate == null) {
      return SliverList(
        delegate: _builderDelegate(),
      );
    } else {
      return SliverGrid(
        delegate: _builderDelegate(),
        gridDelegate: gridDelegate,
      );
    }
  }

  SliverChildBuilderDelegate _builderDelegate() {
    return SliverChildBuilderDelegate(
      (context, index) {
        if (index < totalActual) {
          return widget.itemBuilder(context, index);
        } else if (index == totalActual) {
          return AnimatedSize(
            duration: const Duration(milliseconds: 500),
            child: () {
              return const SizedBox.square(
                  dimension: 100,
                  child: Center(
                    child: SizedBox.square(
                        dimension: 25, child: CircularProgressIndicator()),
                  ));
            }(),
          );
        }
        return null;
      },
      childCount: min(totalActual + 1, widget.totalElements),
    );
  }

  bool get isAtEnd =>
      widget.controller.position.pixels >=
      widget.controller.position.maxScrollExtent;

  void _onScroll() async {
    if (!isAtEnd || isLoading || widget.totalElements == totalActual) return;
    _searchSubject.add(actualPage + 1);
  }

  void fetchNewPage(page) async {
    isLoading = true;
    debugPrint('fetching... actual page: $page');
    await widget.fetchPage(page);
    actualPage = page;
    //? Este delay se coloca para que le de tiempo a la pantalla de pintar los nuevos
    //? elementos antes de que se llame a otra pagina
    Future.delayed(const Duration(milliseconds: 500), () {
      isLoading = false;
    });
  }
}
