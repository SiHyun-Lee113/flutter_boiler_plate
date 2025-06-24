import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boiler_plate/core/common_widget/pagination_scrollview/pagination_bloc.dart';
import 'package:flutter_boiler_plate/core/common_widget/pagination_scrollview/pagination_event.dart';
import 'package:flutter_boiler_plate/core/common_widget/pagination_scrollview/pagination_state.dart';

class PaginationScrollView<T> extends StatefulWidget {
  final Widget Function(BuildContext, T) itemBuilder;
  final PaginationBloc<T> bloc;

  const PaginationScrollView({
    super.key,
    required this.itemBuilder,
    required this.bloc,
  });

  @override
  State<PaginationScrollView<T>> createState() =>
      _PaginationScrollViewState<T>();
}

class _PaginationScrollViewState<T> extends State<PaginationScrollView<T>> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    widget.bloc.add(PaginationFetch());

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        widget.bloc.add(PaginationFetch());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaginationBloc<T>, PaginationState<T>>(
      bloc: widget.bloc,
      builder: (context, state) {
        if (state is PaginationInitial<T> ||
            state is PaginationLoading<T> && widget.bloc.currentPage == 1) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PaginationLoaded<T>) {
          return RefreshIndicator(
            onRefresh: () async {
              widget.bloc.add(PaginationRefresh());
            },
            child: ListView.builder(
              controller: _scrollController,
              itemCount: state.hasReachedEnd
                  ? state.items.length
                  : state.items.length + 1,
              itemBuilder: (context, index) {
                if (index < state.items.length) {
                  return widget.itemBuilder(context, state.items[index]);
                } else {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
              },
            ),
          );
        } else if (state is PaginationError<T>) {
          return Center(child: Text("에러: ${state.message}"));
        } else {
          return const SizedBox();
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
