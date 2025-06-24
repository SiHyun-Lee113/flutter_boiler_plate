abstract class PaginationState<T> {}

class PaginationInitial<T> extends PaginationState<T> {}

class PaginationLoading<T> extends PaginationState<T> {}

class PaginationLoaded<T> extends PaginationState<T> {
  final List<T> items;
  final bool hasReachedEnd;

  PaginationLoaded({required this.items, required this.hasReachedEnd});
}

class PaginationError<T> extends PaginationState<T> {
  final String message;

  PaginationError({required this.message});
}
