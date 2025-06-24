import 'package:flutter_boiler_plate/core/common_widget/pagination_scrollview/pagination_event.dart';
import 'package:flutter_boiler_plate/core/common_widget/pagination_scrollview/pagination_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef FetchPage<T> = Future<List<T>> Function(int page);

class PaginationBloc<T> extends Bloc<PaginationEvent, PaginationState<T>> {
  final FetchPage<T> fetchPage;
  final int pageSize;

  int currentPage = 1;
  bool _hasReachedEnd = false;
  List<T> _items = [];

  PaginationBloc({
    required this.fetchPage,
    this.pageSize = 20,
  }) : super(PaginationInitial<T>()) {
    on<PaginationFetch>(_onFetch);
    on<PaginationRefresh>(_onRefresh);
  }

  Future<void> _onFetch(
      PaginationFetch event, Emitter<PaginationState<T>> emit) async {
    if (_hasReachedEnd) return;

    if (state is PaginationLoading) return;

    emit(PaginationLoading<T>());

    try {
      final newItems = await fetchPage(currentPage);

      if (newItems.length < pageSize) {
        _hasReachedEnd = true;
      }

      _items.addAll(newItems);
      currentPage++;

      emit(PaginationLoaded<T>(
        items: _items,
        hasReachedEnd: _hasReachedEnd,
      ));
    } catch (e) {
      emit(PaginationError<T>(message: e.toString()));
    }
  }

  Future<void> _onRefresh(
      PaginationRefresh event, Emitter<PaginationState<T>> emit) async {
    _items = [];
    currentPage = 1;
    _hasReachedEnd = false;
    add(PaginationFetch());
  }
}
