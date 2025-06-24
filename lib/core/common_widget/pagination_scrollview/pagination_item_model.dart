sealed class PaginationItemModel {}

final class PaginationItemModelInitial extends PaginationItemModel {}

final class PaginationItemModelLoading extends PaginationItemModel {}

final class PaginationItemModelData<T> extends PaginationItemModel {
  final T data;

  PaginationItemModelData({required this.data});
}
